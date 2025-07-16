{lib, pkgs, config, ...} :
let
  inherit (lib.ram) enabled;
in
{
  services.sxhkd = lib.mkIf config.services.sxhkd.enable {
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
    "albert" = {
      Unit = {
        Description = "Albert Launcher";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.albert}/bin/albert";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
  xdg.configFile."albert/config".source = ./albert.conf;
}
