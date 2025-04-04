{
  description = "A collection of local files required for the ciona explorer.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";  
      currentSystem = system;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      python = pkgs.python3;

      # Attempt to call with pkgs then python pkgs then our defined packages
      callPackage = pkgs.lib.callPackageWith ( pkgs // python.pkgs // self.packages.${system} );
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

      # Define a function that simplifies the building of the development shells
      mkPythonDevShell = { extraLibs, shellHook ? "" }:
        pkgs.mkShell {
          buildInputs = [
            (python.buildEnv.override {
              extraLibs = basePythonLibs ++ extraLibs;
              ignoreCollisions = true;
            })
          ];
          inherit shellHook;
        };

      basePythonLibs = with python.pkgs; [
        numpy snakemake alive-progress
        scipy
      ];

      javaPythonLibs = with python.pkgs; [
        self.packages.${system}.pythonJavabridge
        self.packages.${system}.bioformats
      ];

      cudaPythonLibs = with python.pkgs; [
        self.packages.${system}.roifile
        self.packages.${system}.imagecodecs
        # self.packages.${system}.fastremap
        # self.packages.${system}.cellpose
      ];


    in with pkgs; 
    {
      packages.${system} = rec {
        grapheme = callPackage ./pkgs/grapheme { };
        snakemake = callPackage ./pkgs/snakemake { };
        pythonJavabridge = callPackage ./pkgs/python-javabridge { inherit cython; };
        bioformats = callPackage ./pkgs/python-bioformats { inherit cython; };
        roifile = callPackage ./pkgs/roifile { };
        imagecodecs = callPackage ./pkgs/imagecodecs { };
        # fastremap = callPackage ./pkgs/fastremap { inherit cython; };
        # cellpose = callPackage ./pkgs/cellpose {  };
      };

      devShells.${system} = {

        # The lightest version of the package, mostly used for annotation
        base = mkPythonDevShell {
          extraLibs = [self.packages.${system}.grapheme];
        };

        # Includes the java depenedencies for opening images
        default = mkPythonDevShell {
          extraLibs = javaPythonLibs;
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk}
            PATH="${pkgs.jdk}/bin:$PATH"
          '';
        };

        # The full package, including CUDA based tools for image segmentation
        full = mkPythonDevShell {
          extraLibs = javaPythonLibs ++ cudaPythonLibs ++ [self.packages.${system}.roifile];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk}
            PATH="${pkgs.jdk}/bin:$PATH"
          '';
        };

      };
    };
}
