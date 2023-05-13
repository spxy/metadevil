(require 'org)
(setq org-html-head (org-file-contents "doc/head.html"))
(find-file "/tmp/live/devil.org")
(org-export-to-file 'html "/tmp/live/devil.html")
