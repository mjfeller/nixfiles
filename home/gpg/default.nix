{ config, pkgs, ... }: {
  home.file = {
    ".gnupg/gpg-agent.config".source = ./files/gpg-agent.conf;
  };
}
