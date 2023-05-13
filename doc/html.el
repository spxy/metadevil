(require 'org)
(setq org-html-head (org-file-contents "doc/head.html"))
(find-file "/tmp/live/index.org")
(org-export-to-file 'html "/tmp/live/index.html")
