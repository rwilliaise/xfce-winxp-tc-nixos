{
  lib,
  stdenv,
  xfce-winxp-tc-repo,

  autoPatchelfHook,
  cmake,
  pkg-config,
  ninja,

  gdk-pixbuf,
  glib,
  gtk3,
  libwnck,

  comgtk,

  _defaultCmakeFlags,

  sku ? "xpclient-pro",
}:

stdenv.mkDerivation {
  pname = "wintc-shelldpa";
  version = xfce-winxp-tc-repo.rev;
  src = xfce-winxp-tc-repo;

  nativeBuildInputs = [
    autoPatchelfHook
    cmake
    pkg-config
    ninja
  ];
  buildInputs = [
    gdk-pixbuf
    glib
    gtk3
    libwnck

    comgtk
  ];

  preConfigure = "cd shared/shelldpa";

  postInstall = ''
    # Make autoPatchelfHook add libwnck to the rpath.
    find $out -name "*.so" -executable -exec patchelf --add-needed libwnck-3.so.0 {} \;
  '';

  cmakeFlags = _defaultCmakeFlags ++ [
    (lib.strings.cmakeFeature "WINTC_SKU" sku)
  ];
}
