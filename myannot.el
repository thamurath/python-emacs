;; Es una extension para poder poner notas en emacs. No cambia los ficheros asi que puede estar interesante.
;; Para mas informacion http://code.google.com/p/annot
(progn
  (defun sniff-annot()
    (display-command-information "annot-"))
  (require 'annot)
  (add-hook 'pre-command-hook 'sniff-annot)
)

;; key bindings
(global-set-key "\C-xna" 'annot-edit/add)
(global-set-key "\C-xnr" 'annot-remove)

;; (define-key ctl-x-map "n a"    'annot-edit/add)
;; ;;(define-key ctl-x-map "\C-a" 'annot-edit/add)
;; (define-key ctl-x-map "n r"    'annot-remove)
