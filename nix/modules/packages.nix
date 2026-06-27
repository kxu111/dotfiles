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
    timewarrior
    typst
    python3
    uv
    delta
    yt-dlp
    nodejs
    mpv
    imagemagick
    cmake
    fzf
    starship
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
  ];
}
