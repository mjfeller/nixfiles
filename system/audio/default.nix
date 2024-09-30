{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pipewire
    pulsemixer
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
