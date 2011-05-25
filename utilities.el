;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; uniquify!
;;;(es una herramienta para hacer que los nombres de los buffers cuyos nombers
;;;de fichero son iguales, sean mas descriptivos.
;;;Ej: Tenemos abiertos /NSdiametercom/Makefile y /NSPrelay/Makefile
;;;Normalmente tendriamos los buffers Makefile y Makefile<2>
;;;con esto deberiamos tener los buffers Makefile|NSdiametercom y Makefile|NSPrelay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


;; recentf stuff
;; Esto es una utilidad que compone una lista de los ficheros abiertos recientemente.
;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-exclude (append recentf-exclude '("/usr*")))
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(setq bookmark-save-flag 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autopair configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers
(setq autopair-autowrap t) ;;Esto es para que ponga el delimitador alrededor de una palabra que tengamos seleccionada.
(setq autopair-blink t) 

;; Para que funcione con el triple quote de python
(add-hook 'python-mode-hook
          #'(lambda ()
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))
;; Nuevos caracteres para hacer autopair en c++ ( solo en codigo )
(add-hook 'c-mode-common-hook
          #'(lambda ()
              (push '(?< . ?>)
                    (getf autopair-extra-pairs :code))))


;; Autocompletado hippie e ido
(global-set-key "\M-_ " 'hippie-expand)
;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido) 
(ido-mode 'both) ;; for buffers and files
(setq 
 ido-save-directory-list-file "~/.emacs.d/ido.last"

 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"

   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold  t                 ; be case-insensitive

 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30   ; should be enough
 ido-max-work-file-list      50   ; remember many
 ido-use-filename-at-point nil    ; don't use filename at point (annoying)
 ido-use-url-at-point nil         ; don't use url at point (annoying)

 ido-enable-flex-matching nil     ; don't try to be too smart
 ido-max-prospects 8              ; don't spam my minibuffer
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)


;; Para poder simular las busquedas de palabras bajo el cursor. Resalta la busqueda actual
(require 'highlight-symbol)
;; TODO: asignarle teclas a las funciones siguientes.

                                        ;Use C-f3 to toggle highlighting of the symbol at point throughout the current buffer. 
                                        ;Use highlight-symbol-mode to keep the symbol at point always highlighted.
                                        ;The functions highlight-symbol-next, highlight-symbol-prev, highlight-symbol-next-in-defun and
                                        ; highlight-symbol-prev-in-defun allow for cycling through the locations of any symbol at point. 
                                        ;When highlight-symbol-on-navigation-p is set, highlighting is triggered regardless of highlight-symbol-idle-delay.


;; Esta es una funcion para poder usar astyle dentro de emacs
(defun astyle-this-buffer (pmin pmax)
  (interactive "r")
  (shell-command-on-region pmin pmax
                           "astyle" ;; add options here...
                           (current-buffer) t 
                           (get-buffer-create "*Astyle Errors*") t)
  )
