(defvar devil-key (kbd "<left>"))
(defvar devil-special-keys '(("%k %k" . left-char)))
(global-devil-mode)
(global-set-key (kbd "C-<left>") 'global-devil-mode)
