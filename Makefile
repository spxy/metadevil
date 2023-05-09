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

src-simple:
	$(EMX) --eval '(message "TEST: Type , x , c and exit")' -q -l src/simple.el

src-map-to-prefixes:
	$(EMX) --eval '(message "TEST: Type - C-f\nTEST: Type , v\nTest: Type - ,")' -q -l src/map-to-prefixes.el

src-god-modeless:
	$(EMX) --eval '(message "TEST: Test modeless editing with God-mode")' -q -l src/god-modeless.el

demo-smiley:
	emacs -q -l demo/smiley.el demo/example.md

release-checks:
	cd ~/git/melpa/ && make clean && rm -rf packages/devil* working/devil/
	cd ~/git/melpa/ && make recipes/devil
	-cd ~/git/melpa/ && STABLE=t make recipes/devil
	cd ~/git/melpa/ && make sandbox INSTALL=devil
	cd ~/git/melpa/ && ls -l packages/ packages-stable/ sandbox/elpa/
