{ pkgs, ... }:

{
  # desktop environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true; # todo: move this into own module somehow?

  # printing
  services.printing.enable = true;

  # audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # provided by nix-gaming
    lowLatency.enable = true;
  };
  security.rtkit.enable = true; # found this on nix-gaming, not quite sure what it does.
  environment.systemPackages = with pkgs; [ pulseaudio ];

  # locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  console.keyMap = "uk";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # firefox
  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };
}
