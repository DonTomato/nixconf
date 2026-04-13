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
    signal-desktop
    firefox
    emacs-pgtk
    git
    mc
    bitwarden-desktop
    rclone
    wofi
    papirus-icon-theme
    btop
    qalculate-gtk
    blueman
    imv
    thunar
    yazi
    zig
    zls
    mpv
    celluloid
    neovim
    ripgrep
  ];
}
