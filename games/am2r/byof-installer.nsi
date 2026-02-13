!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the fan-game archive. You must provide your own backup of $\"AM2R_11.zip$\" released by DoctorM64.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your AM2R_11.zip$\r$\n\
- copy it to a folder of your choice$\r$\n\
- install AM2RLauncher (a launcher and updater)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to DoctorM64 and the AM2RLauncher community! Metroid is a trademark of Nintendo. This project is not affiliated with or endorsed by Nintendo."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "AM2R"
InstallDir "C:\MulderLoad\AM2R"

!insertmacro BYOF_DEFINE "BACKUP" "ZIP files|*.zip" "b6b722a2b4fb366e6e94dfda869d369f4ad93cbc"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "AM2R v1.1 + AM2RLauncher v2.3"
    SetOutPath "$INSTDIR"
    AddSize 86016

    !insertmacro DOWNLOAD_2 "https://github.com/AM2R-Community-Developers/AM2RLauncher/releases/download/2.3.0/AM2RLauncher_2.3.0_win_DownloadMe.zip" \
                            "https://cdn2.mulderload.eu/g/am2r/AM2RLauncher_2.3.0_win_DownloadMe.zip" \
                            "AM2RLauncher.zip" "0fd83bd8c337b74e9e4e6e0af82cbc8bdcb639f5"
    !insertmacro NSISUNZ_EXTRACT "AM2RLauncher.zip" ".\" "AUTO_DELETE"

    CopyFiles "$byofPath_BACKUP" "$INSTDIR\AM2R_11.zip"
SectionEnd
