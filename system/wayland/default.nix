{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    dwl
    dmenu-wayland
    alacritty
    xwayland
    wl-clipboard
  ];
}
