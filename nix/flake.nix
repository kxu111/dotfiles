{
  description = "kenny nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    aerospace = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    emacs = {
      url = "github:d12frosted/homebrew-emacs-plus";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    aerospace,
    emacs,
    ...
  }: {
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self;
      };
      modules = [
        ./modules/packages.nix
        ./modules/homebrew.nix
        ./modules/settings.nix
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "kenny";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "nikitabobko/homebrew-tap" = aerospace;
              "d12frosted/homebrew-emacs-plus" = emacs;
            };

            mutableTaps = false;

            trust = {
              taps = [
                "nikitabobko/homebrew-tap"
                "d12frosted/homebrew-emacs-plus"
              ];
            };
          };
        }
        ({config, ...}: {
          homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
        })
      ];
    };
  };
}
