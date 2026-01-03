{
  inputs,
  pkgs,
  user,
  ...
}:
let
  rustToolchain = pkgs.rust-bin.fromRustupToolchainFile (inputs.self + /toolchain.toml);
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default
    ../homebrew.nix
    ../overlays.nix
  ];

  nix.optimise.automatic = true;
  nix.optimise.interval = {
    Hour = 5;
    Minute = 0;
  };

  nix.settings = {
    trusted-users = [ "${user}" ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };

  nix-homebrew.user = user;
  nix-homebrew.enable = true;
  nix-homebrew.autoMigrate = true;

  environment = {
    systemPackages = [
      # pkgs.ragenix
      pkgs.nixd
      pkgs.nil
      pkgs.rust-bin.stable."1.90.0".default
    ];
    systemPath = [
      "/opt/homebrew/bin"
    ];
    pathsToLink = [ "/Applications" ];
    # makes rust-analyzer work on macOS
    variables = {
      RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
    };
  };

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
    uid = 501;
  };
}
