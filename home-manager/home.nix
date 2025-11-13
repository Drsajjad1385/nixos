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
    TERMINAL = "wezterm";
    BROWSER = "firefox";
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
    shellAliases = {
      l = "eza --icons=always";
      ls = "eza -l --icons=always";
      la = "eza -la --icons=always";
    };
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
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      # Video
      "video/mp4" = ["org.kde.haruna.desktop"];
      "video/x-matroska" = ["org.kde.haruna.desktop"];
    };
  };

  gtk = {
    enable = true;
    # GTK Theme
    theme = {
      name = "Squared";
    };
    # Icon
    iconTheme = {
      name = "Papirus";
    };
    # Cursor Theme
    cursorTheme.name = "Nordzy-catppuccin-mocha-dark";
  };
  home.pointerCursor = {
    name = "Nordzy-catppuccin-mocha-dark";
    package = pkgs.nordzy-cursor-theme;
    size = 18;
  };

  # ───── Programs ────────────────────────────────────────
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName = "Drsajjad1385";
    userEmail = "surtr85@proton.me";
  };

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

  # ───── User Packages (Alphabetical Order) ───────────────
  home.packages = with pkgs; [
    aria2 # Terminal Download Manager
    alejandra # Nix code formatter
    ayugram-desktop # A Telegram client
    bat # "cat" with syntax highlighting
    bluetui # Terminal Bluetooth manager
    btop # System resource monitor
    brightnessctl # Control screen brightness
    duf # Disk usage visualizer
    dunst # Lightweight notification daemon
    discord # Proprietary voice and text chat application
    eog # GNOME image viewer
    eza # Modern "ls" replacement
    fastfetch # System info fetcher
    filezilla # FTP/SFTP client
    ffmpeg # Audio/video processing
    feh # Lightweight image viewer
    fd # Fast find alternative
    gearlever # AppImage management utility
    gparted # GUI disk partitioner
    gnome-screenshot # Screenshot capture utility
    gcc # C compiler for tree-sitter parsers
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
    neovim # Extensible Vim-based editor
    obs-studio # recording software
    openconnect # Cisco AnyConnect-compatible VPN client
    openvpn # OpenVPN client
    pcmanfm # Lightweight file manager
    picard # Music tag editor (MusicBrainz)
    p7zip # 7z archive support
    proxychains # Route apps through proxy
    picom-pijulius # Xorg compositor with effects
    qbittorrent # Torrent client
    rofi # Application launcher
    ripgrep # Fast grep alternative
    stacer # Linux system optimizer & monitor
    tor # Anonymity network client
    tor-browser # Anonymous web browser
    tldr # Easy-to-read examples for command-line tools
    tree-sitter # Tree-sitter CLI for nvim-treesitter
    unrar # Extract RAR archives
    vim # Classic text editor
    vlc # Media player
    wezterm # fast & customizable GPU terminal
    xsel # Command-line interface to the X11 clipboard
    youtube-music # YouTube Music desktop app
    yazi # Terminal file manager
    zellij # Terminal workspace multiplexer
    # Python
    python313 # Python 3.13 interpreter
    python313Packages.pip # Python package installer
    # Unstable-Packages
    pkgsUnstable.rmpc # Rust Music Player Client
    pkgsUnstable.obsidian # Powerful knowledge base and note-taking app
  ];
}
