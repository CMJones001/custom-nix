{lib, buildPythonPackage, fetchPypi} :

buildPythonPackage rec {
  pname = "fake-bpy-module-3.2";
  version = "20220615";

  src = fetchPypi{
    inherit pname version;
    sha256= "sha256-g5ISDKrW9lUDRGXNk5f4jO5wpU5BRm5mHyLaFrWlr8E=";
  };

  meta = with lib; {
    homepage = "https://github.com/nutti/fake-bpy-module";
    descriptions = "fake-bpy-module is the collections of the fake Blender Python API modules for the code completion in commonly used IDEs.";
    license = lib.licenses.mit;
    
  };
}
