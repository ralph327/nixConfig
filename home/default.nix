#      ___
#     / / |__   ___  _ __ ___   ___
#    / /| '_ \ / _ \| '_ ` _ \ / _ \
# _ / / | | | | (_) | | | | | |  __/
#(_)_/  |_| |_|\___/|_| |_| |_|\___|
#

{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rafael";
  home.homeDirectory = "/home/rafael";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "ralph327";
    userEmail = "rafael.adan.martinez@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
  };

  imports =
    [

    ];

}
