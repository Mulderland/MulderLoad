!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download$\r$\n- RedNukem from official Github (and extract it)$\r$\n- USA ROM of Duke Nukem 64 from Archive.org"
!include "..\..\templates\standard.nsh"

Name "Duke Nukem 64"
InstallDir "C:\MulderLoad\Duke Nukem 64"

Section "Duke Nukem 64 (USA ROM) + Rednukem x64 r14198"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/NBlood/NBlood/releases/download/r14198/rednukem_win64_20250225-r14198.7z "rednukem.7z"
    Nsis7z::ExtractWithDetails "rednukem.7z" "Installing package %s..."
    Delete "rednukem.7z"

    !insertmacro Download https://archive.org/download/20240625_20240625_0555/Duke%20Nukem%2064%20%28USA%29.z64 "Duke Nukem 64 (USA).z64"
SectionEnd
