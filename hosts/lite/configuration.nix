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
  ];

  networking.hostName = "lite";

  system.stateVersion = "25.11";
}
