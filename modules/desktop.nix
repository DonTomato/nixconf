{ config, pkgs, wm, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us,no,ru";
    variant = "";
  };

  hardware.graphics.enable = true;

  programs.hyprland.enable = (wm == "hyprland");

  # XDG portal — нужен чтобы приложения могли читать системную тему (color-scheme)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]
      ++ pkgs.lib.optional (wm == "hyprland") pkgs.xdg-desktop-portal-hyprland;
    config.common.default = "*";
  };

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${wm}";
        user = "michael";
      };
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
