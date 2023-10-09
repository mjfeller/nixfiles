{
  nixpkgs-darwin,
  darwin,
  home-manager,
  ...
}: let
  system = "x86_64-darwin";
  pkgs = import nixpkgs-darwin {
    inherit system;

    pkgs = nixpkgs-darwin;
    config.allowUnfree = true;
  };
in
  darwin.lib.darwinSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      home-manager.darwinModules.home-manager
    ];
  }
