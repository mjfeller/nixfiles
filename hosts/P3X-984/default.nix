{
  nixpkgs,
  darwin,
  home-manager,
  ...
}: let
  system = "x86_64-darwin";
  pkgs = import nixpkgs {
    inherit system;

    pkgs = nixpkgs;
    config.allowUnfree = true;
  };
in
  darwin.lib.darwinSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      home-manager.darwinModules.home-manager
      {nix.nixPath = ["nixpkgs=${nixpkgs}"];}
      {nix.registry.nixpkgs.flake = nixpkgs;}
    ];
  }
