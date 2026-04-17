{ config, pkgs, ... }:

let
  wallpaper = ./../wallpapers/nix-wallpaper-dracula.png;
in {
  home.username = "michael";
  home.homeDirectory = "/home/michael";

  home.stateVersion = "25.11";
    
  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    settings.font.size = 10.0;
  };

  # sway
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4"; # Win key

      bars = [];

      terminal = "alacritty";

      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";

          # decrease scroll speed
          scroll_factor = "0.5";
        };
        
        "*" = {
          xkb_layout = "us,no,ru";
          # xkb_options = "grp:alt_shift_toggle";
        };
      };

      output = {
        "eDP-1" = {
          scale = "1.3";
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
        "${mod}+d" = "exec wofi --show drun";

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

        # changing layout
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

        # отправить окно в scratchpad
        "${mod}+Shift+minus" = "move scratchpad";

        # показать / скрыть
        "${mod}+minus" = "scratchpad show";

        # languages
        "Ctrl+1" = "input type:keyboard xkb_switch_layout 0";
        "Ctrl+2" = "input type:keyboard xkb_switch_layout 1";
        "Ctrl+3" = "input type:keyboard xkb_switch_layout 2";

        # lock screen
        "${mod}+Ctrl+l" = "exec swaylock -f -c 000000";

        # Audio buttons
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
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
        { command = "swaybg -i ${wallpaper} -m fill"; }
        { command = "blueman-applet"; }
      ];
    };
  };

  # waybar
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";

      modules-left = [ "sway/workspaces" "sway/mode" ];

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };

      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "battery"
        # "keyboard-state"
        "pulseaudio"
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

      pulseaudio = {
        format = "VS:{volume}%";
      };

      #"keyboard-state" = {
      #  numlock = false;
      #  capslock = true;
      #  format = "{name}";
      #};

      "custom/lang" = {
        exec = ''
          swaymsg -t get_inputs \
          | grep -A 10 xkb_active_layout_name \
          | grep name \
          | head -1 \
          | cut -d '"' -f4 \
          | sed 's/English.*/EN/; s/Norwegian.*/NO/; s/Russian.*/RU/'
        '';
        interval = 1;
      };
    }];

    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
      }

      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 5px;
      }

      #workspaces button.focused {
        background: #89b4fa;
        color: #1e1e2e;
      }

      #clock, #cpu, #memory, #network, #battery, #custom-lang {
        padding: 0 10px;
      }

      #custom-lang {
        background: #054d18;
        margin-left: 10px;
        border-radius: 5px;
      }

      #mode {
        color: #ffffff;
        background: #e06c75;
        padding: 0 10px;
        margin-left: 10px;
        border-radius: 5px;
      }
    '';
  };

  xdg.configFile."wofi/config".text = ''
    show=drun
    allow_images=true
    width=600
    height=400
    location=center
    prompt=Search...
    hide_scroll=true
    gtk_dark=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    * {
      font-family: monospace;
      font-size: 14px;
    }

    window {
      background-color: rgba(30, 30, 46, 0.95);
      border-radius: 12px;
      border: 2px solid #89b4fa;
    }

    #outer-box {
      margin: 10px;
      padding: 10px;
    }

    #input {
      margin: 10px;
      padding: 8px;
      border-radius: 8px;
      border: none;
      background-color: #1e1e2e;
      color: #cdd6f4;
    }

    #inner-box {
      margin: 10px;
    }

    #entry {
      padding: 8px;
      border-radius: 8px;
    }

    #entry:selected {
      background-color: #89b4fa;
      color: #1e1e2e;
    }

    #img {
      margin-right: 10px;
    }

    #text {
      color: #cdd6f4;
    }
  '';
}
