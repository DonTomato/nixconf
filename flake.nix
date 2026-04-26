{
  description = "Mikhail NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";

    commonModules = [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.michael = import ./home/michael.nix;
      }
    ];

    mkHost = hostPath: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ hostPath ] ++ commonModules;
    };
  in
  {
    nixosConfigurations = {
      lite = mkHost ./hosts/lite/configuration.nix;
      ws   = mkHost ./hosts/ws/configuration.nix;
    };
  };
}
