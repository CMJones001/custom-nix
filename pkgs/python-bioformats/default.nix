{lib, buildPythonPackage, fetchPypi, fetchFromGitHub, boto3, future, numpy, pytest, nose, setuptools, setuptools-scm, jdk, cython, pythonJavabridge}:

buildPythonPackage rec {
    pname = "python-bioformats";
    version = "4.1.0";

    # We note that the 4.1.0 version uses underscores!!
    src = fetchPypi{
      pname = "python_bioformats";
      version = "4.1.0";
      sha256= "sha256-hTc/cKSotI/YdBTl6rCqlh57sHdyZF9eAJpvF0V8tOs=";
    };

    # checkInputs = [pkgs.pytest pkgs.nose];
    doCheck = true;
    propagatedBuildInputs = [boto3 future cython pythonJavabridge ];
    nativeBuildInputs = [ numpy jdk ];
    buildInputs = [numpy];
    checkInputs = [pytest nose];

    build-system = [
      setuptools
      setuptools-scm
    ];

    pyproject = true;

    meta = with lib; {
      homepage = "https://github.com/CellProfiler/python-bioformats/";
      descriptions = ''python-bioformats'';
      license = lib.licenses.mit;
    };
}

