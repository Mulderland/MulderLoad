!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Portal: Prelude (non-RTX version).$\r$\n\
$\r$\n\
IMPORTANT:$\r$\n\
- you need to have $\"Source SDK Base 2007$\" installed$\r$\n\
- after installation, restart Steam so the game appears$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Portal: Prelude"

Section "Portal: Prelude v1.2.1"
    AddSize 1394606
    SetOutPath "$INSTDIR\portal prelude"

    # https://www.moddb.com/mods/portal-prelude/downloads/portal-prelude-121
    !insertmacro DOWNLOAD_3 "https://www.portalprelude.com/download.php?id=149" \
                            "https://www.moddb.com/downloads/start/252772" \
                            "https://cdn2.mulderload.eu/g/portal-prelude/portal-prelude-archive-1.2.1.zip" \
                            "portal-prelude-archive-1.2.1.zip" "01fb4ead9bc8718fcace26c213e629d8"

    SetOutPath "$INSTDIR"
    !insertmacro NSISUNZ_EXTRACT "portal prelude\portal-prelude-archive-1.2.1.zip" ".\" "AUTO_DELETE"

    !insertmacro FORCE_RENAME "$INSTDIR\README.txt" "$INSTDIR\portal prelude\README.txt"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods"
FunctionEnd
