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
    homeConfigurations.P2X-3YZ = home-manager.lib.homeManagerConfiguration {
      pkgs = x86_64-linx-pkgs;
      modules = [./hosts/P2X-3YZ/home.nix];
    };

    nixosConfigurations.P2X-3YZ = nixpkgs.lib.nixosSystem {
      pkgs = x86_64-linx-pkgs;
      system = "x86_64-linux";
      modules = [./hosts/P2X-3YZ/system.nix sops-nix.nixosModules.sops];
    };

    # P3X-984 -- 16" MacBook Pro 2019
    homeConfigurations.p3x-984 = home-manager-darwin.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages.x86_64-darwin;
      modules = [./hosts/P3X-984/home.nix];
    };

    darwinConfigurations.p3x-984 = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [./hosts/P3X-984/system.nix];
    };

    # P2S-4C3 -- Work Laptop MacBook Pro M1
    homeConfigurations.p2s-4c3 = home-manager-darwin.lib.homeManagerConfiguration {
      pkgs = nixpkgs-darwin.legacyPackages.aarch64-darwin;
      modules = [./hosts/P2S-4C3/home.nix];
    };

    darwinConfigurations.p2s-4c3 = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [./hosts/P2S-4C3/system.nix];
    };

    # P3R-272 -- Media Fetcher
    homeConfigurations.P3R-272 = home-manager.lib.homeManagerConfiguration {
      pkgs = x86_64-linx-pkgs;
      modules = [./hosts/P3R-272/home.nix];
    };

    nixosConfigurations.P3R-272 = nixpkgs.lib.nixosSystem {
      pkgs = x86_64-linx-pkgs;
      system = "x86_64-linux";
      modules = [./hosts/P3R-272/system.nix sops-nix.nixosModules.sops];
    };

    # P4X-347 -- Media Player Server
    homeConfigurations.P4X-347 = home-manager.lib.homeManagerConfiguration {
      pkgs = x86_64-linx-pkgs;
      modules = [./hosts/P4X-347/home.nix];
    };

    nixosConfigurations.P4X-347 = nixpkgs.lib.nixosSystem {
      pkgs = x86_64-linx-pkgs;
      system = "x86_64-linux";
      modules = [./hosts/P4X-347/system.nix sops-nix.nixosModules.sops];
    };
  };
}
