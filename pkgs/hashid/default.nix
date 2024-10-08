{ lib, buildPythonPackage, pythonPkgs } :

buildPythonPackage rec {
    pname = "matplotlib-scalebar";
    version = "0.7.2";

    src = pythonPkgs.fetchPypi{
      inherit pname version;
      sha256= "1l0lpfgmjbc1a84v0vjqcmdb8sxmp11dkrgz3jygg7if9r2bdkrn";
    };

  checkInputs = [pythonPkgs.pytest];
  propagatedBuildInputs = [pythonPkgs.matplotlib];

  meta = with lib; {
    homepage = "https://pypi.org/project/hashID/";
    description = "Identify the different types of hashes used to encrypt data and especially passwords.";
  };
}
