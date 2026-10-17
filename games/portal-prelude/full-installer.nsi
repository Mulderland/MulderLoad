!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Portal: Prelude (non-RTX version).$\r$\n\
$\r$\n\
IMPORTANT:$\r$\n\
- you need to have $\"Source SDK Base 2007$\" installed$\r$\n\
- after installation, restart Steam so the game appears$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define AFTER_DIRECTORY_PAGE
!include "..\..\includes\templates\ClassicTemplate.nsh"

Name "Portal: Prelude"
InstallDir "C:\MulderLoad\Portal Prelude"

Section "Portal: Prelude v1.2.1"
    AddSize 1394606
    SetOutPath "$INSTDIR\@mulderload"

    !insertmacro DOWNLOAD_2 "https://www.portalprelude.com/download.php?id=149" \
                            "https://www.moddb.com/mods/portal-prelude/downloads/portal-prelude-121" \
                            "portal-prelude-archive-1.2.1.zip" \
                            "01fb4ead9bc8718fcace26c213e629d8"

    !insertmacro NSISUNZ_EXTRACT "portal-prelude-archive-1.2.1.zip" ".\" "AUTO_DELETE"

    # Move the files to the root of the installation folder
    SetOutPath "$INSTDIR"
    !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\portal prelude" "$INSTDIR"
    !insertmacro FORCE_RENAME "$INSTDIR\@mulderload\README.txt" "$INSTDIR\README.txt"
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function AfterDirectoryPage
    !insertmacro STEAM_SOURCEMOD_PRE_INSTALL "Source SDK Base 2007" "portal prelude"
FunctionEnd
