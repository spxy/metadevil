(add-to-list 'load-path "~/git/devil/")
(message "Type , m s (Regexp I-search)")
(message "Type , m m x (M-x)")
(message "Type , x , c")

;;; START
(require 'devil)
(global-devil-mode)
(setq devil-translations '(("%k z" . "C-")
                           ("%k %k" . "%k")
                           ("%k m m" . "M-")
                           ("m z" . "M-")
                           ("m m" . "m")
                           ("%k" . "C-")
                           ("m" . "M-")))