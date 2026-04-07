{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    sway
    swaybg
    swayidle
    swaylock
    waybar
    alacritty
    dmenu
    wl-clipboard
    grim
    slurp
    firefox
    emacs
    git
    mc
    bitwarden-desktop
    rclone
  ];
}
