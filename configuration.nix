{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # Hardware
    ./modules/boot.nix
    ./modules/network.nix
    ./modules/hardware/graphics.nix
    ./modules/hardware/audio.nix
    ./modules/hardware/bluetooth.nix

    # Desktop
    ./modules/desktop/display.nix

    # Services
    ./modules/services/mpd.nix
    ./modules/services/tailscale.nix
    ./modules/services/containers.nix

    # System
    ./modules/system/performance.nix
    ./modules/system/security.nix
    ./modules/system/fonts.nix

    # Users & Programs
    ./modules/users.nix
    ./modules/programs.nix
  ];

  # Locale & Timezone
  time.timeZone = "Asia/Tehran";
  i18n.defaultLocale = "en_US.UTF-8";

  # Nix Settings
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = false;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.substituters = ["https://cache.nixos.org"];
  nix.settings.trusted-substituters = ["https://cache.nixos.org"];
  nix.settings.cores = 16;
  nix.settings.max-jobs = 8;

  # Environment Variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    AMD_VULKAN_ICD = "RADV";
  };

  system.stateVersion = "25.11";
}
