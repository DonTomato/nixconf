{ config, pkgs, wm, ... }:

let
  wallpaper = ./../wallpapers/Nova.png;
  mod = "Mod4";
  isSway = wm == "sway";
  isHyprland = wm == "hyprland";
in {
  home.username = "michael";
  home.homeDirectory = "/home/michael";

  home.packages = with pkgs; [
    signal-desktop
    bitwarden-desktop
    neovim
    nil
  ];

  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.profileDirectory}/share:/usr/share";
  };

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Тёмная тема по умолчанию
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Сообщает xdg-desktop-portal предпочтение тёмной темы
  # (читают Electron, Chromium, Firefox, GTK4 и др.)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  programs.alacritty = {
    enable = true;
    settings.font.size = 10.0;
  };

  # sway
  wayland.windowManager.sway = {
    enable = isSway;

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
        "${mod}+Ctrl+l" = "exec swaylock -f -c 000000 && sleep 1 && systemctl suspend ";

        # Audio buttons
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        # Change brightness
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
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

  # hyprland
  wayland.windowManager.hyprland = {
    enable = isHyprland;

    settings = {
      "$mod" = "SUPER";

      monitor = [ ", preferred, auto, 1" ];

      input = {
        kb_layout = "us,no,ru";
        touchpad = {
          natural_scroll = true;
          scroll_factor = "0.5";
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(1e1e2e)";
      };

      decoration = {
        rounding = 8;
      };

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, D, exec, wofi --show drun"
        "$mod, F, fullscreen"
        "$mod SHIFT, Space, togglefloating"

        # фокус окон
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, Left, movefocus, l"
        "$mod, Down, movefocus, d"
        "$mod, Up, movefocus, u"
        "$mod, Right, movefocus, r"

        # перемещение окон
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, Left, movewindow, l"
        "$mod SHIFT, Down, movewindow, d"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, Right, movewindow, r"

        # переключение workspace
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # перемещение окон в workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # scratchpad
        "$mod SHIFT, Minus, movetoworkspace, special"
        "$mod, Minus, togglespecialworkspace"

        # lock screen
        "$mod CTRL, L, exec, swaylock -f -c 000000 && sleep 1 && systemctl suspend"

        # languages
        "CTRL, 1, exec, hyprctl switchxkblayout all 0"
        "CTRL, 2, exec, hyprctl switchxkblayout all 1"
        "CTRL, 3, exec, hyprctl switchxkblayout all 2"
      ];

      # resize с мышью
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        # Audio
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      exec-once = [
        "waybar"
        "swaybg -i ${wallpaper} -m fill"
        "blueman-applet"
      ];
    };
  };

  # waybar
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";

      modules-left =
        if isSway then [ "sway/workspaces" "sway/mode" ]
        else [ "hyprland/workspaces" ];

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };

      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "backlight"
        "battery"
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
        format = "🔋{capacity}%";
        format-charging = "⚡{capacity}%";
      };

      pulseaudio = {
        format = "{icon}{volume}%";
        format-muted = "🔇";
        format-icons = {
          default = [ "🔈" "🔉" "🔊" ];
        };
      };

      backlight = {
        device = "intel_backlight";
        format = "☀️{percent}%";
      };

      "custom/lang" = {
        exec =
          if isSway then ''
            swaymsg -t get_inputs \
            | grep -A 10 xkb_active_layout_name \
            | grep name \
            | head -1 \
            | cut -d '"' -f4 \
            | sed 's/English.*/EN/; s/Norwegian.*/NO/; s/Russian.*/RU/'
          '' else ''
            hyprctl devices -j \
            | grep -A 2 active_keymap \
            | grep active_keymap \
            | head -1 \
            | cut -d '"' -f4 \
            | sed 's/English.*/EN/; s/Norwegian.*/NO/; s/Russian.*/RU/'
          '';
        interval = 1;
      };
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font Mono", "JetBrainsMono NFM", monospace;
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

      #clock, #cpu, #memory, #network, #battery, #custom-lang, #backlight, #pulseaudio {
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
