{
  config,
  pkgs,
  ...
}: {
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkfAlh+Lxpd3W67iHq8lNHN1i00mEVC+45Fse6T8sMH7afJx647BAAfaI/EHkU3+7DobKKH+8OK/vc3qfh0nypMCw34DJCXFLVaWbedQrXw9zbQlG9NWAFJSIQ8UFpmDPubh/dPWg+KD0tIrgtRhhda1mmIsPLO+KjFHVPP0C6XudtxEOpHOmJ54xfCWIv36ARdw+txxBlDnd0xcEG3UoOK0vmd84beKDk6k5iYrE3+WyEUNZQDTJQUORGBROElUh9ngBp2dgsQimGNoG13fD7quIIlV+O1WR/9h/iWfHtlAgdj4xRB+mjDTQvkhkF9Jj1OrHYi4I2SdcTp9sfSho/lLiEumksOXPPmr1NBGOF7Qlel7sEQUiiP9pbXW0gxtRyEuJUuNJhtlInwlfG1M45ERD2W+Jh10XIj7bIc+hj5Clo3aF/Wmc4oQ9iSFoeOR6C7Jjh9aGvNhtlbNwuF15v5mNeen6mkcqkBlufCSf9iMQ75oIi3HW51lNYztqSj3GaSinMVAsbZNptuMy6dCKr10t483BNnWWMVt7Hwl50e/nhHTa5QlPYWp76k0cJOq0Zmi8oXQbTkLx57zwOFqH2/HnjD/CTT64Rz/Ewt2AI/4SCL0Tzcs7zyp8NAytVHODSLpcnEgc5PJ0+ftQPbHjv3EZ+lJ7dOPEUw8o807cLdw== cardno:22 367 980"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjf = {
    isNormalUser = true;
    description = "mjf";
    extraGroups = ["networkmanager" "wheel" "margartv"];
    packages = with pkgs; [];
    uid = 1000;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkfAlh+Lxpd3W67iHq8lNHN1i00mEVC+45Fse6T8sMH7afJx647BAAfaI/EHkU3+7DobKKH+8OK/vc3qfh0nypMCw34DJCXFLVaWbedQrXw9zbQlG9NWAFJSIQ8UFpmDPubh/dPWg+KD0tIrgtRhhda1mmIsPLO+KjFHVPP0C6XudtxEOpHOmJ54xfCWIv36ARdw+txxBlDnd0xcEG3UoOK0vmd84beKDk6k5iYrE3+WyEUNZQDTJQUORGBROElUh9ngBp2dgsQimGNoG13fD7quIIlV+O1WR/9h/iWfHtlAgdj4xRB+mjDTQvkhkF9Jj1OrHYi4I2SdcTp9sfSho/lLiEumksOXPPmr1NBGOF7Qlel7sEQUiiP9pbXW0gxtRyEuJUuNJhtlInwlfG1M45ERD2W+Jh10XIj7bIc+hj5Clo3aF/Wmc4oQ9iSFoeOR6C7Jjh9aGvNhtlbNwuF15v5mNeen6mkcqkBlufCSf9iMQ75oIi3HW51lNYztqSj3GaSinMVAsbZNptuMy6dCKr10t483BNnWWMVt7Hwl50e/nhHTa5QlPYWp76k0cJOq0Zmi8oXQbTkLx57zwOFqH2/HnjD/CTT64Rz/Ewt2AI/4SCL0Tzcs7zyp8NAytVHODSLpcnEgc5PJ0+ftQPbHjv3EZ+lJ7dOPEUw8o807cLdw== cardno:22 367 980"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5jLPH1HgLqc4LF9sps4dZRHM76LKaDLAYi7/Wrow2m mfeller@squareup.com"
    ];
  };

  # User and Group for media mount and system services that need access to said
  # media.
  users.users.margartv = {
    isSystemUser = true;
    group = "margartv";
    uid = 1001;
  };

  # Groups
  users.groups.margartv = {gid = 1002;};
}
