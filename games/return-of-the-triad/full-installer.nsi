!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Return of the Triad. It will:$\r$\n\
- install the latest version of GZDoom$\r$\n\
- install Return of the Triad v1.6$\r$\n\
- install the addon, Scream of the Triad$\r$\n\
- (optionally) install Freedoom Phase 1$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Leon Zawada, Simon Rance, and the ZDoom team!"

!include "..\..\includes\templates\ClassicTemplate.nsh"

Name "Return of the Triad"
InstallDir "C:\MulderLoad\Return of the Triad"

Section "Return of the Triad v1.6 + GZDoom v4.14"
    AddSize 45568
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ZDoom/gzdoom/releases/download/g4.14.2/gzdoom-4-14-2-windows.zip" \
                            "https://cdn2.mulderload.eu/g/_common/gzdoom-4-14-2-windows.zip" \
                            "gzdoom.zip" "2b3e7eac9e13bf88d27865165a1596de5778eb1a"
    !insertmacro NSISUNZ_EXTRACT "gzdoom.zip" ".\" "AUTO_DELETE"

    # https://www.moddb.com/mods/return-of-the-triad/downloads/return-of-the-triad-16
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/36543" \
                            "https://cdn2.mulderload.eu/g/return-of-the-triad/rott_tc_16.zip" \
                            "rott_tc_16.zip" "e67988147c4a745d07d30090a54c5a39"
    !insertmacro NSISUNZ_EXTRACT "rott_tc_16.zip" ".\" "AUTO_DELETE"
SectionEnd

Section "Addon - Scream of the Triad"
    AddSize 265
    SetOutPath "$INSTDIR"

    # https://www.moddb.com/mods/return-of-the-triad/addons/scream-of-the-triad
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/addons/start/221461" \
                            "https://cdn2.mulderload.eu/g/return-of-the-triad/ROTT_ScreamTriad.zip" \
                            "ROTT_ScreamTriad.zip" "a6e0a77da276117df18a4c9e9216dfd3"
    !insertmacro NSISUNZ_EXTRACT "ROTT_ScreamTriad.zip" ".\" "AUTO_DELETE"
SectionEnd

Section /o "Freedoom: Phase 1 (if you don't have Doom or Doom 2 installed)"
    AddSize 28114
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedoom-0.13.0.zip" \
                            "https://cdn2.mulderload.eu/g/freedoom/freedoom-0.13.0.zip" \
                            "freedoom.zip" "957bc049d165d8454c6aa35849e9ca0da1ddfcea"
    !insertmacro NSISUNZ_EXTRACT_ONE "freedoom.zip" ".\" "freedoom-0.13.0\freedoom1.wad" "AUTO_DELETE"
SectionEnd
