(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;Don't map TAB to yasnippet
;In fact, set it to something we'll never use because
;we'll only ever trigger it indirectly.
;;(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

