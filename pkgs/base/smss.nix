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
  msgina,
  shcommon,
  shell,
  shellext,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-smss";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  patches = [
    ../../patches/smss-add-gio.patch
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
    msgina
    shcommon
    shell
    shellext
  ];

  preConfigure = "cd base/smss";

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];

  meta.mainProgram = "smss";
}
