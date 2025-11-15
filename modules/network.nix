{...}: {
  networking = {
    hostName = "sajjad";
    networkmanager.enable = true;
    nameservers = ["8.8.8.8" "8.8.4.4"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.enable = false;
  };
}
