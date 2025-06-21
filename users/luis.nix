{ pkgs, lib, ... }:

{
  # modules
  imports = [
    # desktop environment
    ../modules/home/plasma.nix

    # shell
    ../modules/home/shell/bash.nix

    # misc
    ../modules/home/direnv.nix

    # applications
    # ../modules/home/youtui.nix
  ];

  # applications
  programs = {
    firefox.enable = true;
  };

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
      lfs.enable = true;

      userName = "Luis";
      userEmail = "luis@lu15.dev";

      extraConfig = {
        gpg = {
          format = "ssh";
          ssh.program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
        };
        commit.gpgsign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGa7ariENxxCPKeSOgovQravmd5NgzvA30E+fI5kaBN6";
      };
    };
  };

  # vscode
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        mkhl.direnv
        jnoortheen.nix-ide
        christian-kohler.path-intellisense
      ];
      enableUpdateCheck = false;

      # settings
      userSettings = {
        nix = {
          enableLanguageServer = true;
          serverPath = "nixd";
          serverSettings.nixd.formatting.command = [ "nixfmt" ];
        };
        files.autoSave = "onFocusChange";
        git = {
          confirmSync = false; # don't warn about syncing both pulling and pushing
          autofetch = true;
        };
      };
    };
  };
  home.packages = with pkgs; [ nixfmt-rfc-style ];

  # metadata
  home.stateVersion = "25.05";
}
