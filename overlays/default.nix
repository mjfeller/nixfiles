final: prev: {
  # Custom builds of suckless utilities using local files. This
  # makes iteration easy, but requires the files to be available
  # locally.
  dmenu-wayland = prev.dmenu-wayland.overrideAttrs (old: {src = prev.fetchFromGitHub {
    owner = "mjfeller";
    repo = "dmenu-wayland";
    rev = "cbcd7373a194a333ae284b10fe6eb14cf238a639";
    sha256 = "sha256-60535xktWIHh3PchnvxfdqiJjZb/HuKrky3veOjm9u0=";
  };});

  dmenu = prev.dmenu.overrideAttrs (old: {src = prev.fetchFromGitHub {
    owner = "mjfeller";
    repo = "dmenu";
    rev = "8ce94ff0ee52650003e8b297fd6a349dd106ed48";
    sha256 = "sha256-UNpouco5F9/kht0PjT17Bi6WsuKIUP2USwFekwDmFF0=";
  };});

  dwm = prev.dwm.overrideAttrs (old: {src = prev.fetchFromGitHub {
    owner = "mjfeller";
    repo = "dwm";
    rev = "e2f5118905551dcc1d216e4310e609d109601787";
    sha256 = "sha256-EU9N6UR4y5zro/FvGskd5zamPbGyfZr7B4qw7KUpy2Y=";
  };});

  st = prev.st.overrideAttrs (old: {src = prev.fetchFromGitHub {
    owner = "mjfeller";
    repo = "st";
    rev = "75a75952bd1c6be59cfdad20a1909337fb876dfa";
    sha256 = "sha256-NDkzESmVgJp4dSgidPoAmafmaaeS+38QWBWemK1vpX4=";
  };});

  dwl = prev.dwl.overrideAttrs (old: {src = prev.fetchFromGitHub {
    owner = "mjfeller";
    repo = "dwl";
    rev = "886ea19633860732e5bdbb212d41a9a24986a61a";
    sha256 = "sha256-gzvXvNVvE0lTJ5T8t48t8EWusVYrfLitAglx63AW5Kk=";
  };});

  # # The brave build from the repos seems to only support
  # # x11. This quick hack switches it over to run on wayland.
  # brave = prev.brave.overrideAttrs (old: {
  #   installPhase =
  #     old.installPhase
  #     + ''
  #       rm $out/bin/brave

  #       makeWrapper $BINARYWRAPPER $out/bin/brave \
  #         --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
  #     '';
  # });
}
