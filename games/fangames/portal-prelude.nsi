!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download Portal Prelude v1.2.1 from developer servers$\r$\n$\r$\nYou need to have 'Source SDK Base 2007' for this mod to work, this installer will try to install it via Steam.$\r$\n$\r$\nAfter installation, you will have to quit & restart Steam for the game to appear in your library."
!include "..\..\templates\select_exe.nsh"

Name "Portal: Prelude"

Section "Source SDK Base 2007 (Steam)"
    MessageBox MB_ICONINFORMATION  "Steam will install Source SDK Base 2007. Click OK and follow instructions on Steam."
    Exec '"$INSTDIR\..\..\..\steam.exe" steam://install/218'
    Sleep 10000
    MessageBox MB_OK "Click OK when 'Source SDK Base 2007' installation is complete."
SectionEnd

Section "Portal: Prelude v1.2.1"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://www.portalprelude.com/download.php?id=149 "portal-prelude-archive-1.2.1.zip"
    nsisunz::Unzip "portal-prelude-archive-1.2.1.zip" ".\"
    Delete "portal-prelude-archive-1.2.1.zip"

    Rename "$INSTDIR\README.txt" "$INSTDIR\portal prelude\README.txt"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods"
FunctionEnd
