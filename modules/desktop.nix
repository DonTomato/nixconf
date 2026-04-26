{ config, pkgs, wm, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us,no,ru";
    variant = "";
  };

  hardware.graphics.enable = true;

  programs.hyprland.enable = (wm == "hyprland");

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
