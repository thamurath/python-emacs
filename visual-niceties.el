;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual Nicities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ponemos el tema de color que queremos
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-zenburn)
   )
)

;; esto es para que se active el resaltado de codigo para todos los modos en los que este disponible
(global-font-lock-mode 1)


;; con esto deberia poner los numeros de linea
(global-linum-mode 1)
(setq linum-format "%d ") ; esto deberia poner un espacio detras del numero
;; con esto deberia mostrar tb la columna.
(column-number-mode 't)

;;Ilumina la linea actual
(global-hl-line-mode 1)


;;Para activar el realzado de las coincidencias encontradas hasta el momento en las búsquedas,
;;debemos poner las siguientes sentencias:
(setq search-highlight t)
(setq query-replace-highlight t)

;; para que la "campana" sea visual
(setq visible-bell 1)



;; Para que se muestre la hora en la barra de estado en formato 24h
(setq display-time-day-and-date t)
(setq display-time-interval 30)
(setq display-time-24hr-format t)
;; Para que se muestre el tiempo en la barra de estado ( o modo)
;; OJO -> Primero hay que modificar las variables que afecten al modo y luego activarlo!!!
(display-time-mode t)

;; Esto se supone que es para que resalte los pares de parentesis y esas cosas
(require 'paren)
(show-paren-mode 1)

;; ;Disable the menubar (promotes good emacs memory :)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;Line by line scrolling
(setq scroll-step 1)

;;Quitamos el mensaje inicial
(setq inhibit-startup-message t)

;;Autofill mode
;;Cuando escribimos un fichero fuente o cuando escribimos un fichero de texto suele ser interesante que el editor decida
;;cuando no caben más palabras en en la línea actual y pase a la siguiente. Esta funcionalidad en emacs se conoce como
;;"auto-fill". Con la siguiente sentencia indicamos que la columna donde deben terminar las líneas es la 80 y que debe
;;activar el modo "auto-fill" para todos los modos derivados del modo de texto y en los modos para C y C++:
(setq default-fill-column 120 )
(setq auto-fill-mode 1)  ;; con esto pondriamos el modo activo para todos
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'python-mode-hook 'turn-on-auto-fill)

;Show newlines at end of file
(define-fringe-bitmap 'empty-line [0 0 #x3c #x3c #x3c #x3c 0 0])
(set-default 'indicate-empty-lines nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Increase/Decrease font size on the fly
;;; Taken from: http://is.gd/iaAo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'increase-font-size)
(global-set-key (kbd "C--") 'decrease-font-size)


;; Muestra la batería del porti
(display-battery-mode)



;; La barra del título muestra el nombre del buffer actual
(setq frame-title-format '("emacs: %*%+ %b"))
