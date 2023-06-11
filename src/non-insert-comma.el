(add-to-list 'load-path "~/git/devil/")
(message "Type , ,")
(message "Type , ,")
(message "Type , SPC")
(message "Type , RET")

;;; START
(require 'devil)
(global-devil-mode)
(defvar counter 0)
(global-set-key (kbd ",") (lambda ()
                            (interactive)
                            (message "You pressed , (%d)" counter)
                            (setq counter (1+ counter))))
