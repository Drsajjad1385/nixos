{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  # ───── Boot ─────────────────────────────────────────────
  boot = {
    loader.grub = {
      enable = true;
      splashImage = "/home/sajjad/SelfHosted/nixos/background.jpg";
      efiSupport = true;
      devices = ["nodev"];
    };
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_lqx;
  };

  # ───── Host & Locale ───────────────────────────────────
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
    nameservers = ["8.8.8.8" "8.8.4.4"];
    dhcpcd.extraConfig = "nohook resolv.conf";
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
  programs.niri = {
    enable = true;
  };

  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = ["intel" "amdgpu"];
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages:
        with python3Packages; [
          qtile-extras
        ];
    };
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
    alsa.support32Bit = true;
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
    nerd-fonts.jetbrains-mono
  ];

  # ───── Optional Services ───────────────────────────────

  services.udev.packages = with pkgs; [android-udev-rules];
  services.gvfs.enable = true;
  services.resolved.enable = false;

  services.mpd = {
    enable = true;
    user = "sajjad";
    group = "users";
    musicDirectory = "/home/sajjad/Spotify";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PulseAudio"
        server "unix:/run/user/1000/pulse/native"
      }
    '';
  };

  # ───── System Packages ─────────────────────────────────
  environment.systemPackages = with pkgs; [
    android-tools # ADB/Fastboot for Android devices
    docker-compose # Multi-container Docker apps
    flatpak # Sandboxed desktop apps
    git # Version control
    gccgo14 # Go compiler
    home-manager # Manage user config with Nix
    jmtpfs # Mount Android phones via MTP
    mpd # Music Player Daemon
    mpc # CLI client for MPD
    nixd # LSP server for Nix
    wget # Download files from the web
  ];

  # ───── Nix Configuration ───────────────────────────────
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = false;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.substituters = [
    "https://cache.nixos.org" # keep the official cache as fallback
  ];
  nix.settings.trusted-substituters = [
    "https://cache.nixos.org"
  ];
  system.stateVersion = "24.11";
}
