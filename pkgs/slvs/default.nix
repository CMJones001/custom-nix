{lib, buildPythonPackage, fetchPypi, scikit-build}:

buildPythonPackage rec {
  pname = "py_slvs";
  version = "1.0.4";

  src = fetchPypi {
    inherit pname version;
    sha256= "0gml3337sfxqdyk5g8v5aj69k18h4884xwkbqg42dwpcigliqbk4";
  };

  buildInputs = [scikit-build];
  meta = with lib; {
    homepage = "https://pypi.org/project/py-slvs/";
    descriptions = "Python Binding of SOLVESPACE Constraint Solver";
    license = lib.licenses.mit;
  };
}
