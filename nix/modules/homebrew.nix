{...}: {
  homebrew = {
    enable = true;
    global.autoUpdate = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "mas"
      "mole"
      "pkgconfig"
      "raylib"
    ];
    casks = [
      "vesktop"
      "sioyek"
      "obs"
      "ghostty"
      "aerospace"
      "anki"
      "figma"
      "raycast"
      "firefox"
      "emacs-plus-app"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
      # "Proton Authenticator" = 6741758667; # for some reason this doesn't work!!!
    };
  };
}
