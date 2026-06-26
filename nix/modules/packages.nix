{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    wget
    stow
    neovim
    ripgrep
    rustup
    tmux
    tealdeer
    fd
    zoxide
    yazi
    newsboat
    bat
    lazygit
    eza
    starship
    timewarrior
    typst
    python3
    uv
    delta
    yt-dlp
    nodejs
    mpv
    poppler
    p7zip
    resvg
    imagemagick
    pastel
    cmake
    asciiquarium
    fortune
    cowsay
    lolcat
    skim
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
  ];
}
