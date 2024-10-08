{ lib, buildPythonPackage, fetchPypi, fetchFromGitHub, numpy, cython, jdk, setuptools, setuptools-scm }:

buildPythonPackage rec {
    pname = "python-javabridge";
    version = "4.0.3";

    src = fetchFromGitHub {
      owner = "CMJones001";
      repo = "python-javabridge";
      rev = "79204f";
      sha256= "sha256-J4VJlLNksTJf0gL37cXALR19vJc3pjKFhwhtujAo7KI=";
    };

    doCheck = false;
    pythonImportsCheck = ["javabridge"];

    propagatedBuildInputs = [jdk cython numpy];
    nativeBuildInputs = [jdk numpy cython];
    build-system = [
      setuptools
      setuptools-scm

    ];
    pyproject = true;

    meta = with lib; {
      homepage = "https://github.com/LeeKamentsky/python-javabridge";
      descriptions = ''
        The javabridge Python package makes it easy
        to start a Java virtual machine (JVM) from Python and interact with it.
        Python code can interact with the JVM using a low-level API or a more convenient high-level API.
        '';
      license = lib.licenses.mit;
    };
}
