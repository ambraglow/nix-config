{ ... }:
{
  homebrew = {
    enable = true ;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };
    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # and then i can add stuff here with:
    casks = [];
    brews = [
      "librtlsdr" # fuck my chud radio-obsessed life
    ];
    taps = [];
  };
}
