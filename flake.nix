
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

  outputs = { self, nixpkgs, nvf, home-manager, ... }@inputs:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib.extend (
        self: super: {
          ram = import ./lib {
            inherit inputs;
	    lib = self;
          };
        }
      );

      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
          ram-nixos = lib.nixosSystem {
	    specialArgs = {
              inherit inputs;
	      inherit lib;
              inherit system;
	    };
            modules = [ 
              ./hosts/ram-nixos/configuration.nix 
            ];
	  };
	  ramv-nixos = lib.nixosSystem {
	    specialArgs = {
	      inherit inputs;
	      inherit lib;
              inherit system;
	    };
	    modules = [ 
              ./hosts/ramv-nixos/configuration.nix 
            ];
	  }; 
      };
      homeConfigurations = {
        "rafael@ram-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ./home/hosts/ram-nixos ];
        };
        "rafael@ramv-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ./home/hosts/ramv-nixos ];
        };
      };
    };
}
