!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dino Crisis (GOG), with:$\r$\n\
- Windows XP Patch$\r$\n\
- High Quality Videos$\r$\n\
- Classic REbirth$\r$\n\
- (optionaly) High Quality Voices && Music (Dreamcast)$\r$\n\
- (optionaly) High Quality Textures (Dreamcast upscaled)$\r$\n\
$\r$\n\
WARNING: make sure you've downloaded the Japanese version of the game on GOG.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Dino Crisis [GOG Enhancement Pack]"

Section
    DetailPrint " // Checking that binary is supported"
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\DINO.exe" "2beb1dc79513258ca45116f5933714e1a109c4da" $0 ; Windows XP Patch checksum
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\DINO.exe" "9282dbbcb381188bf1b2e1f6c483dcd82a22ec0a" $1 ; GOG Japanese checksum
    ${If} $0 != "1"
    ${AndIf} $1 != "1"
        MessageBox MB_ICONEXCLAMATION "Only GOG Japanese release can apply this patch.$\r$\n\
        $\r$\n\
        Make sure you downloaded the Japanese version of the game on GOG."
        Quit
    ${EndIf}
SectionEnd

!define GOG_ENHANCEMENT_PACK_NSI
!include "steam-enhancement-pack.nsi"

Section "Remove Non-REbirth files"
    Delete "$INSTDIR\Movie\*.dat"
    Delete "$INSTDIR\dxcfg.*"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DINO.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\GOG Galaxy\Games\Dino Crisis\DINO.exe"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
