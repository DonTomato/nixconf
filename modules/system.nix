{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  security.pam.services.swaylock = {};
}
