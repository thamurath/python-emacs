
;; Primero nos aseguramos de que tenemos el modo activo.
(require 'cc-mode)

;; Cargamos la configuracion del layout del codigo
(load-library "cc-code-layout.el")

;; Cargamos la configuracion de CEDET
(load-library "mycedet.el")

;; Cargamos la configuracion del gestor de proyectos de cedet
(load-library "myede.el")

;; Cargamos la configuracion para la integracion de doxygen en emacs
(load-library "mydoxymacs.el")

;; Cargamos la configuracion para integracion con gccsense
(load-library "mygccsense.el")

;; Cargamos la configuracion para integracion de gdb
(load-library "gdb-settings.el")

;; Aqui es donde tenemos los proyectos
(load-library "myprojects.el")
