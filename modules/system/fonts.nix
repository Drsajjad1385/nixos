{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
    nerd-fonts.jetbrains-mono
  ];
}
