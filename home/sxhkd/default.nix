{
  config,
  pkgs,
  ...
}: {
  # The Simple X HotKey Daemon provides a convinient way to setup global
  # hotkey's on Xorg window managers.
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + t" = "notify_date";
      "super + p" = "popup pulsemixer";
      "super + shift + p" = "dmenupash";
      "super + m" = "popup ncmpcpp";
      "super + shift + m" = "popup_man";
      "super + shift + BackSpace" = "prompt 'Do you really want to exit dwm?' 'killall dwm'";
      "super + BackSpace" = "prompt 'Do you really want to shutdown?' 'shutdown -h now'";
      "super + space" = "dmenu_run";
    };
  };
}
