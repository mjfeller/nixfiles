{
  nixpkgs-darwin,
  darwin,
  home-manager-darwin,
  emacs-overlay,
  ...
}: let
  system = "aarch64-darwin";
  pkgs = import nixpkgs-darwin {
    inherit system;

    pkgs = nixpkgs-darwin;
    config.allowUnfree = true;
    overlays = [
      (import emacs-overlay)
    ];
  };
in
  darwin.lib.darwinSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      home-manager-darwin.darwinModules.home-manager
      { nix.nixPath = [ "nixpkgs=${nixpkgs-darwin}" ]; }
      { nix.registry.nixpkgs.flake = nixpkgs-darwin; }
    ];
  }
