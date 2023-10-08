{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pipewire
    pulsemixer
  ];

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
