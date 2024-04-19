{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    bemenu
    wl-clipboard
    xdg-utils
    xwayland
  ];

  programs.river.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
}
