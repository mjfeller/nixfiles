{
  config,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sx.enable = true;
    windowManager.dwm.enable = true;
    exportConfiguration = true;
    layout = "us";
  };

  environment.systemPackages = with pkgs; [
    dmenu
    killall
    st
    xclip
    xorg.xkill
  ];
}
