!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (1.11.240, August 26). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language and your installed DLCs, then applies matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
This LITE edition was built for Moddb, works fully offline, but can only downgrade to v1.11.221 (Anniversary, May 2026)$\r$\n\
$\r$\n\
If you wish to downgrade to an earlier version (v1.11.191, v1.10.984 or v1.10.163), you can find the FULL version of this downgrader on my website: www.mulderland.com"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Buy me a coffee? :)"
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenKofi"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader Lite]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.240) to" version
    Section /o "v1.10.163 (Pre-Next-Gen)"
        SectionIn RO
    SectionEnd

    Section /o "v1.10.984 (Next-Gen Update 2)"
        SectionIn RO
    SectionEnd

    Section /o "v1.11.191 (Anniversary, December 2025)"
        SectionIn RO
    SectionEnd

    Section "v1.11.221 (Anniversary, May 2026)"
        AddSize 28672
        SetOutPath "$INSTDIR"

        DetailPrint " // Copying downgrade 377162 (Base game)"
        File /r "resources-downgrader-lite\377162\*.*"

        DetailPrint " // Copying downgrade 377163 (Base game)"
        File /r "resources-downgrader-lite\377163\*.*"

        ${If} $DLC_Automatron == "yes"
            ${If} $Game_Language == "Japanese"
                DetailPrint " // Copying downgrade 404091 (Automatron DLC, Japanese)"
                File /r "resources-downgrader-lite\404091\*.*"
            ${ElseIf} $Game_Language == "English"
                DetailPrint " // Copying downgrade 435871 (Automatron DLC, English)"
                File /r "resources-downgrader-lite\435871\*.*"
            ${ElseIf} $Game_Language == "French"
                DetailPrint " // Copying downgrade 435872 (Automatron DLC, French)"
                File /r "resources-downgrader-lite\435872\*.*"
            ${ElseIf} $Game_Language == "German"
                DetailPrint " // Copying downgrade 435873 (Automatron DLC, German)"
                File /r "resources-downgrader-lite\435873\*.*"
            ${ElseIf} $Game_Language == "Italian"
                DetailPrint " // Copying downgrade 435874 (Automatron DLC, Italian)"
                File /r "resources-downgrader-lite\435874\*.*"
            ${ElseIf} $Game_Language == "Spanish"
                DetailPrint " // Copying downgrade 435875 (Automatron DLC, Spanish)"
                File /r "resources-downgrader-lite\435875\*.*"
            ${ElseIf} $Game_Language == "Polish"
                DetailPrint " // Copying downgrade 435876 (Automatron DLC, Polish)"
                File /r "resources-downgrader-lite\435876\*.*"
            ${ElseIf} $Game_Language == "Russian"
                DetailPrint " // Copying downgrade 435877 (Automatron DLC, Russian)"
                File /r "resources-downgrader-lite\435877\*.*"
            ${ElseIf} $Game_Language == "Portuguese (Brazil)"
                DetailPrint " // Copying downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                File /r "resources-downgrader-lite\435878\*.*"
            ${ElseIf} $Game_Language == "Chinese (Traditional)"
                DetailPrint " // Copying downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                File /r "resources-downgrader-lite\435879\*.*"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Copying downgrade 435880 (Wasteland Workshop DLC)"
            File /r "resources-downgrader-lite\435880\*.*"
        ${EndIf}

        CreateDirectory "$INSTDIR\@mulderload\xdelta3"
        File "/oname=$INSTDIR\@mulderload\xdelta3\xdelta3.exe" "resources-downgrader-lite\xdelta3-3.0.11-x86_64.exe"
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
    StrCpy $SELECT_STEAM_FOLDER "Fallout 4"
FunctionEnd
