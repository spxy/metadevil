(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'devil)
  (package-install 'devil))
(global-devil-mode)
(global-set-key (kbd "C-,") 'global-devil-mode)
