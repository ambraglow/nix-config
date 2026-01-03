{ inputs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
    ../overlays.nix
    ./hardware_configuration.nix
    ./desktop.nix
    ./network.nix
  ];
}
