!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download uncensored (USA) version of Wolfram, already updated to v1.1"
!include "..\..\templates\standard.nsh"

Name "Wolfram"
InstallDir "C:\MulderLoad\Wolfram"

Section "Wolfram Uncensored (US) v1.1"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/cl23g06zql1vr88/Wolfram_Uncensored_v1.1.7z/file "Wolfram.7z"
    Nsis7z::ExtractWithDetails "Wolfram.7z" "Installing package %s..."
    Delete "Wolfram.7z"
SectionEnd
