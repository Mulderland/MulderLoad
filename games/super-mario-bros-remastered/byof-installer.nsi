!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download Super Mario Bros Remastered (v1.02) from Github, extract it to the folder of your choice, and download the original NES ROM of Super Mario Bros from Archive.org servers.$\r$\n$\r$\nEternal respect to Nintendo for this piece of history, and a big thanks and congratulations to Joe H for his fan remaster!"
!include "..\..\templates\standard.nsh"

Name "Super Mario Bros Remastered"
InstallDir "C:\MulderLoad\Super Mario Bros Remastered"

Section "Super Mario Bros Remastered v1.02"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/JHDev2006/Super-Mario-Bros.-Remastered-Public/releases/download/1.0.2/Windows.zip "SMBR.zip"
    nsisunz::Unzip "SMBR.zip" ".\"
    Delete "SMBR.zip"

    !insertmacro Download https://archive.org/download/super-mario-bros-nes/Super%20Mario%20Bros..nes "Super%20Mario%20Bros..nes"
    Rename "$INSTDIR\Super%20Mario%20Bros..nes" "$INSTDIR\Super Mario Bros.nes"
SectionEnd
