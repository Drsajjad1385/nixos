{...}: {
  networking = {
    hostName = "nixos";
    networkmanager = {
        enable = true;
        dns = "none";
      };
    nameservers = ["8.8.8.8" "8.8.4.4"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.enable = false;
  };
}
