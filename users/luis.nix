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
    ../modules/home/youtui.nix
    ../modules/home/games.nix
  ];

  # theming
  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "teal";
  };

  programs = {
    firefox.enable = true;
    ssh = {
      enable = true;

      # 1password ssh
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

      # 1password signing
      extraConfig = {
        gpg = {
          format = "ssh";
          ssh.program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
        };
        commit.gpgsign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGa7ariENxxCPKeSOgovQravmd5NgzvA30E+fI5kaBN6";
      };
    };

    vscode = {
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
            enableSmartCommit = true;
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    # vscode lsp
    nixfmt-rfc-style
    nixd

    # youtube music
    youtube-music
  ];

  # 1password quick access
  programs.plasma.hotkeys.commands."1password-quick-access" = {
    name = "1Password Quick Access";
    key = "Ctrl+Shift+Space";
    command = lib.getExe' pkgs._1password-gui "1password --quick-access";
  };

  # metadata
  home.stateVersion = "25.05";
}
