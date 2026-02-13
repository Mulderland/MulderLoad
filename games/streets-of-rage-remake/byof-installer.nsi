!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the fan-game archive. You must provide your own backup of $\"Streets of Rage Remake v5.2$\" released by Bombergames.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your ZIP backup$\r$\n\
- extract it to a folder of your choice$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Bombergames for this nice fan-remake! Streets of Rage is a trademark of Sega. This installer is not affiliated with or endorsed by Sega."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "Streets of Rage Remake"
InstallDir "C:\MulderLoad\Streets of Rage Remake"

!insertmacro BYOF_DEFINE "BACKUP" "ZIP files|*.zip" "9272ecf6b27f9f0a9ae300d8938d346f543b8775,c6183202071ab9b6f7accf86509fe76f4da69d7b,3ef6b52b5e30bb37fb4f38b77037a11774860bfa"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "Streets of Rage Remake v5.2 (Full Installation)"
    AddSize 622592

    !insertmacro NSISUNZ_EXTRACT "$byofPath_BACKUP" "$INSTDIR" ""

    IfFileExists "$INSTDIR\Streets of Rage Remake\*.*" 0 endif1
        !insertmacro FOLDER_MERGE "$INSTDIR\Streets of Rage Remake" "$INSTDIR"
    endif1:

    IfFileExists "$INSTDIR\Streets of Rage Remake 5.2\*.*" 0 endif2
        !insertmacro FOLDER_MERGE "$INSTDIR\Streets of Rage Remake 5.2" "$INSTDIR"
    endif2:

    IfFileExists "$INSTDIR\Streets of Rage Remake (5.2)\*.*" 0 endif3
        !insertmacro FOLDER_MERGE "$INSTDIR\Streets of Rage Remake (5.2)" "$INSTDIR"
    endif3:

    IfFileExists "$INSTDIR\SORRv52\*.*" 0 endif4
        !insertmacro FOLDER_MERGE "$INSTDIR\SORRv52" "$INSTDIR"
    endif4:
SectionEnd
