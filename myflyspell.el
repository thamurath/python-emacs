;; When turning on flyspell-mode, automatically check the entire buffer.
;; Why this isn't the default baffles me.
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(add-hook 'python-mode-common-hook 'flyspell-prog-mode)
(add-hook 'tcl-mode-hook 'flyspell-prog-mode)
(defun turn-on-flyspell ()
    "Force flyspell-mode on using a positive arg.  For use in hooks."
       (interactive)
          (flyspell-mode 1))

(defadvice flyspell-mode (after advice-flyspell-check-buffer-on-start activate)
  (flyspell-buffer))
