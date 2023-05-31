(defun delete-between (from-string to-string)
  (goto-char (point-min))
  (search-forward from-string)
  (delete-region (match-beginning 0)
                 (search-forward to-string)))

(defun insert-after (where-string new-string)
  (goto-char (point-min))
  (search-forward where-string)
  (insert new-string))

(defun get-date ()
  (string-trim-right
   (shell-command-to-string
    "(cd ~/git/devil && git log -n 1 --format='%cd' --date=format:'%d %b %Y')")))
