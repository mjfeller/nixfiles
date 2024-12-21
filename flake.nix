{
  description = "Mark's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".alejandra;

    nixosConfigurations = {
      P2X-3YZ = import ./hosts/P2X-3YZ inputs; # Desktop
      P3R-272 = import ./hosts/P3R-272 inputs; # Media Fetcher
      P4X-347 = import ./hosts/P4X-347 inputs; # Media Player Server
    };

    darwinConfigurations = {
      P7J-989 = import ./hosts/P7J-989 inputs; # Mac Mini M4
      P2S-4C3 = import ./hosts/P2S-4C3 inputs; # Work Laptop MacBook Pro M1
      P3X-984 = import ./hosts/P3X-984 inputs; # 16" MacBook Pro 2019
    };
  };
}
