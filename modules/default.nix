{ inputs, lib, config, pkgs, ... } :
let
  inherit (lib.ram) enabled;
in
{
  imports = [
    ./nvf_conf.nix
    inputs.nvf.nixosModules.default
  ];
}
