{ ... }: {
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
      "mpv"
    ];
    casks = [
      "vesktop"
      "sioyek"
      "obs"
      "ghostty"
      "aerospace"
      "figma"
      "raycast"
      "helium-browser"
      "emacs-plus-app"
      "vlc"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
      # "Proton Authenticator" = 6741758667; # for some reason this doesn't work!!!
    };
  };
}
