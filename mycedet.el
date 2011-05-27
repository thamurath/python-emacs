;;=============================================
;;  CEDET
;;=============================================
;; con esto cargamos el cedet
(load-file "~/.emacs.d/vendor/cedet/common/cedet.el")

;;habilitamos el modo semantico
                                        ;(semantic-mode 1)
;; Elegimos el modo con mas informacion para el Semantic
                                        ;(select only one)
;;(semantic-load-enable-minimum-features)
;;(semantic-load-enable-code-helpers)
;;(semantic-load-enable-gaudy-code-helpers)
;;(semantic-load-enable-all-exuberent-ctags-support)
(semantic-load-enable-excessive-code-helpers)

;; Habilitamos el minor-mode para que parsee los includes ( creo )
(require 'semantic-decorate-include)

;; Habilitamos el paquete semantic-ia para poder tener informacion adicional sobre los objetos
(require 'semantic-ia)

;; Habilitamos el paquete semantic-gcc para que cedet pregunte a gcc por los system headers y los parsee.
(require 'semantic-gcc)

;; Esta es otra herramienta que ofrece otras habilidades ...
(require 'eassist)

;; Esto sirve para delimitar el ambito de la busqueda de simbolos
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))         

;; Esto no tengo del todo claro para que puede ser .
;; (custom-set-variables
;;   '(semantic-idle-scheduler-idle-time 3)
;;   '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;;   '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;; (global-semantic-folding-mode 1)
;; Si queremos podemos poner directorios de include adicionales de la siguiente manera.
;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)

;; ----------------------------
;; Opciones varias de Semantic
;; ----------------------------
;; Opciones varias
;;(global-semantic-idle-scheduler-mode 1) ;The idle scheduler with automatically reparse buffers in idle time.
(global-semantic-idle-completions-mode nil) ;Display a tooltip with a list of possible completions near the cursor.
;;(global-semantic-idle-summary-mode 1) ;Display a tag summary of the lexical token under the cursor.
  ;;;(semantic-idle-scheduler-idle-time 1)
;;(global-semantic-folding-mode 1)  ;; Habilitamos el folding del codigo segun semantic

(setq semantic-idle-scheduler-idle-time 1) ; que empiece parsear cuando lleve 1 segundo parado

                                        ; Definicion de las teclas para cedet
(global-set-key "\C-cg" 'semantic-ia-fast-jump)
(global-set-key "\C-cd" 'semantic-analyze-proto-impl-toggle)
(global-set-key "\C-ci" 'semantic-decoration-include-visit)
(global-set-key "\C-ct" 'semantic-symref)
(global-set-key "\C-cl" 'goto-line)
(global-set-key "\C-ca" 'eassist-switch-h-cpp)
(global-set-key "\C-cb" 'semantic-mrub-switch-tags)
(global-set-key "\C-ch" 'highlight-symbol-at-point)


;;Habilitar semanticDB
(require 'semanticdb)
(global-semanticdb-minor-mode 1)
;;make all the 'semantic.cache' files go somewhere sane
(setq semanticdb-default-save-directory "~/emacs-meta/semantic.cache/")

;; Esto se supone que debe darme soporte para cscope
(require 'xcscope)

