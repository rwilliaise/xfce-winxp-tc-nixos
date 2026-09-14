{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  cmake,
  pkg-config,
  ninja,

  glib,
  gtk3,

  comctl,
  comgtk,
  exec,
  shcommon,
  shlang,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-shell-run";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  patches = [
    ../../patches/shell-run-add-gio.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    glib
    gtk3

    comctl
    comgtk
    exec
    shcommon
    shlang
  ];

  preConfigure = "cd shell/run";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
