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

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-exec";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  patches = [
    ../../patches/exec-qualify-unix.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    glib
    gtk3

    comgtk
  ];

  preConfigure = "cd shared/exec";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
