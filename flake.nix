{
  description = "MacOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    
    # nix-darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Add home-manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # not sure if i want to use this, nix-homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # agenix-nix-nix-nix..
    agenix.url = "github:yaxitech/ragenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-unstable.url = "github:YaLTeR/niri";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.niri-unstable.follows = "niri-unstable";
    };

    # myfonts.url = "git+ssh://git@github.com/ambraglow/fonts";
    # myfonts.flake = false;
  };

  outputs =
    inputs:
    let
      user = "ambra";
      inherit (inputs.nixpkgs) lib;

      mkHost =
        system: hostname:
        let
          builder =
            if system == "darwin" then inputs.nix-darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
          config = builder {
            specialArgs = { inherit inputs user; };
            modules = [
              ./hosts/${system}/${hostname}
              ./common
              ./common/${system}
              { config._module.args = { inherit hostname; }; }
              # inputs.home-manager.nixosModules.home-manager
              # {
              #   home-manager.extraSpecialArgs = { inherit inputs user; };
              #   home-manager.useGlobalPkgs = true;
              #   home-manager.useUserPackages = true;
              # }
            ];
          };
          key = "${system}Configurations";
        in
        {
          ${key} = {
            ${hostname} = config;
          };
        };

      systems = builtins.attrNames (builtins.readDir ./hosts);
      hosts = builtins.concatMap (
        system:
        let
          hostnames = builtins.attrNames (builtins.readDir ./hosts/${system});
        in
        map (hostname: mkHost system hostname) hostnames
      ) systems;
    in
    builtins.foldl' lib.recursiveUpdate { } hosts;
}
