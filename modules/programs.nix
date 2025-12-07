{pkgs, ...}: {
  programs.dconf.enable = true;
  programs.zsh.enable = true;

  # Optional Services
  services.gvfs.enable = true;
  services.dbus.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    android-tools    # ADB/Fastboot for Android device debugging
  # docker-compose   # Multi-container Docker orchestration tool
    flatpak          # Sandboxed application packaging system
    git              # Distributed version control system
    gccgo14          # Go compiler from GCC toolchain
    home-manager     # Declarative user environment manager
    jmtpfs           # Mount Android devices via MTP protocol
    mpd              # Music Player Daemon server
    mpc              # Command-line client for MPD
    nixd             # Nix language server (LSP) for editors
    kitty
    wget             # Non-interactive network downloader
  ];
}
