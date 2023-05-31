help:
	@echo 'make backup'
	@echo 'make melpa-interactive-install'
	@echo 'make melpa-automatic-install    # perform twice'
	@echo 'make melpa-local'

backup:
	mv ~/.emacs.d/ ~/bkp.emacs.d/ || true
	mv ~/.emacs ~/bkp.emacs || true

restore:
	rm -rf ~/.emacs.d/
	mv ~/bkp.emacs.d/ ~/.emacs.d/ || true
	mv ~/bkp.emacs ~/.emacs || true

EMX = emacs --debug-init --eval '(progn (toggle-frame-maximized) (split-window-below) (switch-to-buffer "*Messages*") (other-window 1))'

# MELPA
melpa-interactive-install:
	$(EMX) --eval '(message "TEST: Install Devil interactively")' -l melpa/interactive-install.el

melpa-automatic-install:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -l melpa/automatic-install.el

melpa-simple:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -l melpa/simple.el

# SRC
src-simple:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -q -l src/simple.el

src-semicolon:
	$(EMX) --debug-init --eval '(message "TEST: Type ; x ; f and ; x ; c")' -q -l src/semicolon.el

src-left-key:
	$(EMX) --debug-init --eval '(message "TEST: Type <left> SPC and select region")' -q -l src/left-key.el

src-multiple-keys:
	$(EMX) --debug-init --eval '(message "TEST: Type , x , f\nTEST: Type . x\nTEST: Type , . s\nTEST: Type , ,\nTEST: Type . .\nTEST: Type , x , c\n")' -q -l src/multiple-keys.el

src-map-to-prefixes:
	$(EMX) --eval '(message "TEST: Type - C-f\nTEST: Type , v\nTest: Type - ,")' -q -l src/map-to-prefixes.el

src-ctrl-function:
	$(EMX) --eval '(message "TEST: Type , <tab> and , <backspace>")' -q -l src/ctrl-function.el

# DEMOS
demo-smiley:
	emacs -q -l demo/smiley.el demo/example.md

# GOD
src-god-modeless:
	$(EMX) --eval '(message "TEST: Test modeless editing with God-mode")' -q -l src/god-modeless.el

# RELEASE
release-checks:
	cd ~/git/melpa/ && make clean && rm -rf packages/devil* working/devil/
	cd ~/git/melpa/ && make recipes/devil
	-cd ~/git/melpa/ && STABLE=t make recipes/devil
	cd ~/git/melpa/ && make sandbox INSTALL=devil
	cd ~/git/melpa/ && ls -l packages/ packages-stable/ sandbox/elpa/

pub: html pdf
	cd _live/ && make -f ../Makefile pushlive

rm-live:
	rm -rf _live/

html: rm-live
	emacs --batch -l doc/lib.el -l doc/html.el
	open _live/devil.html

pdf: rm-live
	emacs --batch -l doc/lib.el -l doc/tex.el
	cd _live/ && pdflatex devil.tex
	cd _live/ && pdflatex devil.tex
	rm _live/*.aux _live/*.log _live/*.out
	open _live/devil.pdf

pushlive:
	pwd | grep _live$$ || false
	git init
	git config user.name live
	git config user.email live@localhost
	git remote add origin https://github.com/susam/devil
	git checkout -b live
	git add devil.html devil.pdf
	git mv devil.html index.html
	git commit -m "Publish live ($$(date -u +"%Y-%m-%d %H:%M:%S"))"
	git log
	git push -f origin live
