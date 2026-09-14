{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  python3,
  xcursorgen,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-cursor-theme-standard-with-shadow";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;
  
  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];

  buildInputs = [
    python3
    xcursorgen
  ];

  preConfigure = "cd cursors/with-shadow/standard";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
