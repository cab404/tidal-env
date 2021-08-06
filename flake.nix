{
  outputs = { self, nixpkgs }: let system = "x86_64-linux"; in {
    devShell.${system} = with import nixpkgs { inherit system; }; mkShell {
      buildInputs = [
        supercollider
        (haskellPackages.ghcWithPackages (a: [a.tidal]))
        (writeScriptBin "superdirt" ''
          sclang superdirt.scd
        '')
        (writeScriptBin "tidal" ''
          ghci -ghci-script BootTidal.hs
        '')
      ];
    };
  };
}
