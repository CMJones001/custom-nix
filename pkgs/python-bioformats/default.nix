{lib, buildPythonPackage, fetchPypi, boto3, future, numpy, pytest, nose, pythonJavabridge}:

buildPythonPackage rec {
    pname = "python-bioformats";
    version = "4.0.5";

    src = fetchPypi{
      inherit pname version;
      sha256= "14jipcyq71fa3z1c8kkr3yddx7sf8h9wbxnzf1haq7hg7hmkmypr";
    };

    # checkInputs = [pkgs.pytest pkgs.nose];
    doCheck = true;
    propagatedBuildInputs = [boto3 future pythonJavabridge];
    buildInputs = [numpy];
    checkInputs = [pytest nose];

    meta = with lib; {
      homepage = "https://github.com/CellProfiler/python-bioformats/";
      descriptions = ''python-bioformats'';
      license = lib.licenses.mit;
    };
}

