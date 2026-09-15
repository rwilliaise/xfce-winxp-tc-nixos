
patchAssetDirPreConfigure() {
    substituteInPlace ./**/*.c --replace-quiet "WINTC_ASSETS_DIR" "\"$out/share/wintc\"";
    substituteInPlace ./**/*.h --replace-quiet "WINTC_ASSETS_DIR" "\"$out/share/wintc\"";
}

preConfigureHooks+=(patchAssetDirPreConfigure)
