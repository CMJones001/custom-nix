{ lib, buildPythonPackage, fetchPypi,
  numpy, tifffile,
  pytest, setuptools, setuptools-scm
}:

buildPythonPackage rec {
  # Cellpose 3.0.0 >= has been buggy, so stick with ^2
  pname = "roifile";
  version = "2024.9.15";

  src = fetchPypi {
    inherit pname version;
    sha256= "sha256-Wk5pJb7BXB2eKAVgEXbuq8C+gI9abne2K7Z3dhFvjzw=";
  };

  doCheck = true;
  propagatedBuildInputs = [
    numpy tifffile
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  nativeCheckInputs = [
    pytest
  ];

  pyproject = true;
}
