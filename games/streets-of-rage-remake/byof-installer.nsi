!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download the latest version of Streets of Rage Remake (v5.2) from the Archive.org servers, and extract it in the folder of your choice.$\r$\n$\r$\nA big thanks to Bombergames for the development of this game!"
!include "..\..\templates\standard.nsh"

Name "Streets of Rage Remake"
InstallDir "C:\MulderLoad\Streets of Rage Remake"

Section "Streets of Rage Remake v5.2"
    SectionIn RO
    !insertmacro AbortIfFolderNotEmpty $INSTDIR
    SetOutPath $INSTDIR.tmp

    !insertmacro Download https://archive.org/download/streets-of-rage-remake/Streets%20of%20Rage%20Remake%20%285.2%29.zip "Streets_of_Rage_Remake_5.2.zip"
    nsisunz::Unzip "Streets_of_Rage_Remake_5.2.zip" ".\"
    Delete "Streets_of_Rage_Remake_5.2.zip"

    Rename "$INSTDIR.tmp\Streets of Rage Remake (5.2)" $INSTDIR
    SetOutPath $INSTDIR
    RMDir $INSTDIR.tmp
SectionEnd
