{
  config,
  pkgs,
  ...
}: {
  networking.wg-quick.interfaces = {
    mullvad0 = {
      address = ["10.68.134.9/32" "fc00:bbbb:bbbb:bb01::5:8608/128"];
      dns = ["10.64.0.1"];
      privateKeyFile = "/etc/privatekey-mullvad";
      postUp = "ip rule add from 192.168.0.0/16 table main";
      peers = [
        {
          publicKey = "74U+9EQrMwVOafgXuSp8eaKG0+p4zjSsDe3J7+ojhx0=";
          allowedIPs = ["0.0.0.0/0" "::0/0"];
          endpoint = "37.19.210.1:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
