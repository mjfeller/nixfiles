{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system
    ../../system/macos
    ../../system/ssh/ssh_known_hosts.nix
  ];

  # Setup primary user
  users.users.mjf = {
    name = "mfeller";
    home = "/Users/mfeller";
  };

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    shellcheck
    bazel_6
    cargo
    cmake
    go
    home-manager
    rust-analyzer
    rustc
    rustfmt
  ];
}
