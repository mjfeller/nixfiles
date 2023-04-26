{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system
    ../../system/macos
  ];

  # Setup primary user
  users.users.mjf = {
    name = "mjf";
    home = "/Users/mjf";
  };

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    bazel_6
    cargo
    cmake
    go
    notmuch
    rust-analyzer
    rustc
    rustfmt
    transmission
  ];
}
