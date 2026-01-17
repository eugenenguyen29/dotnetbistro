{
  description = "Hugo blog with Blowfish theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        name = "dotnetbistro";
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo # Hugo static site generator (extended version with SCSS support)
            git # For git submodules
            go # For Hugo modules
          ];

          shellHook = ''
            echo "Hugo blog development environment"
            echo "Hugo version: $(hugo version)"
            echo ""
            echo "Quick start:"
            echo "  hugo new site . --force    # Initialize Hugo in current directory"
            echo "  git init                   # Initialize git"
            echo "  git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish"
            echo "  hugo server -D             # Start dev server with drafts"
          '';
        };

        # Build the static site
        packages.default = pkgs.stdenv.mkDerivation {
          name = "blog";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            hugo
            git
            cacert
          ];

          buildPhase = ''
            hugo --minify
          '';

          installPhase = ''
            cp -r public $out
          '';
        };
      }
    );
}
