{ config, lib, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz";
  }) { config = { allowUnfree = true; }; };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot loader and kernel
  boot = {
    loader.grub = {
      enable = true;
      splashImage = "/etc/nixos/background.jpg";
      efiSupport = true;
      device = "/dev/sda3"; # Adjust to your EFI partition
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
  };

  # Networking
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  # Localization
  time.timeZone = "Asia/Tehran";
  i18n.defaultLocale = "en_US.UTF-8";

  # Graphics and display
  
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  extraPackages = with pkgs; [
    amdvlk
    mesa
    vulkan-loader
    vulkan-tools
    libva
    intel-media-driver
    intel-vaapi-driver
  ];
  };
 
  
 # AmdGpu Kernel Drive
   
   hardware.amdgpu.legacySupport.enable = true;
   hardware.amdgpu.initrd.enable = true;
   boot.initrd.kernelModules = [ "amdgpu" ];
   
  # Enable Hyprland on nixos
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # X-Server Config  
  
  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "amdgpu" ];
    desktopManager.cinnamon.enable = true;
  };

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Audio and multimedia
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  
  # Jellyfin Services
  services.jellyfin = {
   enable = false;
   user = "sajjad";
   openFirewall = true;
  };


  # Security
  security.rtkit.enable = true;

  # Flatpak support
  services.flatpak.enable = true;

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.libepoxy ];
    };
  };

  # Shell and user
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Browser & Steam
  programs.firefox.enable = true;

  # Gaming
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;


  # Zram-Setup

  zramSwap = {
   enable = true;
   algorithm = "zstd";      # Compression algorithm (e.g., "zstd", "lz4")
   memoryPercent = 85;      # Use up to 80% of RAM for ZRAM swap
   priority = 100;          # Swap priority
  };

  # User accounts
  users.users.sajjad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "plugdev" ];
    packages = with pkgs; [ tree ];
  };

  users.groups.plugdev = {};
  services.udev.packages = with pkgs; [ android-udev-rules ];
  services.gvfs.enable = true;

  # System packages with full alphabetical grouping
  environment.systemPackages = with pkgs; [
    
    android-tools
    alacritty
    appimage-run
    anydesk
    btop
    bluetui
    brave
    brightnessctl
    chromium
    cinnamon-common
    cinnamon-control-center
    cinnamon-settings-daemon
    cinnamon-session
    cinnamon-menus
    cinnamon-translations
    cinnamon-screensaver
    cinnamon-desktop
    duf
    dunst
    eza
    eog
    fzf
    flatpak
    fastfetch
    floorp
    filezilla
    ffmpeg
    gearlever
    git
    gccgo14
    gparted
    grim
    haruna
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    kitty
    kdePackages.okular
    kdePackages.filelight
    libwnck
    libnotify
    lua-language-server
    localsend
    lutris
    motrix
    mangohud
    mpv
    mpvpaper
    jmtpfs
    neovim
    nautilus
    networkmanagerapplet
    openvpn
    openconnect
    obs-studio
    pkgs.nerd-fonts.comic-shanns-mono
    p7zip
    proxychains
    persepolis
    protonup-qt
    plank
    qbittorrent
    stacer
    starship
    swww
    slurp
    scrcpy
    telegram-desktop
    tor
    tor-browser
    unrar
    vim
    vulkan-tools
    vlc
    wget
    wineWowPackages.stable
    waybar
    wofi
    wl-clipboard
    waypaper
    xdotool
    xfce.thunar
    youtube-music
    yazi
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zoxide
    zulu

    # Unstable packages
    unstable.ayugram-desktop
    unstable.nekoray
    unstable.v2rayn
  ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System version
  system.stateVersion = "24.11";

  # Enable copying the main configuration file into the system for easy recovery
  system.copySystemConfiguration = true;
}
