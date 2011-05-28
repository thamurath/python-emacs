;;=========================================
;;  GDB settings
;;=========================================

;; Si esta variable no es nil deberian mostrarse las ventanas al ejecutar gdb
(setq gdb-many-windows 1)
;; Si esta variable es nil los buffers de comandos no apareceran
;; (setq gdb-use-separate-io-buffer nil)

;; Es comando gdb-restore-windows restaura las ventanas por defecto
;; El comando gdb-many-windows permite cambiar en el el layout normal de gdb y el de ventanas
;; Si queremos terminar la sesion de depuracion podemos matar el buffer de comandos de gdb con C-x k
;; Esto terminara con todos los demas buffers asociados. No es necesario matar si queremos seguir despues de
;; hacer alguna modificacion. Si no lo matamos mantendra los breakpoints y otros datos.

;; si la variable gdb-find-source-frame no es nil y gdb se para en un sitio de donde no tiene codigo
;; la ventana de codigo mostrara el frame mas cercano del que si que tenga codigo

;; Si la variable gdb-delete-out-of-scope no es nil, gdb mantendra los watch aunque la variable salga de scope.

