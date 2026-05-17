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
      "steam"
      "helium-browser"
      "sioyek"
      "obs"
      "ghostty"
      "desktoppr"
      "karabiner-elements"
      "aerospace"
      "anki"
      "figma"
      "adobe-creative-cloud"
      "alfred"
      "firefox"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
      "Slack" = 803453959;
    };
  };
}
