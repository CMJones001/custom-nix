{
  description = "A collection of local files required for the ciona explorer.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      makeCmjPackages = { pkgs, python, system }: rec {
        # python = pkgs.python311;

        # Attempt to call with pkgs then python pkgs then our defined packages
        callPackage = pkgs.lib.callPackageWith ( pkgs // python.pkgs // packages );
        buildPythonPackage = python.pkgs.buildPythonPackage;

        # Javabridge requires cython < 0.3
        cython = python.pkgs.cython.overrideAttrs (oldAttrs: rec {
            version = "0.29.37";
            src = pkgs.fetchPypi {
            pname = "Cython";
            inherit version;
            sha256= "sha256-+BPUpt2Ure5dT/JmGR0dlb9tQWSk+sxTVCLAIbJQTPs="; 
            };
        });

        packages = {
          grapheme = callPackage ./pkgs/grapheme { };
          snakemake = callPackage ./pkgs/snakemake { };
          pythonJavabridge = callPackage ./pkgs/python-javabridge { inherit cython; };
          bioformats = callPackage ./pkgs/python-bioformats { inherit cython; };
          roifile = callPackage ./pkgs/roifile { };
          imagecodecs = callPackage ./pkgs/imagecodecs { };
        };
      };

      system = "x86_64-linux";  
    in 
    {
      # Export the function under `lib`
      lib.${system} = {
        mkPackages = makeCmjPackages;
      };

      packages.${system} = 
        let
          pkgs = nixpkgs.legacyPackages.${system};
          python = pkgs.python311;
          cmjPackages = makeCmjPackages {inherit pkgs python system; };
        in
          cmjPackages.packages;

      devShells.${system} = 
        let 
            pkgs = nixpkgs.legacyPackages.${system};
            python = pkgs.python311;
            cmjPkgs = (makeCmjPackages {inherit pkgs python system; }).packages;
        in 
          {
            # Includes the java depenedencies for opening images
            default = pkgs.mkShell {
              buildInputs = [
                (python.withPackages (python-pkgs: with python-pkgs; [
                  seaborn
                ] ++ (with cmjPkgs; [bioformats roifile])))
              ];
              shellHook = ''
                export JAVA_HOME=${pkgs.jdk}
                PATH="${pkgs.jdk}/bin:$PATH"
            '';
            };
          };
    };
}
