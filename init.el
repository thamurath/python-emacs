;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Library Paths
;; Note: I like to keep every emacs library underneath
;;   ~/.emacs.d and I shun loading them from the system
;;   paths. This makes it easier to use this config on
;;   multiple systems.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d")
;Add all top-level subdirectories of .emacs.d to the load path
(progn (cd "~/.emacs.d")
       (normal-top-level-add-subdirs-to-load-path))
;I like to keep third party libraries seperate in ~/.emacs.d/vendor
(add-to-list 'load-path "~/.emacs.d/vendor")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))


;; Cargamos utilidad para que se reutilicen los buffers del dired
(require 'dired-single)

;; Cargamos utilidad para "mejorar" el page up down
(require 'pager)

;; Cargamos la libreria para realizar autocompletado
(require 'auto-complete)

;; Cargamos una libreria que nos permite abrir ficheros como root (ojo keybingins)
(load-library "open-file-root.el")

;; Cargamos las modificaciones a la navegacion (ojo, keybinfings)
(load-library "navigation.el")

;; Cargamos todas las modificaciones visuales
(load-library "visual-niceties.el")

;; Cargamos los visual bookmarks
(load-library "visual-bookmarks.el")

;; Cargamos las utilidades varias.
(load-library "utilities.el")

;; Cargamos esto sirve para tuner un poco el flyspell
(load-library "myflyspell.el")

;; Cargamos los keybingdings
(load-library "keyboard.el")

;; Cargamos los keybingdings
(load-library "myyasnippet.el")


