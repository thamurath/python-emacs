;;;;;;;;;;;;;;;;;;;;;;;;;
;Reload .emacs on the fly
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reload-dot-emacs()
  (interactive)
  (if(bufferp (get-file-buffer ".emacs"))
      (save-buffer(get-buffer ".emacs")))
  (load-file "~/.emacs")
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