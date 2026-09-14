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
  pname = "wintc-user-pictures";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;
  
  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];

  preConfigure = "cd enduser/userpics";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
