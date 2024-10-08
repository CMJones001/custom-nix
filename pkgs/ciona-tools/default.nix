{lib, buildPythonPackage, nix-gitignore, numpy, pandas, cmcrameri,
  aliveProgress, matplotlib_scalebar, bioformats, 
  argh, more-itertools, beautifulsoup4, lxml, 
  scikitimage, xmltodict, h5py, pydantic, questionary, tables, seaborn, tifffile
} : 

buildPythonPackage {
  pname = "ciona_tools";
  version = "0.1";
  ignoreCollisions = true;

  src = nix-gitignore.gitignoreSource [] /home/carl/Documents/post-doc/projects/ciona_tools;

  doCheck = false;
  propagatedBuildInputs = [
    numpy pandas matplotlib_scalebar
    bioformats aliveProgress cmcrameri
    argh more-itertools
    beautifulsoup4 lxml
    scikitimage xmltodict
    h5py pydantic questionary tables
    seaborn
    tifffile
  ];

  meta = with lib; {
    descriptions = ''tools for working with our ciona images.'';
    license = lib.licenses.mit;
  };
}
