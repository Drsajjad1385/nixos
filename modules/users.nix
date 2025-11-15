{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;

  users.users.sajjad = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "plugdev" "docker"];
  };
}
