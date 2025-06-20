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
    
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    disko,
    home-manager,
    nixpkgs,
    plasma-manager,
    ...
  } @ inputs: let
    username = "luis";
    system = "x86_64-linux";
  in {
    # nixos
    nixosConfigurations = {
      david = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # configuration
          ./systems/david/configuration.nix

          # disko
          disko.nixosModules.disko

          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
            home-manager.users."${username}" = import ./users/${username}.nix;
            users.users.${username}.isNormalUser = true;
          }
        ];
        specialArgs = { inherit inputs username; };
      };
    };
  };
}
