{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
  ];
}