;;----------------------------------------------          
;; Funcion para modificaciones tipicas de C y C++ ( vamos de todos los modos C ) 
;;----------------------------------------------
(defun cc-code-layout-hook ()
  
  ;; --------
  ;; primero definimos el estilo que usaremos como 
  ;; --------
  (c-set-style "bsd")
  ;; ------
  ;; Ahora ponemos las modificaciones que creamos oportunas
  ;; ------
  ;; coloca en la misma columna todas las lineas de herencia de una clase
  (c-set-offset 'inher-cont 'c-lineup-multi-inher) 
  (c-set-offset 'topmost-intro-cont 'c-lineup-multi-inher) ;;este es el simbolo que me aparece en las lineas de herencia.
  ;; indenta correctamente el primer parametro de la llamada a una funcion si esta en otra linea
  (c-set-offset 'arglist-intro 'c-lineup-arglist-intro-after-paren)
  ;; indenta los siguientes parametros de la llamada a una funcion, poniendolos en la 
  ;; misma columna que el ultimo que se indento
  (c-set-offset 'arglist-cont 'c-lineup-arglist)
  ;; indenta el parentesis de cierre de la llamada a una funcion poniendolo en la misma columna que el de apertura
  (c-set-offset 'arglist-close 'c-lineup-close-paren)
  ;; Alinea los operadores >> y << de los streams.
  (c-set-offset 'stream-op 'c-lineup-streamop)
  ;; Para indentar las macros de manera que los \ del final queden en la misma columna
  (c-set-offset 'cpp-define-intro 'c-lineup-cpp-define)


  ;; Esto deberia alinear las cadenas con multiples lineas una debajo de la siguiente.
  (c-set-offset 'statment-cont 'c-lineup-string-cont)
  (c-set-offset 'top-most-intro-cont 'c-lineup-string-cont)
  (c-set-offset 'arglist-cont 'c-lineup-string-cont)

  ;;switch/case:  make each case line indent from switch
  (c-set-offset 'case-label '+)

  ;; esto es para que alinee los comentarios de estito C ... pero no lo tengo claro
  (c-set-offset 'c 'c-lineup-C-comments)

  ;; Esta variable tiene una lista donde se ponen los distintos ':'  que obligan a insertar un retorno de 
  ;; carro y cuando ( before and/or after - tambien se puede dejar sin nada lo que quiere decir que no pone ninguno 
  ;; ni antes ni despues )
  ;; (setq c-hanging-colons-alist     . ((member-init-intro after) ;; que ponga una nueva linea despues 
  ;;                                                          ;;de los : de la lista de inicializacion.
  ;;                                (member-init-cont before after)  ;; idem pero para todos los demas
  ;;                                (inher-intro after)
  ;;                                (case-label after)
  ;;                                (label after)
  ;;                                (access-label after)
  ;;                               )
  ;;  )
  
  
  ;;
  ;;---------- fin de las modificaciones de estilo



  ;; key bindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
  (define-key c-mode-base-map (kbd "C-m") 'c-context-line-break)
                                        ;(define-key c-mode-base-map (kbd "C-m") 'newline-and-indent)
  ;; Asignamos el retorno de carro al newline-and-indent para que las nuevas lineas las inserte indentadas directamente
  ;;(define-key c-mode-map (kbd "C-m") 'newline-and-indent)
  ;;(define-key c++-mode-map (kbd "C-m") 'newline-and-indent)
  
  ;; Indentacion:
  (setq c-basic-offset 2) ;; numero de columnas que se indenta el codigo
  ;; Definimos el formato estandar del codigo. Para todos los modos relativos de C que no son pocos.
  


  ;; Utilizamos espacios para indentar
  (setq indent-tabs-mode nil)
  ;; No sangra si estamos en literales
  (setq c-tab-always-indent "other")
  
  ;; we like auto-newline and hungry-delete ( borra todos los espacios/tabuladores que esten juntos)
  (c-toggle-auto-hungry-state 1)

  ;; PAra que no inserte una nueva linea despues de ; 
  ;; hay que ponerla la ultima porque alguna de las anteriores es la que esta haciendo que esto se active
  (c-toggle-auto-newline -1)
  )
(add-hook 'c-mode-common-hook 'cc-code-layout-hook)