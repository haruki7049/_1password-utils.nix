{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = { self, nixpkgs, flake-utils, treefmt-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        _1password-utils = pkgs.callPackage ./_1password-utils.nix { };
      in
      {
        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            _1password
            nixd
          ];

          shellHook = ''
            export PS1="\n[nix-shell:\w]$ "
          '';
        };
      }
    );
}
