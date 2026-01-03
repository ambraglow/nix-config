{
  pkgs,
  inputs,
  user,
  ...
}:
{
  imports = [
    ./overlays.nix
  ];

  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";
  #nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 2d";
  };

  nixpkgs.config.allowUnfree = true;

  # home-manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      imports = [
        ../home
      ];
    };
    extraSpecialArgs = {
      inherit
        inputs
        user
        ;
    };
  };
}
