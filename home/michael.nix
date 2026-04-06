{ config, pkgs, ... }:

{
  home.username = "michael";
  home.homeDirectory = "/home/michael";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # sway
  wayland.windowManager.sway = {
    enable = true;

    config = {
      terminal = "alacritty";

      startup = [
        { command = "waybar"; }
      ];
    };
  };

  # waybar
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";

      modules-left = [ "clock" ];
      modules-right = [ "cpu" "memory" "network" ];

      clock.format = "{:%H:%M}";
    }];
  };
}
