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
    yt-dlp
    nodejs
    mpv
    pastel
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];
}
