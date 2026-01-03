{
  pkgs,
  user,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./condiments/zed.nix
    ./settings.nix
    ./hardware_configuration.nix
  ];
  networking.hostName = "Choccybo";
  # launchd.daemons.nix-daemon.environment.SSH_AUTH_SOCK = "/Users/${user}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";

  age.secrets.password.file = (inputs.self + /secrets/password.age);
  age.identityPaths = [ "/Users/${user}/.ssh/id_ed25519" ];

  # programs._1password.enable = true;
  # programs._1password-gui = {
  #   enable = true;
  # };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      oh-my-zsh
      zsh
      zed-discord-presence
      # zed-editor
      discord
      sdrpp
      # microsoft-edge
      warp-terminal
      keka
      obsidian
      imhex
    ];

    # shelter inject
    home.activation.updateDiscord = ''
      ${pkgs.bash}/bin/bash ${./condiments/discord.sh}
    '';

    programs.git = {
      enable = true;

      settings = {
        user.name = "ambraglow";
        user.email = "ambra@ambraglow.org";

        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDaLWuiUBTpm/kqfZhZQwRTnUQ+t9LuHDP596uyIMlR";
        gpg.format = "ssh";
        gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        commit.gpgsign = true;
      };
    };

    programs.zsh.enable = true;
    programs.zsh.oh-my-zsh = {
      enable = true;
      plugins = [ "gh" ];
      theme = "gozilla";
    };
  };

}
