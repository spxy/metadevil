(defvar org-html-head "
<style>
body {
  color: #333;
  font-family: georgia, serif;
  font-size: large;
  line-height: 1.5;
  margin: 0 auto;
  max-width: 40em;
  padding: 0 1em;
}
h1 {
  text-align: center;
}
h1, h2, h3, h4, h5, h6 {
  margin: 1.25em 0 0.5em 0;
  line-height: 1.2;
}
a:link {
  color: #00e;
}
a:visited {
  color: #518;
}
a:focus, a:hover {
  color: #03f;
}
a:active {
  color: #e00;
}
a:empty:before {
  content: \"#\";
}
a:empty {
  visibility: hidden;
  padding-left: 0.25em;
}
:hover > a:empty {
  visibility: visible;
}
img {
  max-width: 100%;
}
figure {
  margin: 1em 0;
  text-align: center;
}
figcaption {
  font-size: small;
}
pre, code, samp, kbd {
  font-family: monospace, monospace;
}
pre, code, kbd {
  color: #050;
}
samp {
  color: #730;
}
pre, blockquote, code, samp, kbd {
  background: #eee;
  font-size: 80%;
}
code, samp, kbd {
  padding: 0.2em 0.4em;
  border-radius: 0.4em;
}
pre, blockquote {
  padding: 0.5em;
}
pre {
  overflow: auto;
}
blockquote {
  border-left: medium solid #ccc;
  margin: 1em 0;
}
blockquote :first-child {
  margin-top: 0;
}
blockquote :last-child {
  margin-bottom: 0;
}
table {
  border-collapse: collapse;
}
th, td {
  border: thin solid #999;
  padding: 0.3em 0.4em;
  text-align: left;
}
.org-center {
  text-align: center;
}
.org-center a {
  margin-right: 1.5em;
  line-height: 2.5;
}
.org-center a:last-child {
  margin-right: 0;
}
hr {
  margin: 1.5em auto;
  border: 0;
  border-bottom: medium dotted #999;
}
@media (prefers-color-scheme: dark) {
  body {
    background: #111;
    color: #bbb;
  }
  a:link {
    color: #9bf;
  }
  a:visited {
    color: #caf;
  }
  a:focus, a:hover {
    color: #9cf;
  }
  a:active {
    color: #f99;
  }
  pre, code, kbd {
    color: #9d6;
    font-family: monospace, monospace;
  }
  samp {
    color: #ec0;
  }
  pre, blockquote, code, samp, kbd {
    background: #120;
  }
  blockquote {
    border-color: #363;
  }
  th, td {
    border-color: #666;
  }
  hr {
    border-bottom-color: #666;
  }
}
</style>
")

(defun delete-between (from-string to-string)
  (goto-char (point-min))
  (search-forward from-string)
  (delete-region (match-beginning 0)
                 (search-forward to-string)))

(defun insert-after (where-string new-string)
  (goto-char (point-min))
  (search-forward where-string)
  (insert new-string))

;; Prepare file.
(make-directory "_live/" t)
(copy-file "~/git/devil/MANUAL.org" "_live/devil-html.org")
(find-file "_live/devil-html.org")

;; Preamble.
(delete-between "#+email:" "@insertcopying\n")
(insert-after "Susam Pal\n" "#+html_doctype: html5
#+options: toc:nil num:nil html-preamble:nil html-postamble:nil html-style:nil
")
(insert-after "Susam Pal\n" (concat "#+date: " (get-date) "\n"))

;; TOC.
(insert-after "fingertips.\n\n" "#+toc: headlines 6\n\n")

;; Postamble.
(goto-char (point-max))
(insert "\n-----\n")
(insert "
#+begin_center
[[file:devil.pdf][PDF]]
[[https://github.com/susam/devil][GitHub]]
[[https://mastodon.social/@susam][Mastodon]]
#+end_center
")

;; Generate output.
(save-buffer)
(org-export-to-file 'html "devil.html")

;; Post-process output
(find-file "devil.html")
(delete-between "<!--" "-->\n")
(insert-after "<head>" (concat "\n<!-- Document last updated on " (get-date) " -->"))
(goto-char (point-min))
(replace-regexp "\\(<h[1-6] id=\"\\)\\(.*\\)\\(\">.*\\)\\(</h[1-6]>\\)" "\\1\\2\\3<a href=\"#\\2\"></a>\\4")
(save-buffer)
