{lib, buildPythonPackage, fetchPypi, fetchFromGitHub, boto3, future, numpy, pytest, nose, setuptools, setuptools-scm, jdk, cython}:

buildPythonPackage rec {
    pname = "python-bioformats";
    version = "4.1.0";

    src = fetchFromGitHub {
      owner="CellProfiler";
      repo="python-bioformats";
      rev = "e5f75fd";
      sha256 = "sha256-J4VJlLNksTJf0gL37cXALR19vJc3pjKFhwhtujAo7KI=";
    };

    # src = fetchPypi{
    #   inherit pname version;
    #   sha256= "sha256-nNrdBuJFNWa/zFEuufd0ZU6f017gKn+16PsJeBLFczs=";
    # };

    # checkInputs = [pkgs.pytest pkgs.nose];
    doCheck = true;
    propagatedBuildInputs = [boto3 future cython];
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

