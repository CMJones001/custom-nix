{lib, buildPythonPackage, fetchPypi, numpy}:

buildPythonPackage rec {
  pname = "pymeshlab";
  version = "2022.2.post2";
  format = "wheel";


  src = fetchPypi{
    inherit version pname format;
    python = "cp310";
    platform = "manylinux1_x86_64";
    dist = "cp310";
    sha256= "sha256-vrM6ByfxL8rO7MUfdO6Bt0Hefz8NuIl1zTl7POM5bCQ=";
    abi = "cp310";
  };

  propagatedBuildInputs = [numpy ];

  meta = with lib; {
    homepage = "https://pymeshlab.readthedocs.io/en/latest/";
    descriptions = "PyMeshLab is a Python library that interfaces to MeshLab, the popular open source application for editing and processing large 3D triangle meshes";
    license = lib.licenses.mit;
  };
}
