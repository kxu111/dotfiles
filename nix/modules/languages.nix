{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    rustup
    typst
    nil
    clang
    lua-language-server

    python3
    uv
    basedpyright
  ];
  homebrew.brews = [
    "ghcup"
  ];
}
