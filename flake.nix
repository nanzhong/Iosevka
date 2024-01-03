{
  description = "Iosevka";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }@inputs: let
    forEachSystem = fn:
      nixpkgs.lib.genAttrs [
        "x86_64-linux" "aarch64-linux"
        "x86_64-darwin" "aarch64-darwin"
      ] (system: fn (import nixpkgs {
        inherit system;
      }));
  in {
    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs_20
          ttfautohint-nox
        ];
      };
    });
  };
}
