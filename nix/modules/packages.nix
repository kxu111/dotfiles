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
    fd
    zoxide
    newsboat
    timewarrior
    typst
    python3
    uv
    yt-dlp
    nodejs
    mpv
    fzf
    yazi
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
    aporetic-bin
  ];
}
