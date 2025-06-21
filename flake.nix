{
  description = "A very basic flake";

  inputs = {
    # catppuccin
    catppuccin.url = "github:catppuccin/nix";

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

    # nixos-hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    catppuccin,
    disko,
    home-manager,
    nixpkgs,
    nixos-hardware,
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
          (import ./systems/david/configuration.nix)

          # catppuccin
          catppuccin.nixosModules.catppuccin

          # disko
          disko.nixosModules.disko

          # hardware
          nixos-hardware.nixosModules.dell-latitude-7390

          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
              catppuccin.homeModules.catppuccin
            ];
            home-manager.users."${username}" = import ./users/${username}.nix;
            users.users.${username} = {
              isNormalUser = true;
              extraGroups = [ "networkmanager" "wheel" ];
            };
          }
        ];
        specialArgs = { inherit inputs username; };
      };
    };
  };
}
