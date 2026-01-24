{
  description = "my laptop cute system config uwu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      aagl,
      nix-index-database,
      ...
    }:
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = ./home.nix;
          }
          {
            imports = [
              aagl.nixosModules.default
            ];
            nix.settings = aagl.nixConfig; # Set up Cachix
            programs.anime-game-launcher.enable = true;
            # programs.anime-games-launcher.enable = true;
            # programs.honkers-railway-launcher.enable = true;
            # programs.honkers-launcher.enable = true;
            # programs.wavey-launcher.enable = true;
            programs.sleepy-launcher.enable = true;
          }
          nix-index-database.nixosModules.default
          { programs.nix-index-database.comma.enable = true; }
          ./hardware-configuration.nix
        ];
      };
    };
}
