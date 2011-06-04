;; Copyright (C) 2011 David Miller <david@deadpansincerity.com>

;; Authors: David Miller <david@deadpansincerity.com>

;; Keywords: python django

;;; License

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

;;; Code:

;; Variables
(defgroup pony nil
  "Djangification for Emacs"
  :group 'programming
  :prefix "pony-")

(defcustom pony-etags-command "find . | grep .py | xargs etags"
  "Command to generate tags table for project"
  :group 'pony
  :type 'string)

(defcustom pony-server-host "localhost"
  "Host to run pony dev server"
  :group 'pony
  :type 'string)

(defcustom pony-server-port "8000"
  "Port to run pony dev server"
  :group 'pony
  :type 'string)

(defcustom pony-test-failfast t
  "Run pony tests with failfast?"
  :group 'pony
  :type 'bool)

;; Dependancies and environment sniffing
(require 'cl)
(require 'sgml-mode)

;; Utility
(defun chomp (str)
  "Chomp leading and tailing whitespace www.emacswiki.org/emacs/ElispCookbook"
  (let ((s (if (symbolp str) (symbol-name str) str)))
    (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" s)))

(defun pony-find-file (path pattern)
  "Find files matching pattern in or below path"
  (setq matches (list))
  (let ((files (list)))
    (dolist (f-or-d
             (directory-files path t "^[^\\.]"))
      (if (file-directory-p f-or-d)
          (dolist (filename (find-dot f-or-d pattern))
            (add-to-list 'files filename))
        (if (string-match pattern f-or-d)
          (add-to-list 'files f-or-d))))
    files))

;; Emacs
(defun pony-pop(buffer)
  "Wrap pop-to and get buffer"
  (pop-to-buffer (get-buffer buffer))
  (pony-mode))

(defun pony-comint-pop(name command args)
  "Make a comint buffer and pop to it."
  (ansi-color-for-comint-mode-on)
  (apply 'make-comint name command nil args)
  (pony-pop (concat "*" name "*")))

(defun pony-dir-excursion(dir &rest rest)
  "pony-comint-pop where we need to change into `dir` first"
  (let ((curdir default-directory))
     (cd dir)
     (apply 'pony-comint-pop rest)
     (cd curdir)))

(defun pony-mini-file(prompt &optional startdir)
  "Read a file from the minibuffer."
  (expand-file-name
   (read-file-name prompt
                   (or startdir
                       (expand-file-name default-directory)))))

;; WTF is this actually used for? I forget.
(defun pony-localise (var func)
  "Return buffer local varible or get & set it"
  (if (local-variable-p var)
      (symbol-value var)
    (let ((the-var (funcall func)))
      (if the-var
          (progn
            (make-local-variable var)
            (set var the-var))))))

;; Pony-mode
(defun pony-reload-mode()
  (interactive)
  (load-library "pony-mode"))

;; Python
(defun pony-get-func()
  "Get the function currently at point"
  (save-excursion
    (if (search-backward-regexp "\\(def\\)")
        (if (looking-at "[ \t]*[a-z]+[\s]\\([a-z_]+\\)\\>")
            (buffer-substring (match-beginning 1) (match-end 1))
          nil))))

(defun pony-get-class()
  "Get the class at point"
  (save-excursion
    (if (search-backward-regexp "\\(class\\)")
        (if (looking-at "[ \t]*[a-z]+[\s]\\([a-zA-Z]+\\)\\>")
            (buffer-substring (match-beginning 1) (match-end 1))
          nil))))

(defun pony-get-app()
  "Get the name of the pony app currently being edited"
  (setq fname (buffer-file-name))
  (with-temp-buffer
    (insert fname)
    (goto-char (point-min))
    (if (looking-at (concat (pony-project-root) "\\([a-z]+\\).*"))
        (buffer-substring (match-beginning 1) (match-end 1))
      nil)))

;; Environment
(defun pony-project-root()
  "Return the root of the project(dir with manage.py in) or nil"
  (pony-localise
   'pony-this-project-root
   '(lambda ()
      (let ((curdir default-directory)
            (max 10)
            (found nil))
        (while (and (not found) (> max 0))
          (progn
            (if (or (file-exists-p (concat curdir "/usr/bin/django-admin")) ; Buildout?
                    (file-exists-p (concat curdir "manage.py")))
                (progn
                  (setq found t))
              (progn
                (setq curdir (concat curdir "../"))
                (setq max (- max 1))))))
        (if found (expand-file-name curdir))))))

(defun pony-rooted-sym-p (symb)
  "Expand the concatenation of `symb` onto `pony-project-root` and determine whether
that file exists"
  (file-exists-p (concat (pony-project-root) (symbol-name symb))))

(defun pony-manage-cmd()
  "Return the current manage command
This command will only work if you run with point in a buffer that is within your project"
  (let ((found nil)
        (virtualenv '../bin/activate)
        (cmds (list 'bin/django '../bin/django 'manage.py)))
    (if (pony-rooted-sym-p virtualenv)
        ;; This is a virtualenv, we need to return the appropriate management
        ;; command, via the appropriate Python
        (concat (expand-file-name (concat (pony-project-root) "bin/python "))
                (expand-file-name (concat (pony-project-root) "manage.py")))
      ;; Otherwise, look for buildout, defaulting to the standard manage.py script
      (dolist (test cmds)
        (if (pony-rooted-sym-p (symbol-name test))
            (setq found test)))
    (if found
        (if (not (file-executable-p (expand-file-name found)))
            (message "Please make your django manage.py file executable")
          (expand-file-name (concat (pony-project-root) (symbol-name found))))))))

(defun pony-command-exists(cmd)
  "Is cmd installed in this app"
  (if (string-match cmd (shell-command-to-string (pony-manage-cmd)))
      (setq found-command t)
    Nil))

(defun pony-command-if-exists(proc-name command args)
  "Run `command` if it exists"
  (if (pony-command-exists command)
      (let ((process-buffer (concat "*" proc-name "*")))
        (progn
          (message (concat command " " args))
          (start-process proc-name process-buffer
                         (pony-manage-cmd)
                         command args)
          (pop-to-buffer (get-buffer process-buffer))))

    nil))

(defun pony-get-settings-file()
  "Return the absolute path to the pony settings file"
  (let ((settings (concat (pony-project-root) "settings.py"))
        (isfile nil))
    (if (not (file-exists-p settings))
        (message "Settings file not found")
        (setq isfile t))
    (if isfile
        settings
      nil)))

(defun pony-get-setting(setting)
  "Get the pony settings.py value for `setting`"
  (let ((settings (pony-get-settings-file))
        (python-c "python -c 'import settings; print settings.%s'")
        (working-dir default-directory)
        (set-val nil))
    (if settings
        (progn
          (cd (file-name-directory settings))
          (setq set-val (chomp (shell-command-to-string
                                (format python-c setting))))
          (cd working-dir)
          set-val))))

(defun pony-setting()
  "Interactively display a setting value in the minibuffer"
  (interactive)
  (let ((setting (read-from-minibuffer "Get setting: " (word-at-point))))
    (message (concat setting " : " (pony-get-setting setting)))))

;; Buildout
(defun pony-buildout-cmd()
  "Return the buildout command or nil if we're not in a buildout"
  (pony-localise
   'pony-this-buildout-root
   '(lambda ()
      (let ((root-parent
             (expand-file-name (concat (pony-project-root) "../"))))
        (if (file-exists-p
             (expand-file-name (concat root-parent "bin/buildout")))
            (expand-file-name (concat root-parent "bin/buildout"))
          nil)))))

(defun pony-buildout-list-bin()
  "List the commands available in the buildout bin dir"
  (directory-files (file-name-directory (pony-buildout-cmd))))

(defun pony-buildout()
  "Run buildout again on the current project"
  (interactive)
  (let ((buildout (pony-buildout-cmd))
        (cfg (concat
              (expand-file-name "../"
                                (file-name-directory (pony-buildout-cmd)))
              "buildout.cfg")))
    (if (not (file-exists-p cfg))
        (progn
          (message "couldn't find buildout.cfg")
          (setq cfg nil)))
    (if (and buildout cfg)
        (progn
          (message "Starting buildout... This may take some time")
          (pony-comint-pop
           "buildout" buildout
           (list "-c" cfg))))))


(defun pony-buildout-bin()
  "Run a script from the buildout bin/ dir"
  (interactive)
  (let ((buildout (pony-buildout-cmd)))
    (if buildout
        (pony-comint-pop "buildout"
                           (minibuffer-with-setup-hook 'minibuffer-complete
                             (completing-read "bin/: "
                                              (pony-buildout-list-bin)))
                           nil))))

;; Database
(defstruct pony-db-settings engine name user pass host)

(defun pony-get-db-settings()
  "Get Pony's database settings"
  (let ((db-settings
         (make-pony-db-settings
          :engine (pony-get-setting "DATABASE_ENGINE")
          :name (pony-get-setting "DATABASE_NAME")
          :user (pony-get-setting "DATABASE_USER")
          :pass (pony-get-setting "DATABASE_PASSWORD")
          :host (pony-get-setting "DATABASE_HOST"))))
    db-settings))

(defun pony-db-shell()
  "Run sql-XXX for this project"
  (interactive)
  (let ((db (pony-get-db-settings)))
    (progn
      (setq sql-user (pony-db-settings-user db))
      (setq sql-password (pony-db-settings-pass db))
      (setq sql-database (pony-db-settings-name db))
      (setq sql-server (pony-db-settings-host db))
      (if (equalp (pony-db-settings-engine db) "mysql")
          (sql-connect-mysql)
        (if (equalp (pony-db-settings-engine db) "sqlite3")
            (sql-connect-sqlite)
          (if (equalp (pony-db-settings-engine db) "postgresql_psycopg2")
              (sql-connect-postgres))))
      (pony-pop "*SQL*")
      (rename-buffer "*PonyDbShell*"))))


;; Fabric
(defun pony-fabric-list-commands()
  "List of all fabric commands for project as strings"
  (split-string (shell-command-to-string "fab --list | awk '{print $1}'|grep -v Available")))

(defun pony-fabric-run(cmd)
  "Run fabric command"
  (pony-comint-pop "fabric" "fab" (list cmd)))

(defun pony-fabric()
  "Run a fabric command"
  (interactive)
  (pony-fabric-run (minibuffer-with-setup-hook 'minibuffer-complete
                       (completing-read "Fabric: "
                                        (pony-fabric-list-commands)))))

(defun pony-fabric-deploy()
  "Deploy project with fab deploy"
  (interactive)
  (pony-fabric-run "deploy"))

;; GoTo
(defun pony-template-decorator()
  "Hai"
  (save-excursion
   (progn
    (search-backward-regexp "^def")
    (previous-line)
    (if (looking-at "^@.*['\"]\\([a-z/_.]+html\\).*$")
        (buffer-substring (match-beginning 1) (match-end 1))
      nil))))

(defun pony-goto-template()
  "Jump-to-template-at-point"
  (interactive)
  (let ((filename nil)
        (template
         (if (looking-at "^.*['\"]\\([a-z/_.]+html\\).*$")
             (buffer-substring (match-beginning 1) (match-end 1))
           (pony-template-decorator))))
    (if template
        (setq filename
              (expand-file-name
               template (pony-get-setting "TEMPLATE_DIRS"))))
    (if (and filename (file-exists-p filename))
        (find-file filename)
      (message (format "Template %s not found" filename)))))

(defun pony-reverse-url ()
  "Get the URL for this view"
  (interactive)
  (setq found nil)
  (setq view (concat (pony-get-app) ".views." (pony-get-func)))
  (message view)
  (dolist
   (fpath (find-file default-directory "urls.py$"))
      (setq mybuffer (get-buffer-create " myTemp"))
      (switch-to-buffer mybuffer)
      (insert-file-contents fpath)
      (search-forward view)))

(defun pony-goto-settings()
  (interactive)
  "Open the settings.py for this project"
  (find-file (pony-get-settings-file)))

;; Manage
(defun pony-list-commands()
  "List of managment commands for the current project"
  (interactive)
  (with-temp-buffer
    (insert (shell-command-to-string (pony-manage-cmd)))
    (goto-char (point-min))
    (if (looking-at
         "\\(\\(.*\n\\)*Available subcommands:\\)\n\\(\\(.*\n\\)+?\\)Usage:")
        (split-string (buffer-substring (match-beginning 3) (match-end 3)))
      nil)))

(defun pony-manage-run(args)
  "Run the pony-manage command completed from the minibuffer"
  (pony-comint-pop "ponymanage" (pony-manage-cmd) args))

(defun pony-manage()
  "Interactively call the pony manage command"
  (interactive)
  (let ((command (minibuffer-with-setup-hook 'minibuffer-complete
                              (completing-read "Manage: "
                                               (pony-list-commands)))))
    (pony-manage-run (list command
                             (read-from-minibuffer (concat command ": "))))))

(defun pony-flush()
  "Flush the app"
  (interactive)
  (pony-manage-run "flush"))

;; Fixtures
(defun pony-dumpdata()
  "Dumpdata to json"
  (interactive)
  (let ((dump (read-from-minibuffer "Dumpdata: " (pony-get-app)))
        (target (pony-mini-file "File: ")))
    (shell-command (concat
                    (pony-manage-cmd) " dumpdata " dump " > " target))
  (message (concat "Written to " target))))

(defun pony-loaddata ()
  "Load a fixture into the current project's dev database"
  (interactive)
  (let ((fixture (pony-mini-file "Fixture: ")))
    (pony-comint-pop "ponymanage" (pony-manage-cmd)
                     (list "loaddata" fixture))
    (insert (concat "Loaded fixture at " fixture))))

;; Server
(defun pony-runserver()
  "Start the dev server"
  (interactive)
  (let ((proc (get-buffer-process "*ponyserver*"))
        (working-dir default-directory))
    (if proc
        (message "Pony Dev Server already running")
      (if (pony-command-exists "runserver_plus")
          (setq command "runserver_plus")
        (setq command "runserver"))
      (progn
        (cd (pony-project-root))
        (pony-comint-pop "ponyserver" (pony-manage-cmd)
               (list command
                     (concat pony-server-host ":"  pony-server-port)))
        (cd working-dir)))))

(defun pony-stopserver()
  "Stop the dev server"
  (interactive)
  (let ((proc (get-buffer-process "*ponyserver*")))
    (when proc (kill-process proc t))))

(defun pony-temp-server ()
  "Relatively regularly during development, I need/want to set up a development
server instance either on a nonstandard (or second) port, or that will be accessible
to the outside world for some reason. Meanwhile, i don't want to set my default host to 0.0.0.0

This function allows you to run a server with a 'throwaway' host:port"
  (interactive)
  (let ((args (list "runservers" (read-from-minibuffer "host:port "))))
    (pony-comint-pop "ponytempserver" (pony-manage-cmd)
                     args)))

;; View server
(defun pony-browser()
  "Open a tab at the development server"
  (interactive)
  (let ((url "http://localhost:8000")
        (proc (get-buffer-process "*ponyserver*")))
    (if (not proc)
        (progn
          (pony-runserver)
          (sit-for 2)))
    (browse-url url)))

;; Shell
(defun pony-shell()
  "Open a shell with the current pony project's context loaded"
  (interactive)
  (if (pony-command-exists "shell_plus")
      (setq command "shell_plus")
    (setq command "shell"))
  (pony-comint-pop "ponysh" (pony-manage-cmd) (list command)))

;; Startapp
(defun pony-startapp()
  "Run the pony startapp command"
  (interactive)
  (let ((app (read-from-minibuffer "App name: ")))
    (pony-command-if-exists "ponymigrations"
                           "startapp" app)))

;; Syncdb / South
(defun pony-syncdb()
  "Run Syncdb on the current project"
  (interactive)
  (start-process "ponymigrations" "*ponymigrations*"
                 (pony-manage-cmd) "syncdb")
  (pony-pop "*ponymigrations*"))

;; (defun pony-south-get-migrations()
;;   "Get a list of migration numbers for the current app"
;; )

(defun pony-south-convert()
  "Convert an existing app to south"
  (interactive)
  (let ((app (read-from-minibuffer "Convert: " (pony-get-app))))
    (pony-command-if-exists "ponymigrations"
                              "convert_to_south" app)))

(defun pony-south-schemamigration()
  "Create migration for modification"
  (interactive)
  (let ((app (read-from-minibuffer "Migrate: " (pony-get-app))))
    (if (pony-command-exists "schemamigration")
        (progn
          (start-process "ponymigrations" "*ponymigrations*"
                         (pony-manage-cmd)
                         "schemamigration" app "--auto")
          (pony-pop "*ponymigrations*"))
      (message "South doesn't seem to be installed"))))

(defun pony-south-migrate()
  "Migrate app"
  (interactive)
  (let ((app (read-from-minibuffer "Convert: " (pony-get-app))))
    (pony-command-if-exists "ponymigrations"
                              "migrate" app)))
;; (defun pony-south-fake ()
;;   "Fake a migration for a model"
;;   (interactive)
;;   (let ((app (read-from-minibuffer "Convert: " (pony-get-app)))
;;         (migration (read-from-minibuffer "migration: "
;;                                          (pony-south-get-migrations))))
;;     (pony-command-if-exists "ponymigrations"
;;                               "migrate" (list app migrations))))

(defun pony-south-initial ()
  "Run the initial south migration for an app"
  (let ((app (read-from-minibuffer "Initial migration: " (pony-get-app))))
    (pony-command-if-exists "ponymigrations"
                              "migrate" (list app "--initial"))))


;; TAGS
(defun pony-tags()
  "Generate new tags table"
  (interactive)
  (let ((working-dir default-directory)
        (tags-dir (read-directory-name "TAGS location: "
                                       (pony-project-root))))
    (cd (expand-file-name tags-dir))
    (message "TAGging... this could take some time")
    (shell-command pony-etags-command )
    (visit-tags-table (concat tags-dir "TAGS"))
    (cd working-dir)
    (message "TAGS table regenerated")))

;; Testing
(defun pony-test()
  "Run tests here"
  (interactive)
  (let ((func (pony-get-func))
        (class (pony-get-class))
        (app (pony-get-app))
        (command nil)
        (failfast (if pony-test-failfast
                      "--failfast"
                    "")))
    (if (and func class app (string= "test" (substring func 0 4)))
        (setq command (concat app "." class "." func))
      (if (and class app)
          (setq command (concat app "." class))
        (if app
            (setq command app))))
    (if command
        (let ((confirmed-command
               (read-from-minibuffer "test: " command)))
          (pony-comint-pop "ponytests" (pony-manage-cmd)
                 (list "test" failfast confirmed-command))
          (pony-test-mode)))))

(defun pony-test-open ()
  "Open the file in a traceback at the line specified"
  (interactive)
  (move-beginning-of-line nil)
  (if (looking-at ".*File \"\\([a-z/_]+.py\\)\", line \\([0-9]+\\)")
      (let ((file (buffer-substring (match-beginning 1) (match-end 1)))
            (line (buffer-substring (match-beginning 2) (match-end 2))))
        (find-file-other-window file)
        (goto-line (string-to-number line)))
    (message "failed")))

(defun pony-test-goto-err()
  "Go to the file and line of the last stack trace in a test buffer"
  (interactive)
  (goto-char (search-backward "File"))
  (pony-test-open))

(defun pony-test-up()
  "Move up the traceback one level"
  (interactive)
  (search-backward-regexp "File \"\\([a-z_/]+.py\\)\"" nil t))

(defun pony-test-down()
  "Move up the traceback one level"
  (interactive)
  (search-forward-regexp "File \"\\([a-z_/]+.py\\)\"" nil t))

(defun pony-test-hl-files ()
  "Highlight instances of Files in Test buffers"
  (hi-lock-face-buffer "File \"\\([a-z/_]+.py\\)\", line \\([0-9]+\\)"
                       'hi-blue))
;; Modes ;;

;; Snippets

(defvar pony-snippet-dir (expand-file-name
                            (concat (file-name-directory load-file-name)
                                    "/snippets")))
(defun pony-load-snippets()
  "Load snippets if yasnippet installed"
  (interactive)
  (if (fboundp 'yas/load-directory)
      (yas/load-directory pony-snippet-dir)))

;; Keymaps

(defun pony-key(binding function)
  "Bind function to binding in pony-minor-mode-map"
  (define-key pony-minor-mode-map binding function))

(defun ponyt-key (binding function)
  "Bind for test mode. Hacky as hell"
  (define-key pony-test-minor-mode-map binding function))

(defvar pony-minor-mode-map
  (let ((map (make-keymap)))
    map))
(pony-key "\C-c\C-pb" 'pony-browser)
(pony-key "\C-c\C-pd" 'pony-db-shell)
(pony-key "\C-c\C-pf" 'pony-fabric)
(pony-key "\C-c\C-pgt" 'pony-goto-template)
(pony-key "\C-c\C-pgs" 'pony-goto-settings)
(pony-key "\C-c\C-pr" 'pony-runserver)
(pony-key "\C-c\C-pm" 'pony-manage)
(pony-key "\C-c\C-ps" 'pony-shell)
(pony-key "\C-c\C-p!" 'pony-shell)
(pony-key "\C-c\C-pt" 'pony-test)
(pony-key "\C-c\C-p\C-r" 'pony-reload-mode)

(defvar pony-test-minor-mode-map
  (let ((map (make-keymap)))
    map))

(ponyt-key "\C-c\C-g" 'pony-test-goto-err)
(ponyt-key "\C-p" 'pony-test-up)
(ponyt-key "\C-n" 'pony-test-down)
(ponyt-key (kbd "M-RET") 'pony-test-open)

;; Menu
;;
;; This will only work OOTB for emacs >=19 due to the dependency on easymenu
;; but frankly, that's fine with me.
(defvar pony-menu nil
  "The menu for Pony mode.")
(and (require 'easymenu)
     (easy-menu-define
       pony-menu pony-minor-mode-map "Pony Mode Menu"
       '("Pony"
         ;; Interactive
         ["Launch Pony shell" pony-shell]
         ["Launch Pony db shell" pony-db-shell]
         "-"
         ;; Server
         ["Run dev server for project" pony-runserver]
         ["Stop dev server for project" pony-stopserver]
         ["Launch project in browser" pony-browser]
         "-"
         ("Models"
          ["Syncdb" pony-syncdb]
          ["South convert" pony-south-convert]
          ["South Schemamigration --auto" pony-south-schemamigration]
          ["South migrate" pony-south-migrate])
         ;; Management
         "-"
         ["Run a management command" pony-manage]
         ["Dumpdata to json" pony-dumpdata]
         ["Flush App" pony-flush]
         ["Startapp" pony-startapp]
         ;; Tests
         "-"
         ["Run tests" pony-test]
         ;; Goto
         "-"
         ["Goto settings file for project" pony-goto-settings]
         ["Goto template for view or at point" pony-goto-template]
         "-"
         ["Check setting value for project" pony-setting]
         "-"
         ("Environment"
          ["Generate TAGS file" pony-tags]
          "-"
          ["Run buildout on project" pony-buildout]
          ["Run a script from buildout's bin/" pony-buildout-bin]
          "-"
          ["Run fabric function" pony-fabric]
          ["Run fabric 'deploy' function" pony-fabric-deploy])
          )))

;; Pony-minor-mode
(defvar pony-minor-mode-hook nil)

(define-minor-mode pony-minor-mode
  "Ponyriffic"
  :initial nil
  :lighter " Pony"
  :keymap pony-minor-mode-map)

(defun pony-mode()
  "Initialize Pony mode"
  (interactive)
  (pony-minor-mode t)
  (run-hooks 'pony-minor-mode-hook)
  (pony-load-snippets))

;; Pony-tpl-minor-mode

(defvar pony-tpl-mode-hook nil)

(defconst pony-tpl-font-lock-keywords
  (append
   sgml-font-lock-keywords
   (list
    '("{%.*\\(\\bor\\b\\).*%}" . (1 font-lock-builtin-face))

    '("{% ?comment ?%}\\(\n?.*?\\)+?{% ?endcomment ?%}" . font-lock-comment-face)
    '("{% ?\\(\\(end\\)?\\(extends\\|for\\|cache\\|cycle\\|filter\\|firstof\\|debug\\|if\\(changed\\|equal\\|notequal\\|\\)\\|include\\|load\\|now\\|regroup\\|spaceless\\|ssi\\|templatetag\\|widthratio\\|block\\|trans\\)\\) ?.*? ?%}" . 1)
    '("{{ ?\\(.*?\\) ?}}" . (1 font-lock-variable-name-face))
    '("{%\\|\\%}\\|{{\\|}}" . font-lock-builtin-face)
    ))
  "Highlighting for pony-tpl-mode")

(define-minor-mode pony-tpl-minor-mode
  "Pony-templatin-riffic"
  :initial nil
  :lighter " PonyTpl"
  :keymap pony-minor-mode-map)

(defun pony-tpl-mode()
  "Minor mode for editing pony templates"
  (interactive)
  (pony-tpl-minor-mode t)
  (run-hooks 'pony-tpl-mode-hook)
  (set (make-local-variable 'font-lock-defaults)
       '(pony-tpl-font-lock-keywords))
   (pony-load-snippets))

;; Pony-test minor mode

(define-minor-mode pony-test-minor-mode
  "Pony Testin'"
  :initial nil
  :lighter " DT"
  :keymap pony-test-minor-mode-map)

(defun pony-test-mode ()
  "Enable Pony test minor mode"
  (interactive)
  (pony-test-minor-mode t)
  (pony-test-hl-files))

;; Hooks

(add-hook 'python-mode-hook
          (lambda ()
            (if (pony-project-root)
                (pony-mode))))

(add-hook 'html-mode-hook
           (lambda ()
             (if (pony-project-root)
                   (pony-tpl-mode))))

(add-hook 'dired-mode-hook
          (lambda ()
            (if (pony-project-root)
                (pony-mode))))

(provide 'pony-mode)
