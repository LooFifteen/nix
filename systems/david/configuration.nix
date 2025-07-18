{
  pkgs,
  ...
}:

{
  imports = [
    # disk formatting
    ./disko.nix

    # hardware
    ./hardware-configuration.nix

    # modules
    ../../modules/system/bootloader/systemd-boot.nix
    ../../modules/system/desktop/plasma.nix
    ../../modules/system/desktop/wayland.nix
    ../../modules/system/firmware.nix
    ../../modules/system/nixos.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/power.nix
    ../../modules/system/network.nix
    ../../modules/system/performance.nix

    # applications
    ../../modules/system/applications/1password.nix
    ../../modules/system/applications/discord.nix
  ];

  # hostname
  networking.hostName = "david";

  # theming
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  };

  # dell
  environment.systemPackages = with pkgs; [
    dell-command-configure
  ];

  # disk
  services.btrfs.autoScrub.enable = true;
  services.fstrim.enable = true;

  # games
  programs.gamemode.enable = true;

  # easyeffects
  programs.dconf.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
