# mkshell-minimal

Minimal shell that doesn't include a C compiler or other utilites from stdenvNoCC.

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mkshell-minimal.url = "github:viperML/mkshell-minimal";
  };

  outputs = {nixpkgs, mkshell-minimal, ...}: let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {

    #                                             VVVV pass your pkgs as argument
    devShells.${system}.default = mkshell-minimal pkgs {
      packages = [
        pkgs.deno
        pkgs.hugo
      ];
    };

  };
}
```