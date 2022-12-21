{
  config,
  pkgs,
  ...
}: {
  # ----------------------------------------------------------------------
  #  Tailscale

  # Tailscale lets you easily manage access to private resources, quickly SSH
  # into devices on your network, and work securely from anywhere in the world.
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [tailscale jq];

  # create a oneshot job to authenticate to Tailscale
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";
    after = ["network-pre.target" "tailscale.service"];
    wants = ["network-pre.target" "tailscale.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "oneshot";
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up -authkey $(cat /run/secrets/tailscale/authkey)
    '';
  };
}
  
