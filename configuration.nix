# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

let
	currentSystem = builtins.currentSystem;
	isDarwin = builtins.match ".*-darwin" currentSystem != null;
	isLinux = builtins.match ".*-linux" currentSystem != null;
in
{
	imports = [
		./cfgs/vim.nix
	]
	++ lib.optionals isDarwin [ ./darwin-config.nix ]
	++ lib.optionals isLinux [ ./linux-config.nix ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# dev tools
		git
		lldb
		patchelf
		python312
		nix-index # nix-locate
		jdk25_headless # openJDK 21
		nodejs_24
		man-pages
		man-pages-posix
		hugo

		nixd # nix language server
		jdt-language-server # java
		bash-language-server

		ocaml
		opam # ocaml package manager
		ocamlPackages.utop

		texliveBasic
		texlab # LaTeX language server

		crush

		# c development
		clang-tools
		clang
		gcc

		# gdb # build error on 17.1
		gnumake
		cmake

		# utilities
		lf # terminal file manager
		openconnect # vpn client
		gnupg
			pinentry-curses
			paperkey
		htop
		ascii
		wget
		zip
		unzip
		helix # text editor
		usbutils
		leetgo
		alacritty-graphics

		# graphic applications
		obsidian
		firefox
		librewolf
		discordo
		thunderbird

		# vanity
		fastfetch
	]
	++ lib.optionals isDarwin [
		vesktop
		spotify
		vscode # other package breaks in Applications but works fine on cmd line (?)
		# for MacOS, we will just have to install extensions non-declaratively.
	]
	++ lib.optionals isLinux [
		glibc
		libgcc
		brightnessctl # device brightness control
		dmenu # dynamic menu for dwm
		(slstatus.overrideAttrs { # status monitor
			src = ./src/slstatus;
		})
		scrot # screenshots
		xclip # clipboard
		dunst # notifications
		libnotify # notifications
		krita
		pinta
		nsxiv # image viewer
		obs-studio
		vlc
		feh # wallpaper
		(vscode-with-extensions.override {
			vscodeExtensions = with vscode-extensions;
			[
				ms-vscode.cpptools # build failure on 1.28.3. Thanks microsoft!
				ms-python.python
				ms-vscode.live-server
				ms-vscode.makefile-tools
				emroussel.atomize-atom-one-dark-theme
				jeff-hykin.better-nix-syntax
				github.copilot-chat
			];
		})
	];

	# unfree packages
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"obsidian"

		"vscode"
		"vscode-with-extensions"
		"vscode-extension-ms-vscode-cpptools"
		"vscode-extension-github-copilot-chat"

		"mongodb"
		"mongodb-ce"

		"steam"
		"steam-original"
		"steam-unwrapped"
		"steam-run"

		"crush"

		"spotify"
	];

	environment.variables = {
		EDITOR = "hx";
	};
}
