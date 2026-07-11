{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    htop
    fastfetch
    wget
    stow
    neovim
    ripgrep
    rustup
    tmux
    fd
    zoxide
    newsboat
    timewarrior
    typst
    python3
    uv
    yt-dlp
    nodejs
    fzf
    yazi
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
  ];
}
