{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  inputs.home-manager.url = "github:nix-community/home-manager/release-22.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";
  inputs.emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    nixpkgs,
    home-manager,
    emacs-overlay,
    sops-nix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
      overlays = [
        (import emacs-overlay)
        (import ./overlays)
      ];
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Provide system wide configuration for all things nixos.
    nixosConfigurations.mjf = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      inherit system;

      modules = [
        ./system
        sops-nix.nixosModules.sops
      ];
    };

    # Provide the home manager configuration for managing user
    # specific packages and dot files.
    homeConfigurations.mjf = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      inherit system;

      configuration = ./home;
      homeDirectory = "/home/mjf";
      username = "mjf";
    };
  };
}
