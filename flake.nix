{
  description = "ram-nixos";

  inputs = {
    # Used for System Packages
    nixpkgs.url = "nixpkgs/nixos-25.05";
    
    # Neovim Config
    nvf.url = "github:notashelf/nvf";
 
    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Use system packages list where available
    };
  };

  outputs = { self, nixpkgs, nvf, home-manager, ... }:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
          ram-nixos = lib.nixosSystem {
            modules = [ 
              ./hosts/ram-nixos/configuration.nix 
              ./hosts/ram-nixos/hardware.nix
            ];
	  };
	  ramv-nixos = lib.nixosSystem {
	    modules = [ 
              ./hosts/ramv-nixos/configuration.nix 
              ./hosts/ramv-nixos/hardware.nix
              nvf.nixosModules.default
              ./nvf_conf.nix
            ];
	  }; 
      };
      homeConfigurations = {
        rafael = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
