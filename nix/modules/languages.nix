{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    rustup
    typst
    python3
    uv
    basedpyright
    nil
    clang
    lua-language-server
  ];
}
