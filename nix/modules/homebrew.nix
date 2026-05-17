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
      "node"
      "mole"
      "pkgconfig"
      "raylib"
      "yt-dlp"
      "uv"
      "mpv"
      "starship"
      "git-delta"
      "timewarrior"
      "typst"
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
      "raycast"
      "figma"
      "adobe-creative-cloud"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
    };
  };
}
