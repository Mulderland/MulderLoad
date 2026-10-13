!define MUI_WELCOMEPAGE_TEXT "\
This is an Ultrawide Patch (21/9 and 32/9) for Supermedo's Windows fork of BBPort.$\r$\n\
$\r$\n\
Tested on v1.7.1, but it should work with any version until ultrawide support is natively integrated into Supermedo's fork.$\r$\n\
$\r$\n\
It uses Kyo's patch, Dziggy's Ultrawide UI, and MulderConfig to lock and control bbport.ini.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\MulderConfig-README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show ultrawide instructions"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Bloodborne Supermedo's BBPort [Ultrawide Patch]"

Section "Ultrawide Patch (by Kyo, Dziggy & Mulder)"
    SetOutPath "$INSTDIR\.MulderConfig"
    File "resources\ultrawide\Bloodborne_Ultrawide.xml"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/202?tab=files&file_id=1286" \
                            "02 - 21.5x9  (43x18)-202-1-0-1-1736754983.zip" \
                            "7addc5c11d530e46ac225213ade6b7c33ede8764"

    !insertmacro NSISUNZ_EXTRACT "02 - 21.5x9  (43x18)-202-1-0-1-1736754983.zip" ".\" "AUTO_DELETE"
    RMDir /r "Ultrawide UI (21-9)"
    Rename "21.5x9 UI Fixes v1.0.1" "Ultrawide UI (21-9)"
    AddSize 736

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/202?tab=files&file_id=1288" \
                            "04 - 32x9-202-1-0-1-1736755039.zip" \
                            "d6583304ee3fcafb7f6614f73fba77522560f155"

    !insertmacro NSISUNZ_EXTRACT "04 - 32x9-202-1-0-1-1736755039.zip" ".\" "AUTO_DELETE"
    RMDir /r "Ultrawide UI (32-9)"
    Rename "32x9 UI Fixes v1.0.1" "Ultrawide UI (32-9)"
    AddSize 736

    ${IfNot} ${FileExists} "$INSTDIR\mods.json"
        File "/oname=$INSTDIR\mods.json" "resources\ultrawide\mods.json"
    ${EndIf}
    ${IfNot} ${FileExists} "$INSTDIR\\patches.json"
        File "/oname=$INSTDIR\patches.json" "resources\ultrawide\patches.json"
    ${EndIf}

    SetOutPath "$INSTDIR"
    File "resources\ultrawide\MulderConfig-README.txt"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources\ultrawide"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Play Bloodborne.exe"
FunctionEnd
