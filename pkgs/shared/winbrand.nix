{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  gdk-pixbuf,
  glib,
  gtk3,

  comgtk,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-winbrand";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    gdk-pixbuf
    glib
    gtk3

    comgtk
  ];

  preConfigure = "cd shared/winbrand";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
