(defvar devil-key "<left>")
(defvar devil-special-keys '(("%k %k" . (lambda () (interactive) (devil-run-key "%k")))))
(global-devil-mode)
(global-set-key (kbd "C-<left>") 'global-devil-mode)
