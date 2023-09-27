{
  config,
  pkgs,
  ...
}: {
  # sx is a simple alternative to both xinit(1) and startx(1) for
  # starting an Xorg server.
  xdg.configFile."sx/sxrc".source = pkgs.writeShellScript "sxrc" "exec dbus-launch dwm";
}
