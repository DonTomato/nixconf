{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code

    # fonts with icon
    nerd-fonts.jetbrains-mono
  ];
}
