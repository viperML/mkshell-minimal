# mkshell-minimal

Minimal shell that doesn't include a C compiler or other utilites from stdenvNoCC.


# Usage

```nix
let
  pkgs = import <nixpkgs> {};
  mkShell = import (builtins.fetchTarball "https://github.com/viperML/mkshell-minimal/archive/refs/heads/master.tar.gz") pkgs;
in
  mkShell {
    packages = [
      pkgs.foo
      pkgs.bar
    ];
  }
```

## Flake

```nix
{
  inputs ={
    # ...
    mkshell-minimal.url = "github:viperML/mkshell-minimal";
  };

  outputs = { self, nixpkgs, mkshell-minimal, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    mkShell = mkshell-minimal pkgs;
  in {
    devShells.${system}.default = mkShell {
      packages = [
        pkgs.foo
        pkgs.bar
      ];
    };
  };
}
```

# Savings

```
$ nix build -f ./test.nix report && ./result
:: pkgs.mkShell
/nix/store/bki8iizd3qbk4d2jr1vjf825pcn8ixw2-nix-shell    320.6M
:: pkgs.mkShellNoCC
/nix/store/kvffp6al3jzwfhvmkm4c6pbvbrv0098r-nix-shell     66.1M
:: mkshell-minimal
/nix/store/i3v0jabdm95dwvynw7b73xllgxlwviz7-nix-shell     42.7M
```


## Read also

- https://fzakaria.com/2021/08/02/a-minimal-nix-shell.html
- https://discourse.nixos.org/t/minimal-nix-shell/14373
- https://discourse.nixos.org/t/smaller-stdenv-for-shells/28970