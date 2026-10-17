!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for CONTROL Resonant, which includes some graphics enhancements and quality of life mods, while keeping a vanilla experience. It includes:$\r$\n\
- Dynamic HUD (by SLEEP)$\r$\n\
- Head Size Slider v0.5 (by alexanderhawkins)$\r$\n\
- NoIntro Fix v0.2 (by Gametism)$\r$\n\
- PhotoMode (by kkyleeb21)$\r$\n\
- Ultrawide Fix v1.3.0 (by SLEEP)$\r$\n\
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

    Section "Mod Settings Menu v1.6.2 (by kkyleeb21)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/35?tab=files&file_id=311" \
                                "ModMenu 1.6.2 35 1.6.2 2026-10-01T08-49Z ofuzpD6Vb.zip" \
                                "b32e7df1dc06c3d5f74cd759bf6224f6511c838b"

        !insertmacro NSISUNZ_EXTRACT "ModMenu 1.6.2 35 1.6.2 2026-10-01T08-49Z ofuzpD6Vb.zip" ".\" "AUTO_DELETE"
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

        # Linux: make Wine load the ASI Loader instead of its builtin winmm.dll
        !insertmacro WINE_DLL_OVERRIDE_APP "CONTROLResonant.exe" "winmm" "native,builtin"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Graphics Enhancements"
    Section "Head Size Slider v0.6 (by alexanderhawkins)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/47?tab=files&file_id=330" \
                                "Head Size Slider V0.6 for update 1.4 47 0.6 2026-10-01T12-05Z yuomjSKAd.zip" \
                                "879b9243c174ab12583bbd3fead7f410f31116b5"

        !insertmacro NSISUNZ_EXTRACT "Head Size Slider V0.6 for update 1.4 47 0.6 2026-10-01T12-05Z yuomjSKAd.zip" ".\" "AUTO_DELETE"
        AddSize 3063
    SectionEnd

    Section /o "Ultrawide Fix v1.3.2 (by SLEEP)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/11?tab=files&file_id=322" \
                                "UltrawideFix - F2G DLL Mod Loader 11 1.3.2 2026-10-01T11-03Z Kn6R1ACvY.zip" \
                                "1c543f5e354e640c2f5e77976aac1dfdac82f00f"

        !insertmacro NSISUNZ_EXTRACT "UltrawideFix - F2G DLL Mod Loader 11 1.3.2 2026-10-01T11-03Z Kn6R1ACvY.zip" ".\" "AUTO_DELETE"
        AddSize 214
    SectionEnd
SectionGroupEnd

Section "Dynamic HUD v1.4.1 (by SLEEP)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/28?tab=files&file_id=258" \
                            "Dynamic HUD - F2G 28 1.4.1 2026-09-30T14-32Z SEDl9mA8n.zip" \
                            "009027ae8c951988fcf00a0eee6603b2c0ee46c5"

    !insertmacro NSISUNZ_EXTRACT "Dynamic HUD - F2G 28 1.4.1 2026-09-30T14-32Z SEDl9mA8n.zip" ".\" "AUTO_DELETE"
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

Section /o "No-Intro v0.2 (by Gametism)"
    SetOutPath "$INSTDIR\scripts"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/1?tab=files&file_id=26" \
                            "CRNo-IntroFix-v.0.2 1 0.2 2026-09-25T13-11Z g4qMrXDls.zip" \
                            "955dacee7c5476cb04c8b3bee8c6f7b2bb4424df"

    !insertmacro NSISUNZ_EXTRACT_ONE "CRNo-IntroFix-v.0.2 1 0.2 2026-09-25T13-11Z g4qMrXDls.zip" ".\" "ControlResonantNoIntro.asi" "AUTO_DELETE"
    AddSize 32
SectionEnd

Section "PhotoMode v2.3.3 (by kkyleeb21)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/controlresonant/mods/62?tab=files&file_id=320" \
                            "PhotoMode 2.3.3 62 2.3.3 2026-10-01T10-58Z SEDl9mARq.zip" \
                            "cc08c5dbc7556216e9da941ac2cc891f21c712a0"

    !insertmacro NSISUNZ_EXTRACT "PhotoMode 2.3.3 62 2.3.3 2026-10-01T10-58Z SEDl9mARq.zip" ".\" "AUTO_DELETE"
    AddSize 1430
SectionEnd

; Section "Better Camera - Zoom and FO (by PewCat)"
    ; https://www.nexusmods.com/controlresonant/mods/41
; SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "CONTROLResonant.exe"
    StrCpy $SELECT_STEAM_FOLDER "CONTROL Resonant"
FunctionEnd
