{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    btop
    stow
    neovim
    ripgrep
    rustup
    tmux
    tree
    tealdeer
    unzip
    fzf
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];
}
