{
  config,
  pkgs,
  pkgsUnstable,
  ...
}: {
  # ───── Home Manager Core ───────────────────────────────
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
  home.username = "sajjad";
  home.homeDirectory = "/home/sajjad";

  # ───── Session & Environment ───────────────────────────
  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "ghostty";
    BROWSER = "zen-twilight";
  };

  # ───── Shell: Zsh ──────────────────────────────────────
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      HISTFILE="$HOME/.zsh_history"
      HISTSIZE=5000
      SAVEHIST=10000
      setopt appendhistory
      setopt hist_ignore_dups
      setopt share_history
    '';
  };

  # ───── XDG Base Directories & GTK ────────────────────────────
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # File manager
      "inode/directory" = ["pcmanfm.desktop"];
      # Text files
      "text/plain" = ["Helix.desktop"];
      # Images
      "image/png" = ["org.gnome.eog.desktop"];
      "image/jpeg" = ["org.gnome.eog.desktop"];
      "image/gif" = ["org.gnome.eog.desktop"];
      "image/webp" = ["org.gnome.eog.desktop"];
      # PDF
      "application/pdf" = ["org.kde.okular.desktop"];
      # Browser
      "x-scheme-handler/http" = ["zen-twilight.desktop"];
      "x-scheme-handler/https" = ["zen-twilight.desktop"];
      # Video
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
    };
  };

  gtk = {
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "WhiteSur-dark";
    cursorTheme.name = "Nordic-cursors";
  };

  # ───── Programs ────────────────────────────────────────
  programs.firefox.enable = true;
  programs.git.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zen-browser = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--password-store=basic"
      "--password-manager-enable=false"
    ];
  };

  # ───── User Packages (Alphabetical Order) ───────────────
  home.packages = with pkgs; [
    alejandra # Nix code formatter
    ayugram-desktop # A Telegram client
    bat # "cat" with syntax highlighting
    bitwarden-desktop # Password manager
    bluetui # Terminal Bluetooth manager
    btop # System resource monitor
    brightnessctl # Control screen brightness
    duf # Disk usage visualizer
    dunst # Lightweight notification daemon
    discord
    eog # GNOME image viewer
    eza # Modern "ls" replacement
    fastfetch # System info fetcher
    filezilla # FTP/SFTP client
    ffmpeg # Audio/video processing
    fzf # Fuzzy finder
    fuzzel # Wayland app launcher
    feh
    gearlever # AppImage management utility
    gparted # GUI disk partitioner
    ghostty # Modern GPU-accelerated terminal
    haruna # Qt-based video player
    helix # Modal code editor
    kdePackages.filelight # KDE disk usage visualizer
    kdePackages.okular # KDE document viewer
    lazygit # Terminal UI for Git
    libnotify # Desktop notifications
    libwnck # Window navigation library
    libgbm # Graphics buffer management (for compositors)
    localsend # Local file sharing over LAN
    mpv # Simple, lightweight media player for videos and music.
    nautilus # GNOME file manager
    neovim # Extensible Vim-based editor
    networkmanagerapplet # NetworkManager system tray applet
    nerd-fonts.comic-shanns-mono # Monospace font
    niri # Wayland tiling window manager
    obs-studio # recording software
    openconnect # Cisco AnyConnect-compatible VPN client
    openvpn # OpenVPN client
    pcmanfm # Lightweight file manager
    picard # Music tag editor (MusicBrainz)
    p7zip # 7z archive support
    proxychains # Route apps through proxy
    picom-pijulius
    qbittorrent # Torrent client
    rofi
    scrcpy # Mirror & control Android devices
    stacer # Linux system optimizer & monitor
    starship # Minimal, fast shell prompt
    swww # Wayland wallpaper setter
    tor # Anonymity network client
    tor-browser # Anonymous web browser
    tldr # Easy-to-read examples for command-line tools
    unrar # Extract RAR archives
    vim # Classic text editor
    vlc # Media player
    waybar # Customizable Wayland status bar
    wl-clipboard # Wayland clipboard tools
    xclip
    youtube-music # YouTube Music desktop app
    yazi # Terminal file manager
    zellij # Terminal workspace multiplexer
    zoxide # Smarter "cd" command
    # Python
    python313 # Python 3.13 interpreter
    python313Packages.pip # Python package installer
    # Unstable-Packages
    pkgsUnstable.rmpc # Rust Music Player Client
  ];
}
