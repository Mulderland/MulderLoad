!define MUI_WELCOMEPAGE_TEXT "\
Note: Steam version v1.0.314 will be updated to Retail v1.0.320, fixing missing sounds && broken non-English menus.$\r$\n\
$\r$\n\
This Enhancement Pack also includes:$\r$\n\
- AI Upscaled Textures (Neural Origins)$\r$\n\
- Improved Shaders (Sikkmod)$\r$\n\
- DSOAL + OpenAL Soft (to restore EAX support)$\r$\n\
- MulderConfig, for intro skipping, FOV adjustment && more.$\r$\n\
- OLED Alternate HUD Colors (by Mulder)$\r$\n\
- Toggle HUD (by Akelaphobia)$\r$\n\
- Widescreen Fix (by ThirteenAG) repacked with DxWrapper$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
Special thanks to ThirteenAG && the Neural Origins modders!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Condemned: Criminal Origins [Enhancement Pack]"

Section "Update Steam v1.0.314 to 1.0.320 (by Mulder)" update_1_0_320
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/condemned-criminal-origins/update/Steam v1.0.314 to Retail v1.0.320 [MLD].7z" \
                            "Steam v1.0.314 to Retail v1.0.320 [MLD].7z" \
                            "b3966f2b69725c04caabd78ea3afd414500110e6"

    !insertmacro NSIS7Z_EXTRACT "Steam v1.0.314 to Retail v1.0.320 [MLD].7z" ".\" "AUTO_DELETE"

    !insertmacro XDELTA3_GET
    !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
    !insertmacro XDELTA3_REMOVE

    AddSize 75533
SectionEnd

SectionGroup /e "Improvements configurable via MulderConfig"
    Section "AI Upscaled Textures (Neural Origins 0.9)"
        # 4GB Patch
        SetOutPath "$INSTDIR"

        !insertmacro FILE_HASH_EQUALS "$INSTDIR\Condemned.exe" "0cea107671e577a4c7a338dd55502f286463acbe" $R0 ; 4GB Patched Retail Hash

        ${If} $R0 == 1
            DetailPrint "Condemned.exe is already LAA-enabled (4GB Patch)"
        ${Else}
            DetailPrint "Condemned.exe is not LAA-enabled. Applying 4GB Patch..."
            !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/tools/ntcore/4gb_patch.zip" \
                                    "https://ntcore.com/files/4gb_patch.zip" \
                                    "4gb_patch.zip" \
                                    "c8b0d61937cb54fc8215124c0f737a1d29479c97"

            !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"

            ExecShell "runas" "4gb_patch.exe" 'Condemned.exe'
            Delete "4gb_patch.exe"
        ${EndIf}

        # Neural Origins
        SetOutPath "$INSTDIR\.MulderConfig\NeuralOrigins\Game"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/neural-origins/downloads/09" \
                                "Data.zip" \
                                "7c80e43f9f252bf55fba7b9b37df5a5e"

        # Extract with 7z (NSIS built-in unzip can't handle files > 4Gb)
        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Data.zip" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
        AddSize 9785344

        RMDir /r "CondemnedN.Arch00"
        Rename "Data" "CondemnedN.Arch00"
    SectionEnd

    Section "DSOAL + OpenAL Soft (by kcat)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\DSOAL"

        !insertmacro DOWNLOAD_2 "https://github.com/kcat/dsoal/releases/download/archive/DSOAL_r693.zip" \
                                "https://cdn.mulderload.eu/tools/dsoal/DSOAL_r693.zip" \
                                "DSOAL.zip" \
                                "8cf38acb9ccd8a405b316bf4e7fd9fb05565234d9867f7ee4932e6ee0839ccbc"

        !insertmacro NSISUNZ_EXTRACT "DSOAL.zip" ".\" "AUTO_DELETE"
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\alsoft.ini" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\dsoal-aldrv.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\dsound.dll" "AUTO_DELETE"

        # Make dsound.dll override works
        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{47D4D946-62E8-11CF-93BC-444553540000}\InprocServer32" "" "dsound.dll"
        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{3901CC3F-84B5-4FA4-BA35-AA8172B8A09B}\InprocServer32" "" "dsound.dll"
    SectionEnd

    Section "Improved Shaders (Sikkmod v3)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\Sikkmod\Game"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/sikkmod-condemned-criminal-origins/downloads/sikkmod-v3-condemned-criminal-origins" \
                                "sikkmod_v3_condemned.zip" \
                                "0d542b5cd2c00ffb1918679c4baf6042"

        !insertmacro NSISUNZ_EXTRACT "sikkmod_v3_condemned.zip" ".\" "AUTO_DELETE"
        AddSize 407005

        RMDir /r "CondemnedS.Arch00"
        Rename "sikkmod" "CondemnedS.Arch00"
    SectionEnd

    Section "Language Files v1.0.320 (by Mulder)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\LanguageFiles"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/condemned-criminal-origins/update/Language Files v1.0.320 [MLD].7z" \
                                "Language Files v1.0.320 [MLD].7z" \
                                "4f6799c0e002dc41dba04576118d9be1bfb4cbee"

        !insertmacro NSIS7Z_EXTRACT "Language Files v1.0.320 [MLD].7z" ".\" "AUTO_DELETE"
        AddSize 2998
    SectionEnd

    Section "OLED Alternate HUD Colors (by Mulder)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\OLEDAlternateHUDColors\Game\CondemnedO.Arch00"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/condemned-criminal-origins/misc/OLED Alternate HUD Colors [MLD].7z" \
                                "OLED Alternate HUD Colors [MLD].7z" \
                                "70a186c18b08abc8bb4153c6770a7f61d023f033"

        !insertmacro NSIS7Z_EXTRACT "OLED Alternate HUD Colors [MLD].7z" ".\" "AUTO_DELETE"
        AddSize 769
    SectionEnd

    Section "Toggle HUD (by Akelaphobia)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\ToggleHUD"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/condemnedcriminalorigins/mods/3?tab=files&file_id=4" \
                                "Toggle HUD-3-1-00-1704098578.zip" \
                                "91035fa8f0bb4eaf9302b9f735ddd0c5b9486472"

        !insertmacro NSISUNZ_EXTRACT "Toggle HUD-3-1-00-1704098578.zip" ".\" "AUTO_DELETE"
        AddSize 3649
    SectionEnd

    Section "Widescreen Fix (by ThirteenAG) + DxWrapper"
        SectionIn RO
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/condemned/Condemned.WidescreenFix.zip" \
                                "https://cdn.mulderload.eu/games/condemned-criminal-origins/impr_gfx/Condemned.WidescreenFix-d7e4d48.zip" \
                                "Condemned.WidescreenFix.zip" \
                                "d7e4d487621898a9c97c60e05ed8877da6b06f2fcf7619513a40a3920eeb34e3"

        !insertmacro NSISUNZ_EXTRACT "Condemned.WidescreenFix.zip" ".\" "AUTO_DELETE"
        Delete "d3d9.dll"
        AddSize 10709

        # Use DxWrapper as alternative ASI Loader + Frame Limiter + Anti-Aliasing
        !insertmacro DOWNLOAD_2 "https://github.com/elishacloud/dxwrapper/releases/download/v1.8.8600.25/dx9.games.zip" \
                                "https://cdn.mulderload.eu/tools/dxwrapper/v1.8.8600.25/dx9.games.zip" \
                                "dx9.games.zip" \
                                "f390f3c61fef2c2b8a1221bfbacb2ca4864813b250924bf66a98e61d0de46d76"

        !insertmacro NSISUNZ_EXTRACT "dx9.games.zip" ".\" "AUTO_DELETE"
        !insertmacro FILE_STR_REPLACE "LoadPlugins                = 0" "LoadPlugins                = 1" 1 1 "$INSTDIR\dxwrapper.ini"
        !insertmacro FILE_STR_REPLACE "LoadFromScriptsOnly        = 0" "LoadFromScriptsOnly        = 1" 1 1 "$INSTDIR\dxwrapper.ini"
        !insertmacro FILE_STR_REPLACE "EnableD3d9Wrapper          = 0" "EnableD3d9Wrapper          = 1" 1 1 "$INSTDIR\dxwrapper.ini"
        AddSize 8348
    SectionEnd

    Section
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
    SectionEnd

    Section
        RMDir /r "$INSTDIR\@mulderload"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Condemned.exe"
    StrCpy $SELECT_STEAM_FOLDER "Condemned Criminal Origins"
FunctionEnd

Function OnSelectedFile
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Condemned.exe" "fa3c1c4a7b72e12fabac8875d2e5be02771db42c" $R0 ; Steam Hash
    ${If} $R0 == 1
        SectionSetFlags ${update_1_0_320} ${SF_SELECTED}|${SF_RO}
        MessageBox MB_ICONINFORMATION "Old Steam version detected (v1.0.314).$\r$\n$\r$\nUpdate to Retail v1.0.320 will be applied."
    ${Else}
        SectionSetFlags ${update_1_0_320} ${SF_RO}
        MessageBox MB_ICONINFORMATION "Latest version detected (v1.0.320).$\r$\n$\r$\nUpdate will be skipped."
    ${EndIf}
    Push 1
FunctionEnd
