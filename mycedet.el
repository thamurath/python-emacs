

(require 'xcscope)
;;=============================================
;;  CEDET
;;=============================================

;; (defun setup-integrated-cedet()
  ;; (if (boundp 'cedet-info-dir)
  ;;     (add-to-list 'Info-default-directory-list cedet-info-dir))

  ;; (if (boundp 'cedet-lib)
  ;;     (load-file cedet-lib))

  ;; (semantic-mode 1)

  ;; (global-ede-mode t)

  ;; (if (boundp 'semantic-load-enable-excessive-code-helpers)
  ;;                                       ; Add-on CEDET
  ;;     (progn
  ;;       (semantic-load-enable-excessive-code-helpers)
  ;;                                       ; TODO: should already be enabled by previous line
  ;;       (global-semantic-idle-completions-mode)
  ;;       (global-semantic-tag-folding-mode))
  ;;                                       ; Integrated CEDET
  ;;   (setq semantic-default-submodes
  ;;         '(global-semanticdb-minor-mode
  ;;           global-semantic-idle-scheduler-mode
  ;;           global-semantic-idle-summary-mode
  ;;           global-semantic-idle-completions-mode
  ;;           global-semantic-decoration-mode
  ;;           global-semantic-highlight-func-mode
  ;;           global-semantic-stickyfunc-mode)))

  ;; (if (boundp 'semantic-ia) (require 'semantic-ia))
  ;; (if (boundp 'semantic-gcc) (require 'semantic-gcc))
;; )


;; (defun setup-external-cedet()
;;   ;; con esto cargamos el cedet
;;   (load-file "~/.emacs.d/vendor/cedet/common/cedet.el")

;;   ;;habilitamos el modo semantico
;;   ;;(semantic-mode 1)
;;   ;; Elegimos el modo con mas informacion para el Semantic
;;   ;;(select only one)
;;   ;;(semantic-load-enable-minimum-features)
;;   ;;(semantic-load-enable-code-helpers)
;;   ;;(semantic-load-enable-gaudy-code-helpers)
;;   ;;(semantic-load-enable-all-exuberent-ctags-support)
;;   (semantic-load-enable-excessive-code-helpers)

;;   ;; Habilitamos el modo mru (Most Recent Used)
;;   ;;para que se acuerde de que tags visitamos y podamos volver luego
;;   (global-semantic-mru-bookmark-mode 1)

;;   ;; Habilitamos el minor-mode para que parsee los includes ( creo )
;;   (require 'semantic-decorate-include)

;;   ;; Habilitamos el paquete semantic-ia para poder tener informacion adicional sobre los objetos
;;   (require 'semantic-ia)

;;   ;; Habilitamos el paquete semantic-gcc para que cedet pregunte a gcc por los system headers y los parsee.
;;   (require 'semantic-gcc)

;;   ;; Esta es otra herramienta que ofrece otras habilidades ...
;;   (require 'eassist)

;;   ;; Esto sirve para delimitar el ambito de la busqueda de simbolos
;;   (setq-mode-local c-mode semanticdb-find-default-throttle
;;                    '(project unloaded system recursive))
;;   (setq-mode-local c++-mode semanticdb-find-default-throttle
;;                    '(project unloaded system recursive))
;;   (setq-mode-local erlang-mode semanticdb-find-default-throttle
;;                    '(project unloaded system recursive))

;;   ;; Esto no tengo del todo claro para que puede ser .
;;   ;; (custom-set-variables
;;   ;;   '(semantic-idle-scheduler-idle-time 3)
;;   ;;   '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;;   ;;   '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;;   ;; (global-semantic-folding-mode 1)

;;   ;; Si queremos podemos poner directorios de include adicionales de la siguiente manera.
;;   ;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)


;;   ;; Opciones varias de Semantic
;;   ;; Esto no tengo muy claro para que es...
;;   ;; (semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))

;;                                         ;Display a tag summary of the lexical token under the cursor.
;;   (global-semantic-idle-summary-mode 1)

;;   ;;que empiece parsear cuando lleve 1 segundo parado
;;   (setq semantic-idle-scheduler-idle-time 1)

;;   ;; Algunas opciones que de momento dejamos comentadas ...

;;   ;;(global-semantic-idle-scheduler-mode 1) ;The idle scheduler with automatically reparse buffers in idle time.
;;   ;;(global-semantic-idle-completions-mode nil) ;Display a tooltip with a list of possible completions near the cursor.

;; ;;;(semantic-idle-scheduler-idle-time 1)
;;   ;;(global-semantic-folding-mode 1)  ;; Habilitamos el folding del codigo segun semantic



;;                                         ; Definicion de las teclas para cedet
;;   (global-set-key "\C-cg" 'semantic-ia-fast-jump)
;;   (global-set-key "\C-cd" 'semantic-analyze-proto-impl-toggle)
;;   (global-set-key "\C-ci" 'semantic-decoration-include-visit)
;;   (global-set-key "\C-ct" 'semantic-symref)
;;   (global-set-key "\C-cl" 'goto-line)
;;   (global-set-key "\C-ca" 'eassist-switch-h-cpp)
;;   (global-set-key "\C-cb" 'semantic-mrub-switch-tags)
;;   (global-set-key "\C-ch" 'highlight-symbol-at-point)


;;   ;;Habilitar semanticDB
;;   (require 'semanticdb)
;;   (global-semanticdb-minor-mode 1)

;;   ;; Con esto activamos el soporte a cscope mediante cedet
;;   ;; (semanticdb-enable-cscope-databases)
;;   ;;make all the 'semantic.cache' files go somewhere sane
;;   (setq semanticdb-default-save-directory "~/emacs-meta/semantic.cache/")

;;   ;; Esto se supone que debe darme soporte para cscope




;;   (require 'xcscope)

;;   )

;; (setq integrated-cedet-p (and (>= emacs-major-version 23)
;;                               (>= emacs-minor-version 2)))

;; ;; (if integrated-cedet-p
;;     ;; (setup-integrated-cedet )
;;   ;; setup-external-cedet)
;; (require 'xcscope)

