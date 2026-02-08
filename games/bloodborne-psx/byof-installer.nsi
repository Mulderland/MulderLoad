!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download the latest version of Bloodborne PSX (v1.05) from the Archive.org servers, and extract it in the folder of your choice.$\r$\n$\r$\nA big thanks to LWMedia for the development of this game!"
!include "..\..\templates\standard.nsh"

Name "Bloodborne PSX"
InstallDir "C:\MulderLoad\Bloodborne PSX"

Section "Bloodborne PSX v1.05"
    SectionIn RO
    !insertmacro AbortIfFolderNotEmpty $INSTDIR
    SetOutPath $INSTDIR.tmp

    !insertmacro Download https://archive.org/download/bbpsx-1.05_202204/BBPSX_1.05.zip "BBPSX_1.05.zip"
    nsisunz::Unzip "BBPSX_1.05.zip" ".\"
    Delete "BBPSX_1.05.zip"

    Rename "$INSTDIR.tmp\BBPSX_Build_2022_02_06_1.05\WindowsNoEditor" $INSTDIR
    SetOutPath $INSTDIR
    RMDir $INSTDIR.tmp\BBPSX_Build_2022_02_06_1.05
    RMDir $INSTDIR.tmp
SectionEnd
