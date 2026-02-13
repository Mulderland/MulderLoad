!define MUI_WELCOMEPAGE_TEXT "\
This installer is for The Stanley Parable (the 2011 mod), an early version of what would become the full commercial game two years later.$\r$\n\
$\r$\n\
IMPORTANT:$\r$\n\
- you need to have $\"Source SDK Base 2007$\" installed$\r$\n\
- after installation, restart Steam so the game appears$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the development team, Galactic Cafe! Consider buying the full game on Steam: it has a lot more content than this early version."

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "The Stanley Parable (Mod)"

Section "The Stanley Parable v1.4"
    AddSize 77722
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_3 "https://www.moddb.com/downloads/start/37782" \
                            "https://cdn2.mulderload.eu/g/the-stanley-parable-mod/The_Stanley_Parable_v1.4.zip" \
                            "https://www.mediafire.com/file_premium/xffffm9ryi03mz6/The_Stanley_Parable_v1.4.zip/file" \
                            "The_Stanley_Parable_v1.4.zip" "72f33f83ed50e4b79affe781632c6e8814cc2de1"
    !insertmacro NSISUNZ_EXTRACT "The_Stanley_Parable_v1.4.zip" ".\" "AUTO_DELETE"

    RMDir /r "$INSTDIR\__MACOSX"
    !insertmacro FOLDER_MERGE "$INSTDIR\thestanleyparable" "$INSTDIR"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods\thestanleyparable"
FunctionEnd
