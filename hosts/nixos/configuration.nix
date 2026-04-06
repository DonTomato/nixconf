{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system.nix
    ../../modules/users.nix
    ../../modules/packages.nix
    ../../modules/desktop.nix
    ../../modules/fonts.nix
    ../../modules/env.nix
    ../../modules/sway.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}
