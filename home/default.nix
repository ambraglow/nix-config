{ user, ... }:
{
  imports = [
    ./packages.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = user;
    stateVersion = "25.11";
  };
}
