{ ... }:

{
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.4.4.8"
    ];
    firewall.checkReversePath = "loose"; # required for wireguard
  };
}
