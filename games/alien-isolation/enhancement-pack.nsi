!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Alien Isolation, including:$\r$\n\
- Alias-Isolation (better anti-aliasing, by RyanJGray)$\r$\n\
- Alien Isolation Overhaul V2 (by Bay)$\r$\n\
- Enhanced Graphics Menu Options (by BUR7N)$\r$\n\
- Mouse Fix (by lukeman3000)$\r$\n\
- Ultimate ASI Loader (by ThirteenAG)$\r$\n\
- Upscaled Textures (by ju5tA1ex)$\r$\n\
- SkipSaveConfirmationDialog (by ThirteenAG)$\r$\n\
$\r$\n\
Most enhancements are configurable via MulderConfig, which also adds the ability to disable lens flare and skip the intro videos.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Alien: Isolation [Enhancement Pack]"

SectionGroup /e "Improvements configurable via MulderConfig"
    Section "AliasIsolation (by RyanJGray)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\AliasIsolation"

        !insertmacro DOWNLOAD_2 "https://github.com/aliasIsolation/aliasIsolation/releases/download/v1.2.0/AliasIsolation-v1.2.0.7z" \
                                "https://cdn.mulderload.eu/games/alien-isolation/impr_gfx/AliasIsolation-v1.2.0.7z" \
                                "AliasIsolation.7z" \
                                "1ca067b0e60531223746e1bda88fd38e7d2091b4"

        !insertmacro NSIS7Z_EXTRACT "AliasIsolation.7z" ".\" "AUTO_DELETE"
        Delete "d3d11.dll"
        AddSize 770

        RMDir /r "$INSTDIR\.MulderConfig\AliasIsolation\scripts"
        CreateDirectory "$INSTDIR\.MulderConfig\AliasIsolation\scripts"
        Rename "mods" "scripts\mods"
        Rename "aliasIsolation.asi" "scripts\aliasIsolation.asi"
    SectionEnd

    Section "Clean HUD (by DJ Shokwave)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\CleanHUD"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/102?tab=files&file_id=767" \
                                "CleanHUD All-In-One-102-1-0-1737636782.zip" \
                                "4f3ff1e1f2d954ec48f6f0a8f37a4a7bd17df93a"

        !insertmacro NSISUNZ_EXTRACT "CleanHUD All-In-One-102-1-0-1737636782.zip" ".\" "AUTO_DELETE"
        AddSize 68557

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/102?tab=files&file_id=768" \
                                "No Mo Orange Glo-102-1-0-1737636900.zip" \
                                "ad71f95898dbcd343d181fd67e8f07c809fac2cf"

        RMDir /r "No Mo Orange Glo"
        !insertmacro NSISUNZ_EXTRACT "No Mo Orange Glo-102-1-0-1737636900.zip" ".\" "AUTO_DELETE"
        AddSize 3
        CreateDirectory "$INSTDIR\.MulderConfig\CleanHUD\No Mo Orange Glo\DATA\UI"
        Rename "No Mo Orange Glo\SELECTIONOVERLAYPARAMS.BIN" "No Mo Orange Glo\DATA\UI\SELECTIONOVERLAYPARAMS.BIN"
    SectionEnd

    Section "Enhanced Graphics Menu Options (by BUR7N)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\EnhancedGraphicsMenuOptions\DATA"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/34?tab=files&file_id=123" \
                            "Enhanced_Graphics_Alternate.rar" \
                            "2ff3a3f45aa1ab780765a30b343427ce22375b21"

        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Enhanced_Graphics_Alternate.rar" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
        AddSize 25
    SectionEnd

    Section "Mouse Fix (by lukeman3000)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\MouseFix\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/lukeman3000/alien-isolation-mouse-fix/releases/download/v2.0.0/AlienIsolationMouseFix_v2.0.0.zip" \
                                "https://www.nexusmods.com/alienisolation/mods/173?tab=files&file_id=1005" \
                                "MouseFix.zip" \
                                "3f59310773eb29e73e9865671217e9f782fd0b25abd0fc022a9de6e769b5bb6a"

        !insertmacro NSISUNZ_EXTRACT "MouseFix.zip" ".\" "AUTO_DELETE"
        Delete "d3d11.dll"
        AddSize 179
    SectionEnd

    Section "No Center Dot (by IkarosTRB)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\NoCenterDot\DATA"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/44?tab=files&file_id=149" \
                                "No Center Dot-44-1-0-1688633976.7z" \
                                "b1118194ebc5cbf6baaf72999eb4051e3f1ca490"

        !insertmacro NSIS7Z_EXTRACT "No Center Dot-44-1-0-1688633976.7z" ".\" "AUTO_DELETE"
        AddSize 17111
    SectionEnd

    Section "Ultimate ASI Loader (by ThirteenAG)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\UltimateASILoader"

        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v9.7.4/Ultimate-ASI-Loader.zip" \
                                "https://cdn.mulderload.eu/tools/ultimate-asi-loader/Ultimate-ASI-Loader-v9.7.4.zip" \
                                "Ultimate-ASI-Loader.zip" \
                                "952cebfc30d525afc2bdbaca954329d405ded3aa688a83027354dae14dfd5c5f"

        !insertmacro NSISUNZ_EXTRACT "Ultimate-ASI-Loader.zip" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "dinput8.dll" "d3d11.dll"
        AddSize 5292
    SectionEnd

    Section "Ultrawide Subtitle Fix (by goobfer)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/64?tab=files&file_id=258" \
                                "AI_UltrawideSubtitleFix-64-1-0-1715579680.zip" \
                                "0b013b201842833017c0b4f1467f7926d390b3e3"

        RMDir /r "UltrawideSubtitleFix"
        !insertmacro NSISUNZ_EXTRACT "AI_UltrawideSubtitleFix-64-1-0-1715579680.zip" ".\" "AUTO_DELETE"
        Rename "AI_UltrawideSubtitleFix" "UltrawideSubtitleFix"
    SectionEnd

    Section "SkipSaveConfirmationDialog (by ThirteenAG)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\SkipSaveConfirmationDialog\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/AlienIsolation.SkipSaveConfirmationDialog/releases/download/AlienIsolation.SkipSaveConfirmationDialog-v1.4/AlienIsolation.SkipSaveConfirmationDialog.zip" \
                                "https://cdn.mulderload.eu/games/alien-isolation/mod/AlienIsolation.SkipSaveConfirmationDialog-v1.4.zip"  \
                                "SkipSaveConfirmationDialog.zip" \
                                "cc20a5043b952bbcc5aaf30b4d6d6694fa1b79bf96c5b866f5a22ff6ac240541"

        !insertmacro NSISUNZ_EXTRACT_ONE "SkipSaveConfirmationDialog.zip" ".\" "AlienIsolation.SkipSaveConfirmationDialog.asi" "AUTO_DELETE"
        AddSize 85
    SectionEnd

    Section
        CreateDirectory "$INSTDIR\.MulderConfig\Backup\DATA\UI"
        ${IfNot} ${FileExists} "$INSTDIR\.MulderConfig\Backup\DATA\UI.PAK"
            CopyFiles /SILENT "$INSTDIR\DATA\UI.PAK" "$INSTDIR\.MulderConfig\Backup\DATA\UI.PAK" 17111
        ${EndIf}
        ${IfNot} ${FileExists} "$INSTDIR\.MulderConfig\Backup\DATA\UI\SELECTIONOVERLAYPARAMS.BIN"
            CopyFiles /SILENT "$INSTDIR\DATA\UI\SELECTIONOVERLAYPARAMS.BIN" "$INSTDIR\.MulderConfig\Backup\DATA\UI\SELECTIONOVERLAYPARAMS.BIN" 17111
        ${EndIf}
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
    SectionEnd
SectionGroupEnd

Section /o "[GFX] 2x Upscaled Textures (by ju5tA1ex)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/alien-isolation/impr_gfx/Upscaled-51-4-1708527061.7z.001" \
                                "Upscaled-51-4-1708527061.7z.001" \
                                "c6b0adb6c08688aeb8cb6ace0d03f3e2cd3bed7b" \
                                16

    !insertmacro NSIS7Z_EXTRACT "Upscaled-51-4-1708527061.7z.001" ".\" ""
    !insertmacro DELETE_RANGE "Upscaled-51-4-1708527061.7z.001" 16
    AddSize 4179933
SectionEnd

Section /o "[MOD] Overhaul V2 with footsteps (by Bay)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/alien-isolation/mod/Bay's%20Alien%20Isolation%20Overhaul%20V2.2%20with%20Footsteps-16-2-2-1622338699.zip" \
                            "BaysAlienIsolationOverhaulV2.zip" \
                            "060fbd5dca4d15865f52ce0c4b230a006b26743a"

    !insertmacro NSISUNZ_EXTRACT "BaysAlienIsolationOverhaulV2.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\Baylor's Alien Isolation overhaul v2 w footsteps" "$INSTDIR"
SectionEnd

Section
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "AI.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Alien Isolation"
    StrCpy $SELECT_STEAM_FOLDER "Alien Isolation"
FunctionEnd
