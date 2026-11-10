!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for CONTROL Resonant, which includes some graphics enhancements and quality of life mods, while keeping a vanilla experience. It includes:$\r$\n\
- Dynamic HUD (by SLEEP)$\r$\n\
- Head Size Slider v0.6 (by alexanderhawkins)$\r$\n\
- NoIntro Fix v0.2 (by Gametism)$\r$\n\
- PhotoMode (by kkyleeb21)$\r$\n\
- Ultrawide Fix v1.4.1 (by SLEEP)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "CONTROL Resonant [Enhancement Pack]"

SectionGroup "Required dependencies"
    Section "DLL Mod Loader v1.0.0 (by fame2gin)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/9?tab=files&file_id=10" \
                                "CONTROL_Resonant_loader 1.0.0 9 1.0.0 2026-09-24T19-19Z SEDl9mA5X.zip" \
                                "bc1085a9d457c4ab5008e8b80330c89a840934b6"

        !insertmacro NSISUNZ_EXTRACT "CONTROL_Resonant_loader 1.0.0 9 1.0.0 2026-09-24T19-19Z SEDl9mA5X.zip" ".\" "AUTO_DELETE"
        AddSize 56
        !insertmacro FORCE_RENAME "winmm.dll" "winmmHooked.dll"
    SectionEnd

    Section "Mod Settings Menu v1.7.2 (by kkyleeb21)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/35?tab=files&file_id=551" \
                                "ModMenu 1.7.2 35 1.7.2 2026-10-04T08-29Z pZRs05yxr.zip" \
                                "36d052d999df3f6d99f9490c5090f82ca4f644fc7bc5c93e50be1b177424fa87"

        !insertmacro NSISUNZ_EXTRACT "ModMenu 1.7.2 35 1.7.2 2026-10-04T08-29Z pZRs05yxr.zip" ".\" "AUTO_DELETE"
        AddSize 903
    SectionEnd

    Section "Ultimate ASI Loader v9.7.4 (by ThirteenAG)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v9.7.4/Ultimate-ASI-Loader_x64.zip" \
                                "https://cdn.mulderload.eu/tools/ultimate-asi-loader/Ultimate-ASI-Loader-v9.7.4_x64.zip" \
                                "Ultimate-ASI-Loader.zip" \
                                "8272d83b2692662098746f2d0ad0e2d85f3c8358ab1d63f75fbe835c2c8135fd"

        !insertmacro NSISUNZ_EXTRACT "Ultimate-ASI-Loader.zip" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "dinput8.dll" "winmm.dll"
        AddSize 5292
    SectionEnd
SectionGroupEnd

SectionGroup /e "Graphics Enhancements"
    Section "Head Size Slider v0.6 (by alexanderhawkins)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/47?tab=files&file_id=463" \
                                "Head Size Slider V0.6 for update 1.4.1 47 0.6 2026-10-02T20-39Z uKfjREn1j.zip" \
                                "f828b73b9dbfcae98b4d051929d9cbcc348f08f2dd2e6d0009645b10f5fcf89e"

        !insertmacro NSISUNZ_EXTRACT "Head Size Slider V0.6 for update 1.4.1 47 0.6 2026-10-02T20-39Z uKfjREn1j.zip" ".\" "AUTO_DELETE"
        AddSize 3063
    SectionEnd

    Section /o "Ultrawide Fix v1.4.1 (by SLEEP)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/11?tab=files&file_id=958" \
                                "UltrawideFix - F2G DLL Mod Loader 11 1.4.1 2026-10-23T01-42Z VJWqSZNGd.zip" \
                                "457b46b2ff464adb6e3ad9fcd570424b8a1e50c01f5bc3d5d5e7815867c5a500"

        !insertmacro NSISUNZ_EXTRACT "UltrawideFix - F2G DLL Mod Loader 11 1.4.1 2026-10-23T01-42Z VJWqSZNGd.zip" ".\" "AUTO_DELETE"
        AddSize 214
    SectionEnd
SectionGroupEnd

Section "Dynamic HUD v1.11.3 (by SLEEP)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/28?tab=files&file_id=960" \
                            "Dynamic HUD - F2G 28 1.11.3 2026-10-23T01-45Z OPICYtUHD.zip" \
                            "9e6a204d6a7b4e5f602c74616fc0038953f2511e3ce1ca9fe351a9e0b545a732"

    !insertmacro NSISUNZ_EXTRACT "Dynamic HUD - F2G 28 1.11.3 2026-10-23T01-45Z OPICYtUHD.zip" ".\" "AUTO_DELETE"
    AddSize 354
SectionEnd

Section
    # Remove outdated MapFusion v1.2.2 of the previous Enhancement Pack
    ${If} ${FileExists} "$INSTDIR\crmods\MapFusion\mapfusion.menu.json"
        !insertmacro FILE_HASH_EQUALS "$INSTDIR\crmods\MapFusion\mapfusion.menu.json" "5445938ea054816f3b3278fac4ac8cdde91640df" $0
        ${If} $0 == 1
            RMDir /r "$INSTDIR\crmods\MapFusion"
        ${EndIf}
    ${EndIf}
SectionEnd

Section /o "No-Intro v0.4 (by Gametism)"
    SetOutPath "$INSTDIR\scripts"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/1?tab=files&file_id=569" \
                            "CRNo-IntroFix-v.0.4 1 0.4 2026-10-04T13-23Z Lb8AWKtmY.zip" \
                            "43aaef45d94b845d303382daf8fcda52b6b2cd130493c919254354e18f0dd0b3"

    !insertmacro NSISUNZ_EXTRACT_ONE "CRNo-IntroFix-v.0.4 1 0.4 2026-10-04T13-23Z Lb8AWKtmY.zip" ".\" "ControlResonantNoIntro.asi" "AUTO_DELETE"
    AddSize 32
SectionEnd

Section "PhotoMode v2.4.3 (by kkyleeb21)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/62?tab=files&file_id=773" \
                            "PhotoMode 2.4.3 62 2.4.3 2026-10-11T03-29Z uKfjREnJG.zip" \
                            "eab3f7e47c9f58f377023c54cbc7c21600a15b13861f197fc3b907249a5055de"

    !insertmacro NSISUNZ_EXTRACT "PhotoMode 2.4.3 62 2.4.3 2026-10-11T03-29Z uKfjREnJG.zip" ".\" "AUTO_DELETE"
    AddSize 1430
SectionEnd

; Section "Better Camera - Zoom and FO (by PewCat)"
    ; https://www.nexusmods.com/controlresonant/mods/41
; SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "CONTROLResonant.exe"
    StrCpy $SELECT_STEAM_FOLDER "CONTROL Resonant"
FunctionEnd
