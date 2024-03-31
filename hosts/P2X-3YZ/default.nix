{
  nixpkgs,
  sops-nix,
  home-manager,
  emacs-overlay,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;

    pkgs = nixpkgs;
    config.allowUnfree = true;
    overlays = [
      (import emacs-overlay)
    ];
  };
in
  nixpkgs.lib.nixosSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
    ];
  }
