-include envfile
-include envfile-local

install-lsp:
	# brew install lua-language-server
	[ -x $(command -v nvim) ] && nvim +"LspInstall sumneko_lua" ||true


install-lua:
	brew install lua luarocks
	arch -x86_64 /usr/local/bin/brew install luajit


install-lib:
	luarocks install inspect


install: install-lsp install-lua install-lib
	print('OK.')
