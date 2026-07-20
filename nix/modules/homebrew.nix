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

      "emacs-plus@31"
      "m4"
      "autoconf"
      "gmp"
      "coreutils"
      "isl"
      "mpfr"
      "libmpc"
      "gcc"
      "gdk-pixbuf"
      "gnu-sed"
      "gnu-tar"
      "libidn"
      "libtasn"
      "nettle"
      "p11-kit"
      "gnutls"
      "grep"
      "jpeg"
      "libdatrie"
      "libgccjit"
      "libthai"
      "pango"
      "librsvg"
      "make"
      "pkgconf"
      "texinfo"
      "tree-sitter"
      "zlib"
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
      "vlc"
    ];
    masApps = {
      "Davinci Resolve" = 571213070;
      "WhatsApp" = 310633997;
      # "Proton Authenticator" = 6741758667; # for some reason this doesn't work!!!
    };
  };
}
