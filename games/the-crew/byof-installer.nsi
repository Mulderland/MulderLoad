!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game files. You must provide your own archive of $\"The Crew 1.2.0.0 (Worldwide) - Build 502193$\".$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your game backup$\r$\n\
- install it to a folder of your choice$\r$\n\
- fix NTFS permissions in the game folder$\r$\n\
- install The Crew Unlimited (the server emulator)$\r$\n\
- (optionally) whitelist the game folder in Windows Defender*$\r$\n\
- install a fix for too long launch times$\r$\n\
$\r$\n\
*NOTE: if you use another antivirus, you'll probably have to manually exclude the game folder, as TCU uses dll injection.$\r$\n\
$\r$\n\
Congratulations to the TCU Team for their amazing work!"

!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!define MUI_FINISHPAGE_RUN "$INSTDIR\TCULauncher.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Configure TCULauncher"
!include "..\..\includes\templates\ByofTemplate.nsh"
RequestExecutionLevel admin ; required to fix folder permissions and to exclude TCU from Windows Defender

Name "The Crew"
InstallDir "C:\MulderLoad\The Crew"

; !insertmacro BYOF_DEFINE "DVD1" "Image files|*.iso" "9ddb69755db1ec0d961e81c88ea6169264ffbb78"
; !insertmacro BYOF_DEFINE "DVD2" "Image files|*.iso" "8314ca93c7322eeaabb299b0b964aa650cc508d0"
!insertmacro BYOF_DEFINE "BACKUP" "Archive files|*.7z;*.rar;*.zip" "3fe2301cf45147960bbf108cc801fe7c4955e630"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

/*Function EnableNextButton
    ${If} $BYOF_BACKUP_Path != ""
        ${If} $BYOF_DVD1_Path == ""
        ${AndIf} $BYOF_DVD2_Path == ""
            Push 1
        ${Else}
            Push 0
        ${EndIf}
    ${ElseIf} $BYOF_DVD1_Path != ""
    ${AndIf} $BYOF_DVD2_Path != ""
        Push 1
    ${Else}
        Push 0
    ${EndIf}
FunctionEnd*/

Section "The Crew (Full Installation)"
    AddSize 25544553

    !insertmacro NSIS7Z_EXTRACT "$byofPath_BACKUP" "$INSTDIR" ""

    IfFileExists "$INSTDIR\The Crew\*.*" 0 test_dir_worldwide
        !insertmacro FOLDER_MERGE "$INSTDIR\The Crew" "$INSTDIR"

    test_dir_worldwide:
    IfFileExists "$INSTDIR\The Crew (Worldwide)\*.*" 0 test_dir_done
        !insertmacro FOLDER_MERGE "$INSTDIR\The Crew (Worldwide)" "$INSTDIR"
    test_dir_done:

    nsExec::ExecToLog /OEM 'icacls "$INSTDIR" /grant *S-1-5-32-545:(OI)(CI)M /T'
SectionEnd

!define NSI_INCLUDE
!define README_FILE "BYOF_README.txt"
!include "enhancement-pack.nsi"
