{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_lqx;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        splashImage = "/home/sajjad/SelfHosted/nixos/background.jpg";
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
