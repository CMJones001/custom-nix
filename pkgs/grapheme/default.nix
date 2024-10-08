{ lib, buildPythonPackage, fetchPypi, pytest}:

buildPythonPackage rec {
    pname = "grapheme";
    version = "0.6.0";

    src = fetchPypi{
      inherit pname version;
      sha256= "1jiwc3w05c8kh22s3zk7a8km8na3plqc5zimb2qcyxxy3grbkhj4";
    };

    checkInputs = [pytest];

    meta = with lib; {
      homepage = "https://github.com/alvinlindstam/grapheme";
      descriptions = "A Python package for working with user perceived characters. More specifically, string manipulation and calculation functions for working with grapheme cluster groups (graphemes) as defined by the Unicode Standard Annex #29.";
    };
}
