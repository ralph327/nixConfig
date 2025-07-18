{ inputs, lib, config, pkgs, ... } :
let
  inherit (lib.ram) enabled;
in
{
  imports = [
    ./bspwm_conf.nix
  ];
}
