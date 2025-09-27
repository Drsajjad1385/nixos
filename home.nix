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
    alacritty
    alejandra
    anydesk
    ayugram-desktop
    bat
    bitwarden-desktop
    bluetui
    btop
    brightnessctl
    cliphist
    duf
    dunst
    eog
    eza
    fastfetch
    filezilla
    ffmpeg
    fzf
    gearlever
    gemini-cli
    gnupg
    gparted
    grim
    haruna
    helix
    kitty
    kdePackages.filelight
    kdePackages.okular
    lazygit
    libnotify
    libwnck
    libgbm
    localsend
    lua-language-server
    motrix
    nautilus
    neovim
    networkmanagerapplet
    nerd-fonts.comic-shanns-mono
    obs-studio
    openconnect
    openvpn
    pcmanfm
    persepolis
    picard
    p7zip
    proxychains
    qbittorrent
    scrcpy
    stacer
    starship
    slurp
    swww
    tor
    tor-browser
    unrar
    vim
    vlc
    v2rayn
    waybar
    waypaper
    wezterm
    wl-clipboard
    wofi
    youtube-music
    yazi
    zellij
    zoxide
    zulu
    # Python
    python313
    python313Packages.pip
    # Unstable-Packages
    pkgsUnstable.rmpc 
  ];
}
