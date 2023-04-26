{
  config,
  pkgs,
  ...
}: {
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Make sudo use Touch ID for easier auth
  security.pam.enableSudoTouchIdAuth = true;

  # Remap caps lock to control like a sane person
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew.enable = true;
  homebrew.brews = [
    "emacs-plus@30"
  ];
}
