(add-to-list 'load-path "~/git/god-mode/")
(require 'god-mode)
(global-set-key (kbd ",") #'god-execute-with-current-bindings)
