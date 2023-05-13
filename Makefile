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

melpa-local:
	printf 'foo\nbar\nbaz\nqux\n' > /tmp/foo.txt
	$(EMX) --eval '(message "TEST: Type , n\nTEST: Type , p\nTest , x , c")' -l melpa/local.el /tmp/foo.txt

melpa-smiley:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -l melpa/smiley.el

melpa-left-key:
	$(EMX) --eval '(message "TEST: Type <left> SPC and select region")' -l melpa/left-key.el

melpa-multiple-keys:
	$(EMX) --eval '(message "TEST: Type , x , f\nTEST: Type . x\nTEST: Type , . s\nTEST: Type , ,\nTEST: Type . .\nTEST: Type , x , c\n")' -l melpa/multiple-keys.el

# SRC
src-simple:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -q -l src/simple.el

src-left-key:
	$(EMX) --debug-init --eval '(message "TEST: Type <left> SPC and select region")' -q -l src/left-key.el

src-map-to-prefixes:
	$(EMX) --eval '(message "TEST: Type - C-f\nTEST: Type , v\nTest: Type - ,")' -q -l src/map-to-prefixes.elp

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

pub:
	make live
	REPO_DIR="$$PWD"; cd /tmp/live/ && make -f "$$REPO_DIR/Makefile" pushlive

live:
	rm -rf /tmp/live/
	mkdir /tmp/live/
	> /tmp/live/devil.org
	cat doc/begin.org >> /tmp/live/devil.org
	sed -n '/^Devil mode trades/,/fingertips/p' ~/git/devil/MANUAL.org >> /tmp/live/devil.org
	echo >> /tmp/live/devil.org
	echo '#+toc: headlines 6' >> /tmp/live/devil.org
	echo >> /tmp/live/devil.org
	sed -n '/^..Introduction/,$$p' ~/git/devil/MANUAL.org >> /tmp/live/devil.org
	echo >> /tmp/live/devil.org
	cat doc/end.org >> /tmp/live/devil.org
	emacs --batch --load doc/html.el
	sed 's/\(<h[1-6] id="\)\(.*\)\(">.*\)\(<\/h[1-6]>\)/\1\2\3<a href="#\2">\4<\/a>/' \
	  /tmp/live/devil.html > /tmp/live/tmp.html
	mv /tmp/live/tmp.html /tmp/live/devil.html
	cp /tmp/live/devil.html /tmp/live/index.html
	open /tmp/live/index.html

pushlive:
	pwd | grep live$$ || false
	git init
	git config user.name live
	git config user.email live@localhost
	git remote add origin https://github.com/susam/devil
	git checkout -b live
	git add index.html
	git add devil.org
	git commit -m "Publish live ($$(date -u +"%Y-%m-%d %H:%M:%S"))"
	git log
	git push -f origin live
