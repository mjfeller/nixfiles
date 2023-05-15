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

  system.defaults.dock.autohide = true;
  system.defaults.dock.mineffect = "scale";
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-process-indicators = false;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.static-only = true;
  system.defaults.dock.tilesize = 64;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.Dragging = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew.enable = true;
  homebrew.brews = [
    "emacs-plus@30"
  ];
}
