{
  description = "Terminfo split out of kitty";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
  rec {
    packages.kitty_terminfo = nixpkgs.legacyPackages.${system}.callPackage ./kitty_terminfo {};
    defaultPackage = packages.kitty_terminfo;
  });
}
