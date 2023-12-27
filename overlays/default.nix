final: prev: {
  # Custom builds of suckless utilities using local files. This
  # makes iteration easy, but requires the files to be available
  # locally.
  dmenu-wayland = prev.dmenu-wayland.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "mjfeller";
      repo = "dmenu-wayland";
      rev = "cbcd7373a194a333ae284b10fe6eb14cf238a639";
      sha256 = "sha256-60535xktWIHh3PchnvxfdqiJjZb/HuKrky3veOjm9u0=";
    };
  });

  dmenu = prev.dmenu.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "mjfeller";
      repo = "dmenu";
      rev = "8ce94ff0ee52650003e8b297fd6a349dd106ed48";
      sha256 = "sha256-UNpouco5F9/kht0PjT17Bi6WsuKIUP2USwFekwDmFF0=";
    };
  });

  # dwm = prev.dwm.overrideAttrs (old: { src = /home/mjf/development/dwm ;});
  dwm = prev.dwm.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "mjfeller";
      repo = "dwm";
      rev = "c8c7c4703e6ae02d064c04987abf944d37fa2628";
      sha256 = "sha256-Ch4trkTLJJ7w/C4lISyLborAgmSd4FBqKgWzArBMUTs=";
    };
  });

  # st = prev.st.overrideAttrs (old: { src = /home/mjf/development/st ;});
  st = prev.st.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "mjfeller";
      repo = "st";
      rev = "1a056793320d925ba1d189ce25240b37add53635";
      sha256 = "sha256-AHX0Igb+mqc78VUU7fcgwOgiJ609IiF099KO0LKtWyg=";
    };
  });

  # dwl = prev.dwl.overrideAttrs (old: { src = /home/mjf/development/dwl ;});
  dwl = prev.dwl.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "mjfeller";
      repo = "dwl";
      rev = "886ea19633860732e5bdbb212d41a9a24986a61a";
      sha256 = "sha256-gzvXvNVvE0lTJ5T8t48t8EWusVYrfLitAglx63AW5Kk=";
    };
  });

  # The brave build from the repos seems to only support
  # x11. This quick hack switches it over to run on wayland.
  brave = prev.brave.overrideAttrs (old: {
    installPhase =
      old.installPhase
      + ''
        rm $out/bin/brave

        makeWrapper $BINARYWRAPPER $out/bin/brave \
          --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
      '';
  });
}
