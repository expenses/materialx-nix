{
  description = "MaterialX";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, pkgs, system, ... }: {
        packages = {
          default = pkgs.callPackage ./package.nix { };
          viewer = pkgs.callPackage ./package.nix { build_viewer = true; };
        };
      };
      flake = { };
    };
}
