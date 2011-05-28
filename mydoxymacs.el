;; Enable Doxygen syntax highlighting for C and C++
(require 'doxymacs)
(add-hook 'font-lock-mode-hook
          '(lambda ()
             (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
                 (doxymacs-font-lock)
	     )
	   )
)
