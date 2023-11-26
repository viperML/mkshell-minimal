pkgs: let
  inherit (pkgs) lib;
in
  pkgs.mkShell.override {
    stdenv = pkgs.stdenvNoCC.override {
      cc = null;
      preHook = "";
      allowedRequisites = null;
      initialPath = [pkgs.coreutils];
      shell = lib.getExe pkgs.bash;
      extraNativeBuildInputs = [];
    };
  }
