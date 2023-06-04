(add-to-list 'load-path "~/git/devil/")
(message "Type , <tab>")
(message "Type , z <return> (undefined key)")
(message "Type , c <return>")
(message "Select region and type , x <tab> followed by <right> <right>")

;;; START
(require 'devil)
(global-devil-mode)
(global-set-key (kbd "C-,") 'global-devil-mode)
(global-set-key (kbd "C-<tab>") (lambda () (interactive) (message "You pressed C-<tab>")))
(global-set-key (kbd "C-RET") (lambda () (interactive) (message "You pressed C-RET")))
(global-set-key (kbd "C-c RET") (lambda () (interactive) (message "You pressed C-c RET")))
