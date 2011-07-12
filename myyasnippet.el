;;Hay dos metodos de inicializacion segun la documentacion.
;;0.- Este es el que viene en el propio fichero yasnippet.el
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; ;;1.- Quick and dirtie
;; (add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
;; (require 'yasnippet-bundle)


;; ;;2.- normal
;; (add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/snippets")


;; 3.- El que tenia yo antes
;; (add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/snippets")
;; (setq yas/root-directory "~/.emacs.d/snippets")
;; (yas/load-directory yas/root-directory)


;; ;Don't map TAB to yasnippet
;; ;In fact, set it to something we'll never use because
;; ;we'll only ever trigger it indirectly.
;; (setq yas/trigger-key (kbd "C-c <kp-multiply>"))


