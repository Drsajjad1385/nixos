{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
      libva
      libva-utils
    ];
  };

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  hardware.i2c.enable = true;
}
