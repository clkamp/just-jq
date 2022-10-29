{
  description = "A flake for tools for just build";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        defaultPackage = pkgs.callPackage ./just-jq.nix {};
      }
    );
}
