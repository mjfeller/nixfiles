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
  } @ inputs: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;

    # Linux
    nixosConfigurations.P2X-3YZ = import ./hosts/P2X-3YZ inputs; # P2X-3YZ -- Desktop
    nixosConfigurations.P3R-272 = import ./hosts/P3R-272 inputs; # P3R-272 -- Media Fetcher
    nixosConfigurations.P4X-347 = import ./hosts/P4X-347 inputs; # P4X-347 -- Media Player Server

    # macOS
    darwinConfigurations.p2s-4c3 = import ./hosts/P2S-4C3 inputs; # P2S-4C3 -- Work Laptop MacBook Pro M1
    darwinConfigurations.p3x-984 = import ./hosts/P3X-984 inputs; # P3X-984 -- 16" MacBook Pro 2019
  };
}
