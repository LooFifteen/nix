{ ... }:

{
  # nixpkgs
  nixpkgs.config.allowUnfree = true;

  # nix
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}