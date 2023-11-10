{
  nixpkgs-darwin,
  darwin,
  home-manager-darwin,
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
      home-manager-darwin.darwinModules.home-manager
    ];
  }
