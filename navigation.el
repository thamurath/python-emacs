;;Modificaciones para que C-a te lleve al primer caracter no blanco de la linea
;;y que cuando lo presiones dos veces si que te lleve al primer caracter de la linea.

;; navigation

(defun heretic/real-line-beginning()
  (let ((c (char-after (line-beginning-position)))
        (n (line-beginning-position)))
    (while (or (eql c ?\ )
               (eql c ?\t))
      (incf n)
      (setq c (char-after n)))
    n))
(defun heretic/goto-alternate-line-beginning()
  (interactive)
  (let ((n (heretic/real-line-beginning)))
    (if (eql n (point))
        (goto-char (line-beginning-position))
      (goto-char n))))
;; Mapeamos C-a a la nueva funcion
(global-set-key  "\C-a" 'heretic/goto-alternate-line-beginning)


;; Esto es para que te lleve al parentesis o la llave que matche con esta 
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))



;; keybindings para hacer que C-w borre la palabra anterior.
;; De esta manera no tenemos que tocar el delete casi nunca.
;; C-w esta por defecto puesto para kill-region, por eso remapeamos esta tb.
;; Nota: en los shell C-w borra la palabra anterior tb, asi que no esta tan mal
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)