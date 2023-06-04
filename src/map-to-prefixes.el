(add-to-list 'load-path "~/git/devil/")
(message "Note: - is C-x")
(message "Note: , is C-c\n")
(message "Type - C-f")
(message "Type C-g")
(message "Type , v")
(message "Type - , to quit")

;;; START
(require 'devil)
(setcdr devil-mode-map nil)
(define-key devil-mode-map (kbd ",") #'devil)
(define-key devil-mode-map (kbd "-") #'devil)
(setq devil-special-keys `(("- -" . ,(devil-key-executor "-"))
                           (", ," . ,(devil-key-executor ","))))
(setq devil-translations `(("-" . "C-x")
                           ("," . "C-c")))
(global-devil-mode)
