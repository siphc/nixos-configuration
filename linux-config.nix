{ config, pkgs, ... }:

{
	imports = [
		# Include the results of the hardware scan.
		/etc/nixos/hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	i18n.inputMethod = {
		enable = true;
		type = "fcitx5";
		fcitx5.addons = with pkgs; [
			qt6Packages.fcitx5-chinese-addons
		];
		# uim.toolbar = "gtk3";
	};

	i18n.supportedLocales = [
		"en_US.UTF-8/UTF-8"
		"zh_CN.UTF-8/UTF-8"
	];

	# Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.windowManager.dwm = {
		enable = true;
		package = pkgs.dwm.overrideAttrs {
			src = ./src/dwm;
		};
	};

	# display manager
	services.displayManager.ly.enable = true;

	# fix screen tearing on X11, hopefully.
	services.picom = {
		enable = true;
		vSync = true;
	};

	# Enable the GNOME Desktop Environment.
	# services.xserver.displayManager.gdm.enable = true;
	# services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	# services.printing.enable = true;

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
	# however, you need to configure
	services.libinput.touchpad = {
		naturalScrolling = true;
		clickMethod = "clickfinger";
		tappingButtonMap = "lrm";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.svi = {
		isNormalUser = true;
		description = "svi";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		# thunderbird
		];
	};

	# manage hibernate and suspend states
	powerManagement.enable = true;

	# interfaces well with tlp, do not disable!
	services.thermald.enable = true;

	services.tlp = {
		enable = true;
		settings = {
			# run `tlp-stat -p` and check under "Processor" and "Platform Profile".
			CPU_ENERGY_PERF_POLICY_ON_BAT="power";
			PLATFORM_PROFILE_ON_BAT="low-power";
			# disable CPU boost.
			CPU_BOOST_ON_BAT=0;
			# disable Adaptive Backlight Modulation (ABM)
			AMDGPU_ABM_LEVEL_ON_BAT=3;
		};
	};

	virtualisation.docker.enable = true;

	# bluetooth
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	services.blueman.enable = true;

	# services.mongodb.enable = true;
	# some versions of mongodb fails to build
	# services.mongodb.package = pkgs.mongodb-ce;

	programs.tmux = {
		enable = true;
		clock24 = true;
		escapeTime = 5;
		terminal = "tmux-256color";
		extraConfig = "set -g mouse on
			set -s set-clipboard on";
	};

	# kernel version
	# 6.12.* causes screen tearing on GNOME
	# boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;

	# x display locker
	programs.slock.enable = true;
	programs.xss-lock.enable = true;
	programs.xss-lock.lockerCommand = "/run/wrappers/bin/slock";

	# no idea why this is here? this is why we document, kids
	services.pcscd.enable = true;
	# required to make gpg work properly
	programs.gnupg.agent = {
		enable = true;
		pinentryPackage = pkgs.pinentry-curses;
		enableSSHSupport = true;
	};

	# expose `pass` to secret service
  services.passSecretService.enable = true;

	programs.steam = {
		enable = true;
		# remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		# dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		# localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

	# unpackaged executables fix?
	# update 1/16/26: it works!
	# update 3/14/26: moved to linux-config.nix as this is only a POSIX concern (?)
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		glibc
		# libx11
		# libxrender
		# libxcursor
		# libxkbcommon
		# libxrandr
		# libGL
	];

	fonts = {
		packages = with pkgs; [
			nerd-fonts.caskaydia-cove
			wqy_microhei # cn & jp
			nanum # kr
		];
		fontconfig = {
			defaultFonts = {
				serif = ["DejaVu Serif" "wqy_microhei" "nanum"];
				sansSerif = ["DejaVu Sans" "wqy_microhei" "nanum"];
				monospace = ["CaskaydiaCove Nerd Font"];
			};
		};
	};

	console.font = null;

	environment.localBinInPath = true;

	xdg.mime.defaultApplications = {
		"text/html" = "librewolf.desktop";
		"x-scheme-handler/http" = "librewolf.desktop";
		"x-scheme-handler/https" = "librewolf.desktop";
		"x-scheme-handler/about" = "librewolf.desktop";
		"x-scheme-handler/unknown" = "librewolf.desktop";
		"application/pdf" = "librewolf.desktop";
		"image/png" = "nsxiv.desktop";
		"image/jpeg" = "nsxiv.desktop";
		"image/gif" = "nsxiv.desktop";
		"image/webp" = "nsxiv.desktop";
	};

	nix.nixPath = [
		"nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
		"nixos-config=/home/svi/nixos-configuration/configuration.nix"
		"/nix/var/nix/profiles/per-user/root/channels"
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?
}
