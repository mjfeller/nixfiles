final: prev: {
  # Custom builds of suckless utilities using local files. This
  # makes iteration easy, but requires the files to be available
  # locally.
  #
  # TODO: Create nix packages/flakes for my personalized copies.
  dmenu-wayland = prev.dmenu-wayland.overrideAttrs (old: {src = /home/mjf/development/dmenu-wayland;});
  dmenu = prev.dmenu.overrideAttrs (old: {src = /home/mjf/development/dmenu;});
  dwm = prev.dwm.overrideAttrs (old: {src = /home/mjf/development/dwm;});
  st = prev.st.overrideAttrs (old: {src = /home/mjf/development/st;});
  dwl = prev.dwl.overrideAttrs (old: {src = /home/mjf/development/dwl;});

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
