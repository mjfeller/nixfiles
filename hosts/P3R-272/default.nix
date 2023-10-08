{
  nixpkgs,
  sops-nix,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };
in
  nixpkgs.lib.nixosSystem rec {
    inherit system;
    inherit pkgs;

    modules = [
      ./system.nix
      sops-nix.nixosModules.sops
    ];
  }
