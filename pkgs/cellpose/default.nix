{ lib, buildPythonPackage, fetchPypi,
  numpy, scipy, natsort, tifffile, tqdm, numba, llvmlite,
  torch-bin, imagecodecs-lite, roifile, fastremap,
  pytest, setuptools, setuptools-scm
}:

buildPythonPackage rec {
  # Cellpose 3.0.0 >= has been buggy, so stick with ^2
  pname = "cellpose";
  version = "2.3.2";

  src = fetchPypi {
    inherit pname version;
    sha256= "sha256-jyepp7pkl6ElW4B7/pnHqNdNvCDAEIMFe8NsI2Ao+7U=
";
  };

  doCheck = true;
  propagatedBuildInputs = [
    numpy scipy natsort tifffile tqdm numba
    llvmlite torch-bin imagecodecs-lite roifile fastremap
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
