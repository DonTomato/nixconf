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

    mkHost = hostPath: { wm }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit wm; };
      modules = [
        hostPath
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit wm; };
          home-manager.users.michael = import ./home/michael.nix;
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      lite = mkHost ./hosts/lite/configuration.nix { wm = "sway"; };
      ws   = mkHost ./hosts/ws/configuration.nix   { wm = "hyprland"; };
    };
  };
}
