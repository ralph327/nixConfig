{
  description = "ram-nixos";

  inputs = {
    # Used for System Packages
    nixpkgs.url = "nixpkgs/nixos-25.05";
    
    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Use system packages list where available
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
          ram-nixos = lib.nixosSystem {
            modules = [ ./configuration.nix ./hosts/ram-nixos/hardware.nix];
	  };
	  ramv-nixos = lib.nixosSystem {
	    modules = [ ./configuration.nix ./hosts/ramv-nixos/hardware.nix];
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
