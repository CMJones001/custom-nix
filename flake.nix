{
  description = "A collection of local files required for the ciona explorer.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";  
      currentSystem = system;
      pkgs = import nixpkgs { inherit system; };
      python = pkgs.python3;

      # Attempt to call with pkgs then python pkgs then our defined packages
      callPackage = pkgs.lib.callPackageWith (pkgs // python.pkgs // self);
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

      alive-progress = python.pkgs.alive-progress.overrideAttrs (oldAttrs: rec {
        ignoreCollisions = true;
        postBuild = ''
          rm LICENSE
        '';
      });
    in with pkgs; 
    {
      packages.${system} = rec {
        grapheme = callPackage ./pkgs/grapheme { };
        snakemake = callPackage ./pkgs/snakemake { };
        pythonJavabridge = callPackage ./pkgs/python-javabridge { inherit cython; };
        bioformats = callPackage ./pkgs/python-bioformats { inherit cython pythonJavabridge; };
      };

      devShells.${system}.default = pkgs.mkShell {
          buildInputs = [
            (python.buildEnv.override {
              extraLibs = with python.pkgs; [
                grapheme numpy snakemake
                self.packages.${system}.pythonJavabridge
                self.packages.${system}.bioformats
                alive-progress
              ];
              ignoreCollisions = true;
            })
            # (python.withPackages ( ps: with ps; [
            #   grapheme
            #   numpy 
            #   snakemake
            #   self.packages.${system}.pythonJavabridge
            #   self.packages.${system}.bioformats
            #   alive-progress
            # ]))
          ];
          shellHook = ''
            export JAVA_HOME=${pkgs.jdk}
            PATH="${pkgs.jdk}/bin:$PATH"
          '';
        };
    };
}
