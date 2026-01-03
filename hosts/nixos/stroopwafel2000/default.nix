{
  pkgs,
  user,
  inputs,
  config,
  ...
}:
{
  imports = [ ./settings.nix ./hardware_configuration.nix ];

  networking.hostName = "stroopwafel2000";

  age.secrets.password.file = (inputs.self + /secrets/password.age);
  age.identityPaths = [ "/home/${user}/.ssh/id_ed25519"  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPasswordFile = config.age.secrets.password.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDaLWuiUBTpm/kqfZhZQwRTnUQ+t9LuHDP596uyIMlR"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false; # change to false when adding ssh keys
    };
    openFirewall = true;
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${user} = {
    # home.file.".ssh/authorized_keys".text = ''
    #   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDaLWuiUBTpm/kqfZhZQwRTnUQ+t9LuHDP596uyIMlR
    # '';

    home.packages = with pkgs; [
      oh-my-zsh
      zsh
      vim
      tree
      git
    ];

    programs.zsh.enable = true;
    programs.zsh.oh-my-zsh = {
      enable = true;
      plugins = [ "gh" ];
      theme = "gozilla";
    };
  };

  system.stateVersion = "25.11";
}
