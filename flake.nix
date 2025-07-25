{
  description = "A very basic flake";

  inputs = {
    # disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-gaming
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # nixos-hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      disko,
      home-manager,
      nix-gaming,
      nixpkgs,
      nixos-hardware,
      plasma-manager,
      stylix,
      ...
    }@inputs:
    let
      username = "luis";
      system = "x86_64-linux";
    in
    {
      # nixos
      nixosConfigurations = {
        david = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # configuration
            (import ./systems/david/configuration.nix)

            # disko
            disko.nixosModules.disko

            # gaming
            nix-gaming.nixosModules.pipewireLowLatency

            # hardware
            nixos-hardware.nixosModules.dell-latitude-7390

            # home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                plasma-manager.homeManagerModules.plasma-manager
              ];
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users."${username}" = import ./users/${username}.nix;
              users.users.${username} = {
                isNormalUser = true;
                extraGroups = [
                  "networkmanager"
                  "wheel"
                  "gamemode"
                ];
              };
            }

            # stylix
            stylix.nixosModules.stylix
          ];
          specialArgs = { inherit inputs username; };
        };
      };
    };
}
