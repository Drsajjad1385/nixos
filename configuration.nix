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
      efiSupport = true;
      device = "/dev/sda3"; # Adjust to your EFI partition
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # Networking
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  # Localization
  time.timeZone = "Asia/Tehran";
  i18n.defaultLocale = "en_US.UTF-8";

  # Console
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Graphics and display
  
  hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    amdvlk
    mesa
    vulkan-loader
    vulkan-tools
  ];
  };
 
  
  # AmdGpu Kernel Drive

  boot.kernelParams = [
  "radeon.si_support=0"
  "amdgpu.si_support=1"
  "radeon.cik_support=0"
  "amdgpu.cik_support=1"
  ];


  # X-Server Config  

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "amdgpu" ];
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;
    displayManager.lightdm.greeters.slick.enable = true;
    displayManager.lightdm.greeters.slick.extraConfig = ''
      theme-name = Dracula
      background = /usr/share/backgrounds/NixWall.jpg
    '';
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

  # Browser
  programs.firefox.enable = true;

  # Gaming
  programs.gamemode.enable = true;

  # User accounts
  users.users.sajjad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "plugdev" ];
    packages = with pkgs; [ tree ];
  };

  users.groups.plugdev = {};
  services.udev.packages = with pkgs; [ android-udev-rules ];

  # System packages with full alphabetical grouping
  environment.systemPackages = with pkgs; [
    # A
    android-tools
    alacritty
    appimage-run

    # B
    btop
    bluetui

    # C

    # D
    duf
    distrobox

    # E
    eza

    # F
    fzf
    flatpak
    firefox
    fastfetch

    # G
    gamemode
    gearlever
    git
    gccgo14

    # H
    haruna

    # I
    # (no packages)

    # J
    # (no packages)

    # K
    kitty
    kdePackages.okular

    # L
    libepoxy
    lua-language-server
    localsend

    # M
    motrix

    # N
    neovim

    # O

    # P
    p7zip
    podman
    proxychains
    persepolis

    # Q
    # (no packages)

    # R
    # (no packages)

    # S
    stacer

    # T
    telegram-desktop
    tor
    tor-browser

    # U
    unrar

    # V
    vim
    vulkan-tools
    vlc

    # W
    wget

    # X
    xdotool
    xfce.mousepad
    xfce.orage
    xfce.thunar
    xfce.xfce4-notifyd
    xfce.xfce4-power-manager
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screenshooter
    xfce.xfce4-whiskermenu-plugin
    xorg.xinit

    # Y
    # (no packages)

    # Z
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zoxide
    zulu23

    # Unstable packages
    unstable.ayugram-desktop
    unstable.nekoray
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
