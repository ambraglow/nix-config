{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      vim
      rtl_433
      volk
      sdrpp
      ripgrep
      cargo
      rustc
      gcc-arm-embedded
      rtl-sdr
      fftw
      glfw
      airspy
      airspyhf
      portaudio
      hackrf
      codec2
      zstd
      pkg-config
      git
      cmake
      llvmPackages_latest.llvm
    ];
  };
}
