{ lib, buildPythonPackage, fetchPypi, grapheme, aboutTime  }:

buildPythonPackage rec {
    pname = "alive-progress";
    version = "1.6.2";

    ignoreCollisions = true;
    src = fetchPypi{
      inherit pname version;
      sha256= "0gml3337sfxqdyk5g8v5aj69k18h4884xwkbqg42dwpcigliqbk4";
    };

    propagatedBuildInputs = [grapheme aboutTime];
    doCheck = false;

    meta = with lib; {
      homepage = "https://github.com/rsalmei/alive-progress";
      descriptions = "Provides a new artist for matplotlib to display a scale bar, aka micron bar.";
      license = lib.licenses.mit;
    };
}
