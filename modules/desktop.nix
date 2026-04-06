{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us,no,ru";
    variant = "";
  };

  programs.sway.enable = true;

  hardware.graphics.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "michael";
      };
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
