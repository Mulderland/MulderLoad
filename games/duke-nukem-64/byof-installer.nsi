!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game ROM. You must provide your own ROM of $\"Duke Nukem 64$\" in BigEndian format.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your ROM$\r$\n\
- copy it to a folder of your choice$\r$\n\
- install the RedNukem source port$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Nuke.YKT for the Redukem source port. Duke Nukem 64 is the property of Nintendo and 3D Realms."

!include "..\..\includes\templates\ByofTemplate.nsh"

#..............................................................BigEndian/USA............................BigEndian/Europe
!insertmacro BYOF_DEFINE "ROM" "ROM64 files|*.z64" "98d6778004becc672eba0a5e887f6e3f3d1b5c15,6cc06f6097f90228bd7d7784fa7d20ba17e82eef"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Name "Duke Nukem 64"
InstallDir "C:\MulderLoad\Duke Nukem 64"

Section "Duke Nukem 64 + Rednukem x64 r14331"
    AddSize 15412
    SetOutPath "$INSTDIR"

    !insertmacro STR_RESOLVE_FILENAME "$byofPath_ROM" 1 $0
    CopyFiles "$byofPath_ROM" "$INSTDIR\$0"

    !insertmacro DOWNLOAD_2 "https://github.com/NBlood/NBlood/releases/download/r14331/rednukem_win64_20260108-r14331.7z" \
                            "https://cdn2.mulderload.eu/g/duke-nukem-64/rednukem_win64_20260108-r14331.7z" \
                            "rednukem.7z" "bcfebf0304d33823714952e9a839e1a1738a7dab"
    !insertmacro NSIS7Z_EXTRACT "rednukem.7z" ".\" "AUTO_DELETE"
SectionEnd
