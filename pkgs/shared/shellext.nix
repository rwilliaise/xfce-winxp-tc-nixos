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
  exec,
  shcommon,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-shellext";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  patches = [
    ../../patches/shellext-add-gio.patch
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
    exec
    shcommon
  ];

  preConfigure = "cd shared/shellext";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
