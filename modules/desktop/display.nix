{pkgs, ...}: {
  services.displayManager.ly.enable = true;
  programs.hyprland.enable = true;

  # XDG Portal support
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
  
  services.flatpak.enable = true;
  
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [pkgs.libepoxy];
    };
  };
}
