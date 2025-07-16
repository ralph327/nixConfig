{lib, pkgs, config, ...} :
let
  inherit (lib.ram) enabled;
in
{
  systemd.user.services = {
    "polybar" = {
      Unit = {
        Description = "Polybar";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polybar}/bin/polybar";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
  xdg.configFile."polybar/config.ini".source = ./polybar.conf;
}
