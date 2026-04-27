!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Resident Evil 2 (GOG), with:$\r$\n\
- Resident Evil 2 Classic REbirth$\r$\n\
- Modern Controls Plus (Mod)$\r$\n\
- Translation patches$\r$\n\
- Resident Evil 2 HD Mod (by TeamX)$\r$\n\
- Seamless HD Project v2.0 Patch 2 (by RESHDP)$\r$\n\
- RE-Enhance v2.0.1 (by SonicB00M)$\r$\n\
- High Quality FMVs$\r$\n\
- High Quality Audio (by lexas87)$\r$\n\
$\r$\n\
WARNING: make sure you've downloaded the Japanese version of the game on GOG.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
$\r$\n\
Special thanks to the Classic REbirth team!"

!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Resident Evil 2 [GOG Enhancement Pack]"

!define GOG_ENHANCEMENT_PACK_NSI
!include "steam-enhancement-pack.nsi"

Function .onInit
    StrCpy $9 ${fmv1} ; Radio Button
    StrCpy $SELECT_FILENAME "BH2Launcher.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\GOG Galaxy\Games\Resident Evil 2"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
