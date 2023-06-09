(add-to-list 'load-path "~/git/devil/")
(message "Type , x , f")
(message "Type , . s")
(message "Type , ,")
(message "Type . .")
(message "Type , z SPC and , p p p")
(message "Type , g")
(message "Type . z f")
(message "Type , h , k and . z .")
(message "Type , x , c")

;;; START
(require 'devil)
(global-devil-mode)
(define-key devil-mode-map (kbd ".") #'devil)

(add-to-list 'devil-special-keys `(". ." . ,(devil-key-executor ".")))
(setq devil-translations '((", z" . "C-")
                           (". z" . "M-")
                           (", ," . ",")
                           (". ." . ".")
                           ("," . "C-")
                           ("." . "M-")))
