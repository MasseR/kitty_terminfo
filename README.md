Nix flake for building just the terminfo for kitty without all the opengl/x machinery

``` console
$ nix-store -qR result
/nix/store/m0l914gcs4245xa98r3962xm1gb7ry60-kitty-terminfo
```

This can be used in your nixos configuration flake with something like this:

``` nix
{
  inputs.kitty_terminfo = {
    url = "github:MasseR/kitty_terminfo";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  description = "My NixOS system";
  
  outputs = { self, nixpkgs, ... } @ inputs {
    overlays = [
      inputs.kitty_terminfo.overlay;
    ];
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          system.configurationRevision = nixpkgs.lib.mkIf (sef ? rev) self.rev;
          overlays = self.overlays;
          environment.systemPackages = [
            kitty_terminfo
          ];
        })
      ];
    };
  };
}
```
