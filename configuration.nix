{ config, lib, pkgs, ... }:

let
    unstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
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
    firewall.allowedTCPPorts = [ 8096 ];
    firewall.interfaces."podman[0-9]+".allowedUDPPorts = [ 53 ];
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
  
  # ───── Virtualisation & Containers ─────────────────────  
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true; # optional: creates a 'docker' alias for podman
      defaultNetwork.settings.dns_enabled = true; # recommended for podman-compose networking
    };
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
    extraGroups = [ "wheel" "networkmanager" "audio" "plugdev" "podman" ];
    packages = with pkgs; [ tree ];
  };

  users.groups.plugdev = {};
  users.groups.podman = {};

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
    ayugram-desktop
    btop
    bluetui
    brightnessctl
    bat
    cinnamon-common
    cinnamon-control-center
    cinnamon-settings-daemon
    cinnamon-session
    cinnamon-menus
    cinnamon-translations
    cinnamon-screensaver
    cinnamon-desktop
    cliphist
    duf
    dunst
    eza
    eog
    fzf
    flatpak
    fastfetch
    filezilla
    ffmpeg
    gearlever
    git
    gccgo14
    gparted
    grim
    haruna
    helix
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
    lazygit
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
    podman
    podman-desktop
    qbittorrent
    stacer
    starship
    swww
    slurp
    scrcpy
    tor
    tor-browser
    unrar
    vim
    vulkan-tools
    vlc
    v2rayn
    wget
    wineWowPackages.stable
    waybar
    wofi
    wl-clipboard
    waypaper
    wezterm
    xdotool
    youtube-music
    yazi
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zoxide
    zulu
    zellij
   # Unstable Packages :
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

