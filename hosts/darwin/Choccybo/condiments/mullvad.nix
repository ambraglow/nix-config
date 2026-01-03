{
  stdenv,
  lib,
  pkgs,
}:
let
  platform = "darwin";

  versions = {
    darwin = "2025.14";
  };

  hashes = {
    darwin = "sha256-zyhWKaxJ/cGalhrNwKisfI7xMH45s2FHb7ob6sLJx1Q=";
  };

  appName = "Mullvad\ VPN.app";
in
stdenv.mkDerivation {
  pname = "mullvad-vpn";
  version = versions.darwin;

  src = pkgs.fetchurl {
    url = "https://github.com/mullvad/mullvadvpn-app/releases/download/${versions.darwin}/MullvadVPN-${versions.darwin}.pkg";
    hash = hashes.darwin;
  };

  nativeBuildInputs = [
    pkgs.xar
    pkgs.cpio
    pkgs.gzip
  ];

  #MullvadVPN-${versions.darwin}.pkg/

  unpackPhase = ''
    xar -xf $src
    zcat < net.mullvad.vpn.pkg/Payload | cpio -i
  '';

  # sourceRoot = "Mullvad VPN.app";
  dontUnpack = false;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  preInstall = ''
    ./mullvad-preinstall.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R *.app $out/Applications
    runHook postInstall
  '';
}
