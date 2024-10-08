{ lib, buildPythonPackage, fetchPypi, pkgs, pytest }:

buildPythonPackage rec {
    pname = "about-time";
    version = "3.1.1";

    ignoreCollisions = true;
    src = fetchPypi{
      inherit pname version;
      sha256= "16wzrvazy8h3n1xin3wda1a7midlyns2sbf4x0d7sf69a2a34ssq";
    };
    checkInputs = [pytest];

    meta = with lib; {
      homepage = "https://github.com/rsalmei/about-time";
      descriptions = "Easily measure timing and throughput of code blocks, with beautiful human friendly representations.";
      license = lib.licenses.mit;
    };
}
