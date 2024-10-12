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

      # Javabridge requires cython3
      cython = python.pkgs.cython.overrideAttrs (oldAttrs: rec {
        version = "0.29.37";
        src = pkgs.fetchPypi {
          pname = "Cython";
          inherit version;
          sha256= "sha256-+BPUpt2Ure5dT/JmGR0dlb9tQWSk+sxTVCLAIbJQTPs="; 
        };
      });

      basePythonLibs = with python.pkgs; [
        numpy snakemake alive-progress
        scipy
      ];

      javaPythonLibs = with python.pkgs; [
        self.packages.${system}.pythonJavabridge
        self.packages.${system}.bioformats
      ];

      cudaPythonLibs = with python.pkgs; [
        torch-bin

        # Cellpose Packages
        opencv4
        numba
        tqdm
        llvmlite
        natsort
        imagecodecs-lite
      ];


    in with pkgs; 
    {
      packages.${system} = rec {
        grapheme = callPackage ./pkgs/grapheme { };
        snakemake = callPackage ./pkgs/snakemake { };
        pythonJavabridge = callPackage ./pkgs/python-javabridge { inherit cython; };
        bioformats = callPackage ./pkgs/python-bioformats { inherit cython; };
      };


      devShells.${system} = {

        base = pkgs.mkShell {
          buildInputs = [
            (python.buildEnv.override {
              extraLibs = basePythonLibs;
              ignoreCollisions = true;
            })
          ];
        };

        default = pkgs.mkShell {
          buildInputs = [
            (python.buildEnv.override {
              extraLibs = with python.pkgs; [
                grapheme 
              ] ++ basePythonLibs ++ javaPythonLibs;
              ignoreCollisions = true;
            })
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk}
            PATH="${pkgs.jdk}/bin:$PATH"
          '';
        };

        full = pkgs.mkShell {
          buildInputs = [
            (python.buildEnv.override {
              extraLibs = with python.pkgs; [
                grapheme 
              ] ++ basePythonLibs ++ javaPythonLibs ++ cudaPythonLibs;
              ignoreCollisions = true;
            })
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk}
            PATH="${pkgs.jdk}/bin:$PATH"
          '';
        };

      };
    };
}
