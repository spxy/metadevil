(add-to-list 'load-path "~/git/devil/")
(defvar devil-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd ",") #'devil)
    (define-key map (kbd ".") #'devil)
    map))
(defvar devil-special-keys '((", ," . (lambda () (insert ",")))
                             (". ." . (lambda () (insert ".")))))
(defvar devil-translations '(("," . "C-")
                             ("." . "M-")))
(require 'devil)
(global-devil-mode)
