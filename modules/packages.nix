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
    emacs-pgtk
    git
    mc
    bitwarden-desktop
    rclone
  ];
}
