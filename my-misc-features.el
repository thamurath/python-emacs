;;;;;;;;;;;;;;;;;;;;;;;;;
;Reload .emacs on the fly
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reload-dot-emacs()
  (interactive)
  (if(bufferp (get-file-buffer "init.el"))
      (save-buffer(get-buffer "init.el")))
  (load-file "~/.emacs.d/init.el")
  (message ".emacs reloaded successfully"))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;Place all backup copies of files in a common location
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst use-backup-dir t)
(setq backup-directory-alist (quote ((".*" . "~/emacs-meta/backups/")))
      version-control t                ; Use version numbers for backups
      kept-new-versions 16             ; Number of newest versions to keep
      kept-old-versions 2              ; Number of oldest versions to keep
      delete-old-versions t            ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t) ; Copy linked files, don't rename.

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Read MS Word docs ;)
;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'no-word)
;(add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))

;; ?????
;; (put 'set-goal-column 'disabled nil)
;; (put 'upcase-region 'disabled nil)

;Always end files with a newline
;Never put tabs in files, use spaces instead
;Note: Use C-q C-i to put a real tab should the need ever arise.
(setq-default indent-tabs-mode nil)


;;;;;;;;;;;;;;;;;;;;;;;;;
; Ask before quitting emacs
;;;;;;;;;;;;;;;;;;;;;;;;;
;I have a nasty habit of quitting Emacs all the time
;Always ask me if I really want to quit Emacs
;(defadvice save-buffers-kill-emacs (before save-logs (arg) activate))
(defun ask-before-quit ()
  "Ask me before I quit emacs if I think that's a good thing to do"
  (interactive)
  (yes-or-no-p "Do you really want to quit Emacs?")
)
(add-hook 'kill-emacs-query-functions 'ask-before-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;Allow fetching files from HTTP servers
;;;;;;;;;;;;;;;;;;;;;;;;;
(url-handler-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;TRAMP should default to ssh
;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)
(setq tramp-default-method "ssh")

;;;;;;;;;;;;;;;;;;;;;;;;;
;; deleting files goes to OS's trash folder
;;;;;;;;;;;;;;;;;;;;;;;;;
(setq delete-by-moving-to-trash t) ; "t" for true, "nil" for false

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make copy and paste to work with other programs
;;;;;;;;;;;;;;;;;;;;;;;;;
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Que pregunte si queremos añadir una nueva linea al final del fichero
(setq require-final-newline 'ask)
;;But don't add the newline until we save
(setq next-line-add-newlines nil)


;; La rueda del ratón es para algo
(cond (window-system
       (mwheel-install)
       ))

;; i want a mouse yank to be inserted where the point is, not where i click
mouse-yank-at-point t


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reload all buffers from their files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      ;; (when (and (buffer-file-name) (not (buffer-modified-p)))
      (when (buffer-file-name)
        (revert-buffer t t t)
      )
     )
  )
  (message "Refreshed open files.") )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Permite ir a la "ventana" anterior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun back-window ()
    (interactive)
      (other-window -1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Permite moverse libremente entre los buffers
;;; en lugar de tener que usar el C-x o
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Windmove is a library built into GnuEmacs starting with version 21. 
;;It lets you move point from window to window using Shift and the arrow keys. 
;;This is easier to type than ‘C-x o’ and, for some users, may be more intuitive. 
;;To activate all these keybindings, add the following to your init file:

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;The ‘fbound’ test is for those XEmacs installations that don’t have the windmove package available.
;;If you are a PcSelectionMode or CuaMode user, however, you will need to use your own keybindings, since shift plus arrow keys are used to extend the selection. For CuaMode it may be natural to use
;;(windmove-default-keybindings 'meta)
;;This will override ‘M-left’ and ‘M-right’ but these are duplicated by ‘C-left’ and ‘C-right’ which are probably more natural for a CuaMode user.
;;Some terminals do not support modified arrow keys. To use a prefix instead of a modifier, add something like the following to your init file.
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
