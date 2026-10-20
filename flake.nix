{
  description = "Cached Zed editor builds";

  inputs = {
    zed.url = "github:MostlyKIGuess/zed/latex-math-on-main";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, zed, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        default = zed.packages.${system}.default;
        zed-editor = zed.packages.${system}.default;
      };
    });
}
