# This is a placeholder.
# Generate the real file on the laptop by running:
#   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
# Then replace this file with the output.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # TODO: replace with actual hardware config from nixos-generate-config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
