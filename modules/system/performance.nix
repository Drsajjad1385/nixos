{lib, ...}: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 35;
    priority = 100;
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "schedutil"; # or "powersave" for better battery-life
  services.power-profiles-daemon.enable = true;
  # CPU & Firmware
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
