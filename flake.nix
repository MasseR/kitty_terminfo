{
  description = "Terminfo split out of kitty";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlay = final: prev: {
        kitty_terminfo = final.callPackage ./kitty_terminfo {};
      };
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; overlays = [ self.overlay ]; };
    in
    {
      packages.kitty_terminfo = pkgs.kitty_terminfo;
      defaultPackage = pkgs.kitty_terminfo;
    });
}
