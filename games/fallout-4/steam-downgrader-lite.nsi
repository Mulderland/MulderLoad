!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (v1.11.191, Dec 2025). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language* and your installed DLCs, then applies matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
This LITE edition was specially built for Nexus Mods (to work fully offline), but can only downgrade to v1.11.169 (Anniversary, November Patch - 2025)$\r$\n\
$\r$\n\
*WARNING (for Chinese): Chinese language can't be auto detected, so you'll have to select $\"Chinese$\" during setup.$\r$\n\
$\r$\n\
If you wish to downgrade to an earlier version (v1.10.984 or v1.10.163), you can find the FULL version of this downgrader on my website: www.mulderland.com"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader Lite]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.191) to" version
    Section
        StrCpy $DLC_Automatron "no"
        StrCpy $DLC_Workshop "no"

        IfFileExists "$INSTDIR\Data\DLCRobot.cdx" 0 +2
            StrCpy $DLC_Automatron "yes"

        IfFileExists "$INSTDIR\Data\DLCworkshop01.cdx" 0 +2
            StrCpy $DLC_Workshop "yes"
    SectionEnd

    Section "1.11.169 (anniversary, november patch)" version_1_11_169
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Copying downgrade 377162 (Base game)"
        File /r "resources-downgrader-lite\377162"

        DetailPrint " // Copying downgrade 377163 (Base game)"
        File /r "resources-downgrader-lite\377163"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Copying downgrade 404091 (Automatron DLC, Japanese)"
                File /r "resources-downgrader-lite\404091"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Copying downgrade 435871 (Automatron DLC, English)"
                File /r "resources-downgrader-lite\435871"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Copying downgrade 435872 (Automatron DLC, French)"
                File /r "resources-downgrader-lite\435872"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Copying downgrade 435873 (Automatron DLC, German)"
                File /r "resources-downgrader-lite\435873"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Copying downgrade 435874 (Automatron DLC, Italian)"
                File /r "resources-downgrader-lite\435874"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Copying downgrade 435875 (Automatron DLC, Spanish)"
                File /r "resources-downgrader-lite\435875"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Copying downgrade 435876 (Automatron DLC, Polish)"
                File /r "resources-downgrader-lite\435876"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Copying downgrade 435877 (Automatron DLC, Russian)"
                File /r "resources-downgrader-lite\435877"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Copying downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                File /r "resources-downgrader-lite\435878"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Copying downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                File /r "resources-downgrader-lite\435879"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Copying downgrade 435880 (Wasteland Workshop DLC)"
            File /r "resources-downgrader-lite\435880"
        ${EndIf}
    SectionEnd

    Section
        SetOutPath "$INSTDIR"
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
        !insertmacro XDELTA3_REMOVE
    SectionEnd
SectionGroupEnd

Section /o "Block future Steam update"
    SetOutPath "$INSTDIR\..\.."
    DetailPrint " // Block future update (appmanifest_377160.acf)"
    SetFileAttributes "appmanifest_377160.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Fallout4.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Fallout 4"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${lang_auto} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_auto}
            !insertmacro RadioButton ${lang_cn}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
