{lib, buildPythonPackage, fetchPypi, matplotlib, numpy, pytest}:

buildPythonPackage rec {
  pname = "cmcrameri";
  version = "1.4";

  src = fetchPypi {
    inherit pname version;
    sha256= "613158db1782754409c073c1b97fa299462ce2cb26c8533e3273b360fd809945";
  };

  propagatedBuildInputs = [matplotlib numpy];
  checkInputs = [pytest];

  meta = with lib; {
    homepage = "https://github.com/callumrollo/cmcrameri";
    descriptions = "This is a Python wrapper around Fabio Crameri's perceptually uniform colormaps.";
  };
}
