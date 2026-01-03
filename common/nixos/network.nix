{
  config,
  inputs,
  lib,
  ...
}:
{
  networking.networkmanager.enable = true;

  # mdns
  services.avahi.enable = lib.mkDefault false;
  services.resolved.enable = true;

  # ssh
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # wifi
  age.secrets.wifi-home.file = (inputs.self + /secrets/network_home.age);
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.wifi-home.path
    ];

    profiles = {
      Home = {
        connection = {
          id = "$HOME_SSID";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$HOME_SSID";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$HOME_PSK";
        };
      };
    };
  };
}
