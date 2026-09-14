
{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  python3,
  sassc,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-theme-luna-blue";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;
  
  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    (python3.withPackages (pps: with pps; [
      pillow
    ]))
    sassc
  ];

  preConfigure = "cd themes/luna/blue";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
