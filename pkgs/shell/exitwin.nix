{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  glib,
  gtk3,

  comgtk,
  msgina,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-exitwin";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    glib
    gtk3

    comgtk
    msgina
  ];

  preConfigure = "cd shell/exitwin";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];

  meta.mainProgram = "exitwin";
}
