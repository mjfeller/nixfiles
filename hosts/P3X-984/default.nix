{
  nixpkgs,
  home-manager,
  ...
}: let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;

    pkgs = nixpkgs;
    config.allowUnfree = true;
  };
in
  nixpkgs.lib.nixosSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      home-manager.darwinModules.home-manager
    ];
  }
