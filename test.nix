let
  pkgs = import <nixpkgs> {};
  mkShell = import ./default.nix pkgs;
in rec {
  regular = (pkgs.mkShell {}).inputDerivation;
  noCC = (pkgs.mkShellNoCC {}).inputDerivation;
  minimal = (mkShell {}).inputDerivation;

  report = pkgs.writeShellScript "report" ''
    echo ":: pkgs.mkShell"
    nix path-info -Sh ${regular}

    echo ":: pkgs.mkShellNoCC"
    nix path-info -Sh ${noCC}

    echo ":: mkshell-minimal"
    nix path-info -Sh ${minimal}
  '';
}