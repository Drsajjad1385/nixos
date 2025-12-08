{lib, ...}: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 35;
    priority = 100;
  };

  # Power Management
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;
  # CPU & Firmware
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
