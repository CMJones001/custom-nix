{lib, buildPythonPackage, fetchPypi, fetchFromGitHub, boto3, future, numpy, pytest, setuptools, setuptools-scm, jdk, cython, pythonJavabridge}:

buildPythonPackage rec {
    # We note that the 4.1.0 version uses underscores!!
    pname = "python_bioformats";
    version = "4.1.0";

    src = fetchPypi{
      inherit pname version;
      sha256= "sha256-hTc/cKSotI/YdBTl6rCqlh57sHdyZF9eAJpvF0V8tOs=";
    };

    doCheck = true;
    propagatedBuildInputs = [boto3 future cython pythonJavabridge];
    checkInputs = [pytest];

    meta = with lib; {
      homepage = "https://github.com/CellProfiler/python-bioformats/";
      descriptions = ''python-bioformats'';
      license = lib.licenses.mit;
    };
}

