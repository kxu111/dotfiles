{...}: {
  homebrew = {
    enable = true;
    global.autoUpdate = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = ["mas"];
    casks = [
      "vesktop"
      "sioyek"
      "obs"
      "ghostty"
      "karabiner-elements"
      "aerospace"
      "anki"
      "figma"
      "adobe-creative-cloud"
      "raycast"
      "helium-browser"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
    };
  };
}
