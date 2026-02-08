!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download and extract AM2RLauncher (a launcher and updater for the game)$\r$\n- the required AM2R_11.zip from Archive.org$\r$\n$\r$\nA big thanks to DoctorM64 for the development of this game!"
!include "..\..\templates\standard.nsh"

Name "AM2R"
InstallDir "C:\MulderLoad\AM2R"

Section "AM2R v1.1 + AM2RLauncher v2.3"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/AM2R-Community-Developers/AM2RLauncher/releases/download/2.3.0/AM2RLauncher_2.3.0_win_DownloadMe.zip "AM2RLauncher.zip"
    nsisunz::Unzip "AM2RLauncher.zip" ".\"
    Delete "AM2RLauncher.zip"

    !insertmacro Download https://archive.org/download/am2r1.1/am2r-another-metroid-2-remake-1-1.zip "AM2R_11.zip"
SectionEnd
