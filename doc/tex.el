;; Prepare file.
(make-directory "_live/" t)
(copy-file "~/git/devil/MANUAL.org" "_live/devil-tex.org")
(find-file "_live/devil-tex.org")
(delete-between "#+email:" "@insertcopying\n")
(insert-after "Susam Pal\n" "#+latex_class_options: [a4paper,11pt]
#+options: toc:nil
#+latex_header: \\definecolor{codecolor}{HTML}{006600}
#+latex_header: \\DefineVerbatimEnvironment{verbatim}{Verbatim}{formatcom=\\color{codecolor}}
#+latex_header: \\renewcommand{\\texttt}[1]{\\textcolor{codecolor}{\\ttfamily #1}}
")
(insert-after "Susam Pal\n" (concat "#+date: " (get-date) "\n"))
(replace-regexp "Devil smiley (.*)" "Devil smiley")
(save-buffer)

;; Generate output.
(setq org-latex-default-packages-alist
      '(("utf8" "inputenc")
        ("" "parskip")
        ("" "upquote")
        ("" "fancyvrb")
        ("" "xcolor")
        ("colorlinks=true,linkcolor=blue,urlcolor=blue" "hyperref")))
(setq org-latex-hyperref-template nil)
(org-export-to-file 'latex "devil.tex")
