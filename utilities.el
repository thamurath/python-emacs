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
