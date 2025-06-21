{ ... }:

{
  # power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # prevent overheating on intel cpus
  services.thermald.enable = true;

  # tlp battery management
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
}
