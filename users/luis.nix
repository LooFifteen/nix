{ pkgs, ... }:

{
  # modules
  imports = [
    # desktop environment
    ../modules/home/plasma.nix

    # applications
    # ../modules/home/youtui.nix
    ../modules/home/browser/firefox.nix
  ];

  # metadata
  home.stateVersion = "25.05";
}