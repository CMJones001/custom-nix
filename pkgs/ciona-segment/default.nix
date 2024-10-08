{lib, buildPythonPackage, nix-gitignore,
  ciona_tools, strictyaml, pymeshlab, pandas
} :

buildPythonPackage rec {
  pname = "ciona-segment";
  version = "0.2";

  src = nix-gitignore.gitignoreSource [] /home/carl/Documents/post-doc/projects/ciona-segment;
  format = "setuptools";
  doCheck = false;

  propagatedBuildInputs = [
    ciona_tools strictyaml pymeshlab pandas
  ];

  meta = with lib; {
    descriptions = ''Segmentation of ciona images.'';
    license = lib.licenses.mit;
  };
}


