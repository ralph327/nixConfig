{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.ram) enabled;
in {
  #services.sxhkd = lib.mkIf config.services.sxhkd.enable {
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + alt + {q,r}" = "bspc {quit, wm -r}";
      "ctrl + alt + t" = "terminology";
      "super + {_, shift +}q" = "bspc node -{c,k}";

      # make sxhkd reload its configuration files
      "super + Escape" = "pkill -USR1 -x sxhkd";
      # alternate between the tiled and monocle layout
      "super + m" = "bspc desktop -l next";
      # set the window state
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "alt + tab" = "bspc node -f next.local";
    };
  };
  systemd.user.services = {
    "polybar" = {
      Unit = {
        Description = "Polybar";
        After = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.polybar}/bin/polybar";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
  xdg.configFile."polybar/config.ini".source = ./polybar.conf;
}
