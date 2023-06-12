# mkshell-minimal

Minimal shell that doesn't include a C compiler or other utilites from stdenvNoCC.


## Size comparison

mkshell-minimal:
```
$ nix path-info -Sh $(nix build --print-out-paths --impure --expr '(builtins.getFlake "github:viperML/mkshell-minimal" (import <nixpkgs> {}) {}).inputDerivation')
/nix/store/r4l3h4502gfqr9fbjlggdqxc6n56gix3-nix-shell      6.5M
```

mkShellNoCC:
```
$ nix path-info -Sh $(nix build --print-out-paths --impure --expr '((import <nixpkgs> {}).mkShellNoCC {name="nocc";}).inputDerivation')
/nix/store/l1b8vk1jp53jbcl9bpx53278d2s7j0ry-nocc          64.4M
```

mkShell:
```
$ nix path-info -Sh $(nix build --print-out-paths --impure --expr '((import <nixpkgs> {}).mkShell {name="stdenv";}).inputDerivation')
/nix/store/z05dy3wka9za1kwl5yz5zdiz5ngnsziq-stdenv       316.9M
```

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
        # Add your packages
        pkgs.deno
        pkgs.hugo
      ];
    };

  };
}
```

## Read also

- https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
- https://discourse.nixos.org/t/minimal-nix-shell/14373
- https://discourse.nixos.org/t/smaller-stdenv-for-shells/28970