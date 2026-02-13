!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Freedoom. It will:$\r$\n\
- install the latest version of GZDoom$\r$\n\
- install Freedoom && FreeDM WADs$\r$\n\
- (optionally) install the Doom Shareware WAD$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the ZDoom and Freedoom teams!"

!include "..\..\includes\templates\ClassicTemplate.nsh"

Name "Freedoom"
InstallDir "C:\MulderLoad\Freedoom"

Section "Freedoom v0.13 + GZDoom v4.14"
    AddSize 110592
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ZDoom/gzdoom/releases/download/g4.14.2/gzdoom-4-14-2-windows.zip" \
                            "https://cdn2.mulderload.eu/g/_common/gzdoom-4-14-2-windows.zip" \
                            "gzdoom.zip" "2b3e7eac9e13bf88d27865165a1596de5778eb1a"
    !insertmacro NSISUNZ_EXTRACT "gzdoom.zip" ".\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_2 "https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedm-0.13.0.zip" \
                            "https://cdn2.mulderload.eu/g/freedoom/freedm-0.13.0.zip" \
                            "freedm.zip" "ebd342b93bb1628fc0d4cbf74302cbb21bdecafc"
    !insertmacro NSISUNZ_EXTRACT_ONE "freedm.zip" ".\" "freedm-0.13.0\freedm.wad" "AUTO_DELETE"

    !insertmacro DOWNLOAD_2 "https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedoom-0.13.0.zip" \
                            "https://cdn2.mulderload.eu/g/freedoom/freedoom-0.13.0.zip" \
                            "freedoom.zip" "957bc049d165d8454c6aa35849e9ca0da1ddfcea"
    !insertmacro NSISUNZ_EXTRACT_ONE "freedoom.zip" ".\" "freedoom-0.13.0\freedoom1.wad" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "freedoom.zip" ".\" "freedoom-0.13.0\freedoom2.wad" "AUTO_DELETE"
SectionEnd

Section /o "Doom 1 Shareware IWAD"
    AddSize 4098
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.doomworld.com/3ddownloads/ports/shareware_doom_iwad.zip" \
                            "https://cdn2.mulderload.eu/g/freedoom/shareware_doom_iwad.zip" \
                            "shareware_doom_iwad.zip" "2d274030c4ba07b9bd1409e5e80f47a6df4efd3a"
    !insertmacro NSISUNZ_EXTRACT "shareware_doom_iwad.zip" ".\" "AUTO_DELETE"
SectionEnd
