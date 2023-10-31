{
  description = "Mark's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-darwin.url = "github:nix-community/home-manager/release-23.05";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.inputs.nixpkgs-stable.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs";
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
  } @ inputs: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;

    nixosConfigurations = {
      P2X-3YZ = import ./hosts/P2X-3YZ inputs; # Desktop
      P3R-272 = import ./hosts/P3R-272 inputs; # Media Fetcher
      P4X-347 = import ./hosts/P4X-347 inputs; # Media Player Server
    };

    darwinConfigurations = {
      p2s-4c3 = import ./hosts/P2S-4C3 inputs; # Work Laptop MacBook Pro M1
      P3X-984 = import ./hosts/P3X-984 inputs; # 16" MacBook Pro 2019
    };
  };
}
