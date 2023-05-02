{
  description = "Mark's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager-darwin.url = "github:nix-community/home-manager/release-22.11";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-darwin,
    darwin,
    home-manager,
    home-manager-darwin,
    emacs-overlay,
    sops-nix,
    ...
  }: let
    x86_64-linx-pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        (import emacs-overlay)
        (import ./overlays)
      ];
    };
  in {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;

    # P2X-3YZ -- Desktop
    homeConfigurations.mjf = home-manager.lib.homeManagerConfiguration {
      pkgs = x86_64-linx-pkgs;
      modules = [./hosts/mjf/home.nix];
    };

    nixosConfigurations.mjf = nixpkgs.lib.nixosSystem {
      pkgs = x86_64-linx-pkgs;
      system = "x86_64-linux";
      modules = [./hosts/mjf/system.nix sops-nix.nixosModules.sops];
    };

    # P3X-984 -- 16" MacBook Pro 2019
    homeConfigurations.P3X-984 = home-manager-darwin.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages.x86_64-darwin;
      modules = [./hosts/P3X-984/home.nix];
    };

    darwinConfigurations.P3X-984 = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [./hosts/P3X-984/system.nix];
    };

    # P2S-4C3 -- Work Laptop MacBook Pro M1
    homeConfigurations.P2S-4C3 = home-manager-darwin.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages.aarch64-darwin;
      modules = [./hosts/P2S-4C3/home.nix];
    };

    darwinConfigurations.P2S-4C3 = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [./hosts/P2S-4C3/system.nix];
    };
  };
}
