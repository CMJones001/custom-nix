{ lib, buildPythonPackage, fetchPypi,
  numpy, cython, pbr, libgcc, 
  pytest, setuptools, setuptools-scm, pytest-runner
}:

buildPythonPackage rec {
  # Cellpose 3.0.0 >= has been buggy, so stick with ^2
  pname = "fastremap";
  version = "1.15.0";

  src = fetchPypi {
    inherit pname version;
    sha256= "sha256-1uImgQPjYg0+70X8WSGkedHTd44/gPLjDD9c7pLRpH8=";
  };

  doCheck = true;
  propagatedBuildInputs = [
    numpy cython pbr 
  ];

  buildInputs = [
    libgcc
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  nativeCheckInputs = [
    pytest pytest-runner
  ];

  # pyproject = true;
}
