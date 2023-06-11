{
  outputs = {self}: {
    __functor = self: self.mkShellFor;

    mkShellFor = pkgs:
      pkgs.mkShell.override {
        stdenv = pkgs.stdenvNoCC.override {
          cc = null;
          preHook = "";
          allowedRequisites = null;
          initialPath = [pkgs.pkgsCross.musl64.busybox];
          shell = "${pkgs.pkgsCross.musl64.bash}/bin/bash";
          extraNativeBuildInputs = [];
        };
      };
  };
}
