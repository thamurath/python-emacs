
;; Cargamos las configuraciones
;; (load-library "my-python-mode.el")



(add-to-list 'load-path "~/.emacs.d/vendor/fgallina-python-mode")
(require 'python-fgallina)

;; Here is a complete example of the settings you would use for
;; iPython

;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code ""
;;  python-shell-completion-string-code
;;  "';'.join(__IP.complete('''%s'''))\n")

(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
		    (set-variable 'python-indent-offset 4)
		    (set-variable 'py-smart-indentation nil)
		    (set-variable 'indent-tabs-mode nil)
                    (set-variable 'py-tab-always-indent t)
		    ;;(highlight-beyond-fill-column)
                    (define-key python-mode-map "\C-m" 'newline-and-indent)
                    ;; (define-key python-mode-map (kbd "RET") 'newline-and-indent)
                    ;; (smart-operator-mode-on)
		    ;(pabbrev-mode)
		    ;(abbrev-mode)
	 )
      )
)
