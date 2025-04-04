{ lib, buildPythonPackage, fetchPypi,
  numpy, cython, 
  libaec, brotli, brunsli, bzip2, c-blosc, c-blosc2, charls,
  giflib, jxrlib, lcms2, lerc, libavif, libdeflate, libheif,
  libjpeg, libjxl, xz, libpng, libtiff, libwebp, lz4, lzfse,
  mozjpeg, zlib,
  
  setuptools, setuptools-scm
}:

buildPythonPackage rec {
  pname = "imagecodecs";
  version = "2023.9.18";

  src = fetchPypi {
    inherit pname version;
    sha256= "sha256-v0tL5HWfw7J7UCIiiq2oPnNXROS3wgS83MqpYcP3nU0=";
  };

  propagatedBuildInputs = [cython numpy];
  buildInputs = [
    libaec brotli brunsli bzip2 c-blosc c-blosc2 charls
    giflib jxrlib lcms2 lerc libavif libdeflate libheif
    libjpeg libjxl xz libpng libtiff libwebp lz4 lzfse
    mozjpeg zlib
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  pyproject = true;
}
