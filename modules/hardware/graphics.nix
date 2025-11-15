{pkgs, ...}: {
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
}
