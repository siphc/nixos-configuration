# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# I DO NOT KNOW HOW THIS THING WORKS
# I DO NOT KNOW WHY THIS IS HERE
{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./vim.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
      fcitx5-chinese-addons
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
      src = ./dwm;
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
    #  thunderbird
    ];
  };

  # manage hibernate and suspend states
  powerManagement.enable = true;

  services.thermald.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "AC";
      PCIE_ASPM_ON_BAT = "powersupersave";
    };
  };

  # i don't know what this does
  virtualisation.docker.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # dev tools
    git
    lldb
    patchelf
    gdb
    python310
    nix-index # nix-locate

    # c development
    gcc
    gnumake
    cmake

    # utilities
    lf # terminal file manager
    openconnect # vpn client
    gnupg
      pinentry-curses
      paperkey
    htop
    brightnessctl # device brightness control
    dmenu # dynamic menu for dwm
    (slstatus.overrideAttrs { # status monitor
      src = ./slstatus;
    })
    (st.overrideAttrs { # terminal
      src = ./st;
    })
    scrot # screenshots
    xclip # clipboard
    ascii
    tmux
    wget
    ollama

    # graphic applications
    obsidian
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
       [ms-vscode.cpptools ms-vscode.live-server emroussel.atomize-atom-one-dark-theme];
    })
    krita
    pinta
    firefox
    firefox-devedition
    librewolf
    nsxiv # image viewer
    tor-browser
    obs-studio
    vlc

    # vanity
    fastfetch
    feh # wallpaper
    oh-my-git # game
  ];

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

  # unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
    "vscode"
    "vscode-with-extensions"
    "vscode-extension-ms-vscode-cpptools"
  ];

  # unpackaged executables fix?
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
  ];

  fonts = {
    packages = with pkgs; [
      # deprecated 25.05
      # (nerdfonts.override { fonts = ["CascadiaCode"]; })
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

  environment.variables = {
    EDITOR = "vim";
  };

  xdg.mime.defaultApplications = {
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
   services.openssh.enable = true;

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
