{ pkgs, lib, config, ... }:
{
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  programs.niri.enable = true;
}
