{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
    '';

    extraConfig = ''
      exec_always waybar
    '';
  };
}
