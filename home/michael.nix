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

      input = {
        "*" = {
          xkb_layout = "us,no,ru";
          xkb_options = "grp:alt_shift_toggle";
        };
      };

      output = {
        "eDP-1" = {
          scale = "1.2";
        };
      };

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

        # фокус окон
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # фокус окон: стрелки
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        
        # перемещение окон
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # перемещение окон: стрелки
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # layout (то, что ты хотел)
        "${mod}+v" = "split v";
        "${mod}+b" = "split h";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # fullscreen / float
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";

        # resize mode
        "${mod}+r" = "mode resize";

        # languages
        "Ctrl+1" = "input type:keyboard xkb_switch_layout 0";
        "Ctrl+2" = "input type:keyboard xkb_switch_layout 1";
        "Ctrl+3" = "input type:keyboard xkb_switch_layout 2";
      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px";
          "j" = "resize grow height 10 px";
          "k" = "resize shrink height 10 px";
          "l" = "resize grow width 10 px";

          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";

          "Return" = "mode default";
          "Escape" = "mode default";
        };
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

      modules-left = [ "sway/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "battery"
        "keyboard-state"
        "custom/lang"
      ];

      clock = {
        format = "{:%H:%M}";
      };

      cpu = {
        format = "CPU {usage}%";
      };

      memory = {
        format = "RAM {}%";
      };

      network = {
        format-wifi = "{essid}";
        format-ethernet = "eth";
        format-disconnected = "offline";
      };

      battery = {
        format = "{capacity}%";
        format-charging = "⚡ {capacity}%";
      };

      "keyboard-state" = {
        numlock = false;
        capslock = true;
        format = "{name}";
      };

      "custom/lang" = {
        exec = "swaymsg -t get_inputs | grep -A 10 xkb_active_layout_name | grep name | head -1 | cut -d '\"' -f4";
        interval = 1;
      };
    }];
  };
}
