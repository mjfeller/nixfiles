{
  config,
  pkgs,
  ...
}: {
  networking.wg-quick.interfaces = {
    mullvad0 = {
      address = ["10.66.156.220/32" "fc00:bbbb:bbbb:bb01::3:9cdb/128"];
      dns = ["10.64.0.1"];
      privateKeyFile = "/etc/privatekey-mullvad";
      postUp = "ip rule add from 192.168.0.0/16 table main";
      peers = [
        {
          publicKey = "Qn1QaXYTJJSmJSMw18CGdnFiVM0/Gj/15OdkxbXCSG0=";
          allowedIPs = ["0.0.0.0/0" "::0/0"];
          endpoint = "193.138.218.220:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
