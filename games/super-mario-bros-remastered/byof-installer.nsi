!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game ROM. You must provide your own (US) ROM of $\"Super Mario Bros.$\" in BigEndian format.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your ROM$\r$\n\
- copy it to a folder of your choice$\r$\n\
- install Super Mario Bros Remastered$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to JHDev2006 for this fan-remake!. Super Mario is a trademark of Nintendo. This installer is not affiliated with Nintendo in any way."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "Super Mario Bros Remastered"
InstallDir "C:\MulderLoad\Super Mario Bros Remastered"

!insertmacro BYOF_DEFINE "ROM" "NES files|*.nes" "33d23c2f2cfa4c9efec87f7bc1321ce3ce6c89bd"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "Super Mario Bros Remastered v1.02"
    AddSize 128000
    SectionIn RO
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/JHDev2006/Super-Mario-Bros.-Remastered-Public/releases/download/1.0.2/Windows.zip" \
                            "https://cdn2.mulderload.eu/g/super-mario-bros-remastered/Windows.zip" \
                            "SMBR.zip" "0f6a19f09d561259d506165abddce1c2815d889d"

    !insertmacro NSISUNZ_EXTRACT "SMBR.zip" ".\" "AUTO_DELETE"

    CopyFiles "$byofPath_ROM" "$INSTDIR\Super Mario Bros.nes"
SectionEnd
