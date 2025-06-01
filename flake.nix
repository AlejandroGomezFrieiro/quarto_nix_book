{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    # pyproject-nix = {
    #         url = "github:pyproject-nix/pyproject.nix";
    #         inputs.nixpkgs.follows = "nixpkgs";
    #     };
    #
    # uv2nix = {
    #     url = "github:pyproject-nix/uv2nix";
    #     inputs.pyproject-nix.follows = "pyproject-nix";
    #     inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # pyproject-build-systems = {
    #     url = "github:pyproject-nix/build-system-pkgs";
    #     inputs.pyproject-nix.follows = "pyproject-nix";
    #     inputs.uv2nix.follows = "uv2nix";
    #     inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        devenv-test = self.devShells.${system}.default.config.test;
      });

      templates = {
        quarto = {
          path = ./.;
          description = "A simple quarto + uv python template.";

        };
      };
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            tex = (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-small amsmath framed fvextra environ fontawesome5 orcidlink pdfcol tcolorbox tikzfill;
      });
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # We need texliveMedium so that we have a minimal
                  # version of latex + xelatex for compilation.
                  # For using numpy, libz is necessary. Could have been added
                  # In a normal nix fashion, but uv is more general to use.
                  packages = [ pkgs.quarto tex pkgs.libz pkgs.jupyter];

                  languages.python = {
                    enable = true;
                    uv.enable = true;
                    venv.enable = true;

                  };
                  
                  # Set so quarto recognizes we are using the nix-generated venv.
                  # It might generate warnings, but it works as expected.
                  env.QUARTO_PYTHON = "python3"; 

                }
              ];
            };
          });
    };
}
