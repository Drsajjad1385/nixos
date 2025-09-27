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
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };

  # ───── Shell: Zsh ──────────────────────────────────────
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
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

  # ───── XDG Base Directories ────────────────────────────
  xdg.enable = true;
  xdg.mimeApps.enable = true;

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

  # ───── User Packages (Alphabetical Order) ───────────────
  home.packages = with pkgs; [
    alacritty # GPU-accelerated terminal
    alejandra # Nix code formatter
    anydesk # Remote desktop software
    ayugram-desktop # A Telegram client
    bat # "cat" with syntax highlighting
    bitwarden-desktop # Password manager
    bluetui # Terminal Bluetooth manager
    btop # System resource monitor
    brightnessctl # Control screen brightness
    cliphist # Wayland clipboard history
    duf # Disk usage visualizer
    dunst # Lightweight notification daemon
    eog # GNOME image viewer
    eza # Modern "ls" replacement
    fastfetch # System info fetcher
    filezilla # FTP/SFTP client
    ffmpeg # Audio/video processing
    fzf # Fuzzy finder
    gearlever # AppImage management utility
    gemini-cli # CLI for Gemini AI
    gnupg # Encryption/signing (GPG)
    gparted # GUI disk partitioner
    grim # Wayland screenshot tool
    haruna # Qt-based video player
    helix # Modal code editor
    kitty # GPU-based terminal emulator
    kdePackages.filelight # KDE disk usage visualizer
    kdePackages.okular # KDE document viewer
    lazygit # Terminal UI for Git
    libnotify # Desktop notifications
    libwnck # Window navigation library
    libgbm # Graphics buffer management (for compositors)
    localsend # Local file sharing over LAN
    lua-language-server # LSP for Lua
    motrix # Download manager
    nautilus # GNOME file manager
    neovim # Extensible Vim-based editor
    networkmanagerapplet # NetworkManager system tray applet
    nerd-fonts.comic-shanns-mono # Monospace font
    obs-studio # recording software
    openconnect # Cisco AnyConnect-compatible VPN client
    openvpn # OpenVPN client
    pcmanfm # Lightweight file manager
    persepolis # GUI download manager
    picard # Music tag editor (MusicBrainz)
    p7zip # 7z archive support
    proxychains # Route apps through proxy
    qbittorrent # Torrent client
    scrcpy # Mirror & control Android devices
    stacer # Linux system optimizer & monitor
    starship # Minimal, fast shell prompt
    slurp # Select screen region (Wayland)
    swww # Wayland wallpaper setter
    tor # Anonymity network client
    tor-browser # Anonymous web browser
    unrar # Extract RAR archives
    vim # Classic text editor
    vlc # Media player
    v2rayn # GUI for V2Ray proxy
    waybar # Customizable Wayland status bar
    waypaper # GUI wallpaper picker for Wayland
    wezterm # GPU-accelerated terminal
    wl-clipboard # Wayland clipboard tools
    wofi # Application launcher for Wayland
    youtube-music # YouTube Music desktop app
    yazi # Terminal file manager
    zellij # Terminal workspace multiplexer
    zoxide # Smarter "cd" command
    zulu # OpenJDK Java runtime
    # Python
    python313 # Python 3.13 interpreter
    python313Packages.pip # Python package installer
    # Unstable-Packages
    pkgsUnstable.rmpc # A music player or CLI tool
  ];
}
