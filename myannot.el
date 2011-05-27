;; Es una extension para poder poner notas en emacs. No cambia los ficheros asi que puede estar interesante.
;; Para mas informacion http://code.google.com/p/annot
(progn 
  (defun sniff-annot()
    (display-command-information "annot-"))
  (require 'annot)
  (add-hook 'pre-command-hook 'sniff-annot)
)