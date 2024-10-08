{ lib, buildPythonPackage, fetchPypi, matplotlib, pytest}:

buildPythonPackage rec {
    pname = "matplotlib-scalebar";
    version = "0.7.2";

    src = fetchPypi{
      inherit pname version;
      sha256= "1l0lpfgmjbc1a84v0vjqcmdb8sxmp11dkrgz3jygg7if9r2bdkrn";
    };

    propagatedBuildInputs = [matplotlib];
    checkInputs = [pytest];

    meta = with lib; {
      homepage = "https://github.com/ppinard/matplotlib-scalebar";
      descriptions = "Provides a new artist for matplotlib to display a scale bar, aka micron bar.";
    };

}
