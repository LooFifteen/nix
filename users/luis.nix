{ pkgs, lib, ... }:

{
  # modules
  imports = [
    # desktop environment
    ../modules/home/plasma.nix

    # applications
    # ../modules/home/youtui.nix
    ../modules/home/browser/firefox.nix
  ];

  # 1password signing
  programs = {
    ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ~/.1password/agent.sock
      '';
    };
    git = {
      enable = true;
      extraConfig = {
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        commit.gpgsign = true;
      };
    };
  };

  # metadata
  home.stateVersion = "25.05";
}