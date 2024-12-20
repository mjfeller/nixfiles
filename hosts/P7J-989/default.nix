{
  nixpkgs,
  darwin,
  home-manager,
  emacs-overlay,
  mac-app-util,
  ...
}: let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;

    pkgs = nixpkgs;
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
      mac-app-util.darwinModules.default
      home-manager.darwinModules.home-manager
      {nix.nixPath = ["nixpkgs=${nixpkgs}"];}
      {nix.registry.nixpkgs.flake = nixpkgs;}
    ];
  }
