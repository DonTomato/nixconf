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
      modifier = "Mod4"; # Win key

      terminal = "alacritty";

      keybindings = let
        mod = "Mod4";
      in {
        "${mod}+Return" = "exec alacritty";

        # переключение workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";

        # перемещение окон
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";

        # базовое
        "${mod}+q" = "kill";
        "${mod}+d" = "exec dmenu_run";
      };

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
