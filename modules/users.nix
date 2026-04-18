{ config, pkgs, ... }:

{
  users.users.michael = {
    isNormalUser = true;
    description = "michael";
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
    packages = [];
  };
}
