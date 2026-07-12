{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    htop
    fastfetch
    wget
    stow
    neovim
    ripgrep
    tmux
    fd
    zoxide
    newsboat
    timewarrior
    yt-dlp
    nodejs
    fzf
    yazi
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
  ];
}
