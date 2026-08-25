!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Resident Evil 3 (GOG), with:$\r$\n\
- Resident Evil 3 Classic REbirth (by Gemini)$\r$\n\
- Modern Controls Mods$\r$\n\
- Translation patches$\r$\n\
- Resident Evil 3 HD Mod (by TeamX)$\r$\n\
- Seamless HD Project v2.0 (by RESHDP)$\r$\n\
- RE-Enhance RE3 v2.2 (by SonicB00M)$\r$\n\
- High Quality FMVs$\r$\n\
- High Quality Audio (by lexas87)$\r$\n\
$\r$\n\
WARNING: make sure you've downloaded the Japanese version of the game on GOG.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\XDelta3.nsh"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Resident Evil 3 [GOG Enhancement Pack]"

!define GOG_ENHANCEMENT_PACK_NSI
!include "steam-enhancement-pack.nsi"

Function .onInit
    StrCpy $8 ${audio1} ; Radio Button
    StrCpy $9 ${fmv1} ; Radio Button
    StrCpy $SELECT_FILENAME "BH3Launcher.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Resident Evil 3"
FunctionEnd
