(add-to-list 'load-path "~/git/devil/")
(message "Type , SPC to set mark")
(message "Type , p p p to select text")
(message "Type , m m w to copy text")
(message "Type , y to paste text")
(message "Type , ,")
(message "Type , RET")
(message "Type , x , c")

;;; START
(require 'devil)
(global-devil-mode)
(global-set-key (kbd "C-,") 'global-devil-mode)
(assoc-delete-all "%k SPC" devil-special-keys)
