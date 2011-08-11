; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append
        '(("CMakeLists\\.txt\\'" . cmake-mode))
        '(("\\.cmake\\'" . cmake-mode))
        auto-mode-alist))

(autoload 'cmake-mode "./vendor/cmake-mode.el" t)
