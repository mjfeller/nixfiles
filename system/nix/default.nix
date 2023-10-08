{
  config,
  pkgs,
  ...
}: {
  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.trusted-users = ["root" "mjf"];

  environment.systemPackages = with pkgs; [
    comma
    direnv
    nix-index
  ];
}
