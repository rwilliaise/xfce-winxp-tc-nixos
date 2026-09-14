{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-fonts-xp";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;
  
  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];

  preConfigure = "cd fonts";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
