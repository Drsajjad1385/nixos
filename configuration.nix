{
  config,
  lib,
  pkgs,
  ...
}: let
  unstable = import <nixpkgs-unstable> {config.allowUnfree = true;};
in {
  imports = [./hardware-configuration.nix];

  # ───── Boot ─────────────────────────────────────────────
  boot = {
    loader.grub = {
      enable = true;
      splashImage = "/etc/nixos/background.jpg";
      efiSupport = true;
      devices = [ "nodev" ];
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
  };

  # ───── Host & Locale ───────────────────────────────────
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall.enable = false;
    firewall.allowedTCPPorts = [8096 8920 7575 8080 5001 80 443];
    firewall.allowedUDPPorts = [53];
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
    videoDrivers = ["intel" "amdgpu"];
  };

  # ───── Virtualisation & Containers ─────────────────────
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
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
    memoryPercent = 35;
    priority = 100;
  };

  # ───── Security ────────────────────────────────────────
  security.rtkit.enable = true;

  # ───── XDG / Flatpak / AppImage ────────────────────────
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [pkgs.libepoxy];
    };
  };

  # ───── Programs ────────────────────────────────────────
  programs = {
    zsh.enable = true;
    amnezia-vpn.enable = false;       
  };

  # ───── User Config ─────────────────────────────────────
  users.defaultUserShell = pkgs.zsh;

  users.users.sajjad = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "plugdev" "docker"];
  };
  
  # ───── Fonts ───────────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
  ];

  # ───── Optional Services ───────────────────────────────
  
  services.udev.packages = with pkgs; [android-udev-rules];
  services.gvfs.enable = true;
  services.resolved.enable = true;

  services.mpd = {
  enable = true;
  user = "sajjad";
  group = "audio";
  musicDirectory = "/home/sajjad/Spotify";
  extraConfig = ''
    audio_output {
      type "pulse"
      name "PipeWire"
    }
  '';
  };

  # ───── System Packages ─────────────────────────────────
  environment.systemPackages = with pkgs; [
    android-tools
    docker-compose
    flatpak
    git
    gccgo14
    home-manager
    jmtpfs
    mpd
    mpc
    nixd
    wget
    # Unstable Packages :
    unstable.amnezia-vpn
    unstable.rmpc
  ];

  # ───── Nix Configuration ───────────────────────────────
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = false;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.11";
}
