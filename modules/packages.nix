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
    ripgrep
    mc
    rclone
    wofi
    papirus-icon-theme
    btop
    qalculate-gtk

    # bluetooth manager
    blueman

    # image viewer
    imv
    # file managers
    thunar
    yazi
    # zig language
    zig
    zls

    # video player
    mpv
    celluloid
    
    # pactl - to change sound volume
    pulseaudio

    # change brightness of screen
    brightnessctl
  ];
}
