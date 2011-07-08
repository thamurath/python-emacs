(add-to-list 'load-path "~/.emacs.d/vendor/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/autocomplete//ac-dict")
(ac-config-default)


;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/autocomplete/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; 
;; (add-to-list 'ac-dictionary-directories "/home/eojojos/.emacs.d/vendor/autocomplete/ac-dict")
;; (require 'auto-complete-config)
;; (ac-config-default)

;; ;;=============================================
;; ;; auto-complete mode
;; ;;=============================================
;; ;; Configuracion que recomienda el proceso de instalacion de la herramienta.
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "/home/eojojos/.emacs.d/vendor/autocomplete/ac-dicts")

;; ;; Esto hace que el autocompletado salte solo o no (nil)
;; ;; t significa que comience de manera automatica
;; ;;Cuando no vale nil es el numero de caracteres que hay que escribir para que salte el autocomplete
;; (setq ac-auto-start 2)
;; (setq ac-auto-show-menu 0.5)

;; ;;Esto hace que con el tabulador salte el autocompletado.
;; (ac-set-trigger-key "TAB")

;; ;; configuramos Ctrl-n y Ctrl-p para que se comporten para seleccionar los candidatos pero solo cuando este el menu.
;; (setq ac-use-menu-map t)
;; ;; Default settings
;; (define-key ac-menu-map "\C-n" 'ac-next)
;; (define-key ac-menu-map "\C-p" 'ac-previous)
;; (global-set-key "\M-/" 'auto-complete)
;;                                         ; Se supone que esto es para que muestre la ayuda, pero no se si funciona porque no me muestra nada de nada.
;; (setq ac-use-quick-help t)
;;                                         ; Delay en segundos para mostrar la ayuda en el autocompletado.
;; (setq ac-quick-help-delay 1)

;;                                         ;Algunas teclas para mostrar la ayuda.
;;                                         ;(define-key ac-mode-map (kbd "C-c h") 'ac-last-quick-help)
;; ;;(define-key ac-mode-map (kbd "C-c H") 'ac-last-help)

;; ;; A;adimos semantic para las fuentes en el modo c y c++
;; (add-hook 'c++-mode (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))
;; (add-hook 'c-mode (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))
;; (add-hook 'cc-mode (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))





;; ;; Case configuration
;; ;; Ignore case if completion target string doesn't include upper characters
;; (setq ac-ignore-case 'smart)


;; ;;(add-hook 'c-mode-common-hook '(lambda ()
;; ;;                                 ;; ac-omni-completion-sources is made buffer local so
;; ;;                                 ;; you need to add it to a mode hook to activate on
;; ;;                                 ;; whatever buffer you want to use it with.  This
;; ;;                                 ;; example uses C mode (as you probably surmised).
;; ;;                                 ;; auto-complete.el expects ac-omni-completion-sources to be
;; ;;                                 ;; a list of cons cells where each cell's car is a regex
;; ;;                                 ;; that describes the syntactical bits you want AutoComplete
;; ;;                                 ;; to be aware of. The cdr of each cell is the source that will
;; ;;                                 ;; supply the completion data.  The following tells autocomplete
;; ;;                                 ;; to begin completion when you type in a . or a ->
;; ;;                                 ;;(add-to-list 'ac-omni-completion-sources
;; ;;                                 ;;             (cons "\\." '(ac-source-clang-complete)))
;; ;;                                 ;;(add-to-list 'ac-omni-completion-sources
;; ;;                                 ;;             (cons "->" '(ac-source-clang-complete)))
;; ;;                                 ;;(add-to-list 'ac-omni-completion-sources
;; ;;                                 ;;             (cons "\\:" '(ac-source-clang-complete)))
;; ;;                                 (add-to-list 'ac-omni-completion-sources
;; ;;                                              (cons "\\." '(ac-source-semantic)))
;; ;;                                 (add-to-list 'ac-omni-completion-sources
;; ;;                                              (cons "->" '(ac-source-semantic)))
;; ;;                                 (add-to-list 'ac-omni-completion-sources
;; ;;                                              (cons "\\:" '(ac-source-semantic)))
;; ;;                                 ;; ac-sources was also made buffer local in new versions of
;; ;;                                 ;; autocomplete.  In my case, I want AutoComplete to use
;; ;;                                 ;; semantic and yasnippet (order matters, if reversed snippets
;; ;;                                 ;; will appear before semantic tag completions).
;; ;;                                 ;; (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
;; ;;                                 ;;(setq ac-sources '(ac-source-clang-complete))
;; ;;                                 )
;; ;;         )
;; ;;
;; ;; Esto es porque tendremos configurado el flymake para no liarla.
;; ;;(ac-flyspell-workaround)



;; ;; definicion de las fuentes

;; ;; primero definimos las fuentes por defecto
;; ;;
;; (setq-default ac-sources '(ac-source-filename
;;                            ac-source-words-in-buffer
;;                            ac-source-words-in-all-buffer
;;                            )
;;               )


;; (defun my-ac-emacs-lisp-mode ()
;;   (setq ac-sources '(
;;                      ac-source-symbols
;;                      ac-source-variables
;;                      ac-source-functions
;;                      ac-source-features
;;                      ac-source-yasnippet
;;                      )
;;   )
;; )
;; (add-hook 'emacs-lisp-mode-hook 'my-ac-emacs-lisp-mode)

;; (defun my-ac-cc-mode()
;;   (auto-complete-mode 1)
;;   (setq ac-sources '(
;;                      ac-source-filename
;;                      ac-source-semantic
;;                      ac-source-semantic-raw
;;                      ac-source-yasnippet
;;                      ))
;; )
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode)


;; (defun my-ac-python-mode()
;;   (auto-complete-mode 1)
;;   (setq ac-sources '(
;;                      ac-source-filename
;;                      ac-source-rope
;;                      ac-source-semantic
;;                      ac-source-semantic-raw
;;                      ac-source-yasnippet
;;                      ))
;; )
;; (add-hook 'python-mode-common-hook 'my-ac-python-mode)
