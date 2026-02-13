!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the fan-game archive. You must provide your own backup of $\"BBPSX_1.05.zip$\" released by LWMedia.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your BBPSX_1.05.zip$\r$\n\
- extract it to a folder of your choice$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to LWMedia. Bloodborne is a trademark of Sony Interactive Entertainment. This project is not affiliated with or endorsed by Sony or FromSoftware."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "Bloodborne PSX"
InstallDir "C:\MulderLoad\Bloodborne PSX"

!insertmacro BYOF_DEFINE "BACKUP" "ZIP files|*.zip" "c695f86ca7fa6d244f8def74481430d3113ad8a9"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "Bloodborne PSX v1.05 (Full Installation)"
    AddSize 204800
    SetOutPath "$INSTDIR"

    !insertmacro NSISUNZ_EXTRACT "$byofPath_BACKUP" ".\" ""
    !insertmacro FOLDER_MERGE "$INSTDIR\BBPSX_Build_2022_02_06_1.05\WindowsNoEditor" "$INSTDIR"
    RMDir "$INSTDIR\BBPSX_Build_2022_02_06_1.05"
SectionEnd
