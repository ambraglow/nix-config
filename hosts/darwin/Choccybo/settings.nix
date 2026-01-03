{
  inputs,
  pkgs,
  user,
  ...
}:
{
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    defaults.dock = {
      autohide = true;
      magnification = true;
      largesize = 70;
      tilesize = 50;

      persistent-apps = [
        "/Users/${user}/Applications/Home Manager Apps/Discord.app"
        "/Applications/Microsoft Edge.app"
        "/Applications/Zed.app"
        "/Users/${user}/Applications/Home Manager Apps/Warp.app"
        "/System/Applications/Music.app"
      ];
    };

    defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 2.5; # maxxed out :speaking_head:
    defaults.trackpad.ActuateDetents = true;
    defaults.trackpad.TrackpadThreeFingerDrag = false; # default is false
    defaults.trackpad.TrackpadThreeFingerHorizSwipeGesture = 2;
    defaults.universalaccess.reduceTransparency = false;
    defaults.loginwindow.LoginwindowText = "meow for password";

    defaults.finder = {
      # "icnv" = Icon view, "Nlsv" = List view, "clmv" = Column View, "Flwv" = Gallery View The default is icnv.
      FXPreferredViewStyle = "Nlsv"; # list-view

      # Use "SCcf" to default to current folder. The default is unset ("This Mac").
      FXDefaultSearchScope = "SCcf"; # default scope is current folder

      ShowMountedServersOnDesktop = true; # show mounted servers on desktop
      AppleShowAllFiles = true; # hidden files
      AppleShowAllExtensions = true; # file extensions
      _FXShowPosixPathInTitle = true; # title bar full path
      ShowPathbar = true; # breadcrumb nav at bottom
      ShowStatusBar = true; # file count & disk space
    };
  };
}
