{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    sortedMatchBlocks = {
      server = {
        hostname = "mfeller.io";
        user = "root";
      };
      "dad-server" = {
        hostname = "45.32.95.26";
        user = "root";
      };
    };
  };
}
