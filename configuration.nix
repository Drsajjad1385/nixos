{ config, lib, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz";
  }) {
    config.allowUnfree = true;
  };
in
{
  imports = [ ./hardware-configuration.nix ];

  # ───── Boot ─────────────────────────────────────────────
  boot = {
    loader.grub = {
      enable = true;
      splashImage = "/etc/nixos/background.jpg";
      efiSupport = true;
      device = "/dev/sda3";
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
    initrd.kernelModules = [ "amdgpu" ];
  };

  # ───── Host & Locale ───────────────────────────────────
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Tehran";
  i18n.defaultLocale = "en_US.UTF-8";

  # ───── Graphics ────────────────────────────────────────
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

  hardware.amdgpu = {
    legacySupport.enable = true;
    initrd.enable = true;
  };

  # ───── Desktop & Display ───────────────────────────────
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "amdgpu" ];
    desktopManager.cinnamon.enable = true;
  };

  # ───── Audio & Multimedia ──────────────────────────────
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # ───── Bluetooth ───────────────────────────────────────
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # ───── Performance & Power ─────────────────────────────
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 85;
    priority = 100;
  };

  # ───── Security ────────────────────────────────────────
  security.rtkit.enable = true;

  # ───── XDG / Flatpak / AppImage ────────────────────────
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.libepoxy ];
    };
  };

  # ───── Programs ────────────────────────────────────────
  programs = {
    zsh.enable = true;
    firefox.enable = true;
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  # ───── User Config ─────────────────────────────────────
  users.defaultUserShell = pkgs.zsh;

  users.users.sajjad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "plugdev" ];
    packages = with pkgs; [ tree ];
  };

  users.groups.plugdev = {};

  services.udev.packages = with pkgs; [ android-udev-rules ];
  services.gvfs.enable = true;

  # ───── Optional Services ───────────────────────────────
  services.jellyfin = {
    enable = false;
    user = "sajjad";
    openFirewall = true;
  };

  # ───── System Packages ─────────────────────────────────
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
   # Unstable Packages
    unstable.ayugram-desktop
    unstable.nekoray
    unstable.v2rayn
  ];

  # ───── Nix Configuration ───────────────────────────────
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.copySystemConfiguration = true;
  system.stateVersion = "24.11";
}

