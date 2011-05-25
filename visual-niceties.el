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

;;Ilumina la linea actual
(global-hl-line-mode 1)


;;Para activar el realzado de las coincidencias encontradas hasta el momento en las búsquedas, 
;;debemos poner las siguientes sentencias:
(setq search-highlight t)
(setq query-replace-highlight t)

;; para que la "campana" sea visual
(setq visible-bell 1)

;; no añade lineas vacías al final
(setq next-line-add-newlines nil)


;; Para que se muestre la hora en la barra de estado en formato 24h
(setq display-time-day-and-date t)
(setq display-time-interval 30)
(setq display-time-24hr-format t)
;; Para que se muestre el tiempo en la barra de estado ( o modo)
;; OJO -> Primero hay que modificar las variables que afecten al modo y luego activarlo!!!
(display-time-mode t)


;; ;Show what's being selected
;; (transient-mark-mode 1)
;; ;Show matching parentheses
;; (show-paren-mode 1)
;; ;Line by line scrolling
;; (setq scroll-step 1)
;; (setq inhibit-startup-message t)
;; ;Disable the menubar (promotes good emacs memory :)
;; (menu-bar-mode -1)
;; (tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; ;Make page up and page down a whole lot nicer
;; (global-set-key "\C-v"	   'pager-page-down)
;; (global-set-key [next] 	   'pager-page-down)
;; (global-set-key "\ev"	   'pager-page-up)
;; (global-set-key [prior]	   'pager-page-up)
;; (global-set-key '[M-up]    'pager-row-up)
;; (global-set-key '[M-kp-8]  'pager-row-up)
;; (global-set-key '[M-down]  'pager-row-down)
;; (global-set-key '[M-kp-2]  'pager-row-down)
;; ;Show newlines at end of file
;; (define-fringe-bitmap 'empty-line [0 0 #x3c #x3c #x3c #x3c 0 0])
;; (set-default 'indicate-empty-lines nil)

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
