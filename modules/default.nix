{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.ram) enabled;
in {
  imports = [
    ./nvf_conf.nix
    inputs.nvf.nixosModules.default
  ];

  /*
  ** It's perfectly fine and recommended to leave this value
  ** at the release version of the first install of this system.
  ** Before changing this value read the documentation for this option
  ** (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  */
  system.stateVersion = "25.05";

  # NETWORKING
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Package Sources
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # FONTS
  fonts.packages = with pkgs; [
    hermit
    inconsolata
    nerd-fonts.bigblue-terminal
    nerd-fonts.intone-mono
    nerd-fonts.blex-mono
    cascadia-code
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  # Default Packages
  environment.systemPackages = with pkgs; [
    pciutils
    signal-desktop
    kitty
    kitty-themes
    git
    direnv
    nix-direnv
    wget
    gparted
    caffeine-ng
    protonvpn-gui
    zoom-us
    audacity
    google-chrome
    polybar
    zsh
  ];

  # DEV Environments
  programs.direnv.enable = true;

  # KITTY
  environment.etc."xdg/kitty".source = ./kitty;

  # FLAKES
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    download-buffer-size = 500000000; # 500 MB
  };
}
