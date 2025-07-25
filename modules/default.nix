{ inputs, lib, config, pkgs, ... } :
let
  inherit (lib.ram) enabled;
in
{
  imports = [
    ./nvf_conf.nix
    inputs.nvf.nixosModules.default
  ];
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
  ];
}
