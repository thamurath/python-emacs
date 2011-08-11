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
;;(load-library "myflyspell.el")

;; Cargamos los keybingdings
(load-library "keyboard.el")

;; Cargamos algunas cosillas varias
(load-library "my-misc-features.el")

;; Cargamos los keybingdings
(load-library "myyasnippet.el")

;; Cargamos todas las configuraciones necesarias para trabajar con c y c++
;; configuracion del modo, cedet , ede , etc ...
(load-library "CC-configuration.el")


;; Cargamos todas las configuraciones necesarias para trabajar con python
(load-library "python-configuration.el")

;; Cargamos la configuracion para el Git
(load-library "my-magit.el")
;; Cargamos tambien la configuracion de este otro modulo que da soporte para annotate en git (magit no tiene)
(load-library "my-mo-git-blame.el")

;; Cargamos configuracion de shel
(load-library "my-shell.el")


;; Cargamos la configuracion de autocompletado
(load-library "my-autocomplete.el")


;; Configuracion para que no abra nuevos buffers cuando utlizamos el dired
(load-library "my-dired.el")

;; Alguna configuracion para el modo lisp.
(load-library "my-lisp.el")


;; Cargamos la config del navegador web en modo texto
(load-library "my-w3m.el")


;; Cargamos la config del modo nXML (un nuevo modo)
(load-library "my-nxml.el")


;; Configuracion del CUA mode por la seleccion rectangular
(load-library "my-cua-mode.el")

;;Cmake-mode
(load-library "cmake-config.el")
