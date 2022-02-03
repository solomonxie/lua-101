-include envfile
-include envfile-local

install-lsp:
	# brew install lua-language-server
	[ -x $(command -v nvim) ] && nvim +"LspInstall sumneko_lua" ||true


install-lua:
	brew install lua luarocks
	arch -x86_64 /usr/local/bin/brew install luajit
	luarocks path


build-venv:
	mkdir -p ~/virtuallua/lua54 ||true
	vert init ~/virtuallua/lua54


build-torch:
	# NOT YET WORKING ON ARM64
	git clone https://github.com/torch/distro.git /tmp/lua-torch --recursive
	[[ !-x $(which cmake) ]] && brew install cmake ||true
	cd /tmp/lua-torch && bash install-deps && ./install.sh
	luarocks install --lua-version=5.1 dataframe


install-lib:
	luarocks install inspect
	luarocks install penlight
	#luarocks install --server=https://luarocks.org/dev ldt  # heavy dependencies
	luarocks install debugger
	luarocks install lua-cjson 2.0.0
	luarocks install luasocket
	# luarocks install vert  # buggy & ARM not well supported


install: install-lsp install-lua install-lib
	print('OK.')
