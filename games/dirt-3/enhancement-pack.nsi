!ifndef BYOF_INSTALLER_NSI
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Dirt 3. It includes:$\r$\n\
    - Graphics Remake Mod 2018 (by Hulk)$\r$\n\
    - Extreme Graphics Settings (by Talal26)$\r$\n\
    - Upscaled Cars Textures (by Talal26)$\r$\n\
    - FOV Change Software (by dengo)$\r$\n\
    - Super Fast Menus Mod (by Martan)$\r$\n\
    - Intro Skip (by Garrett)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to Talal26 and Hulk!"

    !define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
    !define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
    !include "..\..\includes\templates\SelectTemplate.nsh"

    Name "Dirt 3 [Enhancement Pack]"
!endif

Section "Graphics Remake Mod 2018 v1.3 (by Hulk)"
    AddSize 33690
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.moddb.com/addons/start/132448" \
                            "https://cdn1.mulderload.eu/games/dirt-3/Hulks_DiRT_3_Remake_Mod_v1.3.zip" \
                            "Hulks_DiRT_3_Remake_Mod_v1.3.zip" "f51011b7a1b424944ffe996961e33fde"
    !insertmacro NSISUNZ_EXTRACT "Hulks_DiRT_3_Remake_Mod_v1.3.zip" ".\" "AUTO_DELETE"

    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\cars" "$INSTDIR\cars"
    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\characters" "$INSTDIR\characters"
    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\effects" "$INSTDIR\effects"
    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\postprocess" "$INSTDIR\postprocess"
    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\tracks" "$INSTDIR\tracks"

    # Rename Motion Blur Mod (to allow switch)
    Rename "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\Motion Blur OFF\postprocess\effects.xml" "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\Motion Blur OFF\postprocess\_effects.mod.bak"
    Rename "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\Motion Blur OFF\postprocess\palettes.pssg" "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\Motion Blur OFF\postprocess\_palettes.mod.bak"

    # Apply
    !insertmacro FOLDER_MERGE "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3\PC\Motion Blur OFF\postprocess" "$INSTDIR\postprocess"
    RMDIR /r "$INSTDIR\Hulks DiRT 3 Remake Mod v1.3"

    # Backup original Motion Blur (to allow switch)
    CopyFiles "$INSTDIR\postprocess\effects.xml" "$INSTDIR\postprocess\_effects.ori.bak" 260
    CopyFiles "$INSTDIR\postprocess\palettes.pssg" "$INSTDIR\postprocess\_palettes.ori.bak" 372
SectionEnd

Section "Extreme Graphics Settings (by Talal26)"
    SetOutPath "$INSTDIR\system"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dirt3/mods/10?tab=files&file_id=15" \
                            "DiRT 3 Extreme Graphics Settings.zip" "5954ce12c92cab6c4514fda2c51ab03c480252b9"
    !insertmacro NSISUNZ_EXTRACT_ONE "DiRT 3 Extreme Graphics Settings.zip" ".\" "modded file\hardware_settings_options.xml" "AUTO_DELETE"
SectionEnd

Section "FOV Change Software (by dengo)"
    AddSize 749
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/dirt-3/Dirt3FovChange-v0.2.zip" \
                            "https://www.mediafire.com/file_premium/c09cg9fn8gpo08t/Dirt3FovChange-v0.2.zip/file" \
                            "Dirt3FovChange.zip" "7f7ae70c385f5b30cb97b234c467ac294699e16b"
    !insertmacro NSISUNZ_EXTRACT "Dirt3FovChange.zip" ".\" "AUTO_DELETE"
SectionEnd

Section /o "Upscaled Cars Textures (by Talal26)"
    AddSize 20835205
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_RANGE_1 "https://cdn1.mulderload.eu/games/dirt-3/DiRT%203%20Upscaled%20Liveries%20Mod%201.0%20%5BRepack-MLD%5D.001" "DiRT 3 Upscaled Liveries Mod 1.0 [Repack-MLD].001" "d9842cb0bbcc11227b74ce4e8e05a00b89312572" 15
    !insertmacro NSIS7Z_EXTRACT "DiRT 3 Upscaled Liveries Mod 1.0 [Repack-MLD].001" ".\" ""
    !insertmacro DELETE_RANGE "DiRT 3 Upscaled Liveries Mod 1.0 [Repack-MLD].001" 15
SectionEnd

SectionGroup /e "MulderConfig"
    !ifdef BYOF_INSTALLER_NSI
        !insertmacro MULDERCONFIG_SECTIONS "$INSTDIR" "resources\byof-installer"
    !else
        !insertmacro MULDERCONFIG_SECTIONS "$INSTDIR" "resources\enhancement-pack"
    !endif

    Section "Super Fast Menus Mod (by Martan)"
        AddSize 42
        SetOutPath "$INSTDIR\@mulderload\superfastmenus"

        # Download modded xml
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/36kcxc2ad4wt5ex/DiRT3CE_SuperFastMenus_mod.zip/file" \
                                "https://cdn1.mulderload.eu/games/dirt-3/DiRT3CE_SuperFastMenus_mod.zip" \
                                "DiRT3CE_SuperFastMenus_mod.zip" "5e817b1c8793b2a4e0161883d00973ef89fc539d"
        !insertmacro NSISUNZ_EXTRACT "DiRT3CE_SuperFastMenus_mod.zip" ".\" "AUTO_DELETE"

        # Rename modded xml (to allow switch)
        !insertmacro FORCE_RENAME "frontend\durations.xml" "frontend\_durations.mod.bak"
        !insertmacro FORCE_RENAME "frontend\caranims\fe_animation_times.xml" "frontend\caranims\_fe_animation_times.mod.bak"

        # Apply
        SetOutPath "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\superfastmenus\frontend" "$INSTDIR\frontend"
        RMDir /r "$INSTDIR\@mulderload\superfastmenus"

        # Backup original xml (to allow switch)
        CopyFiles "$INSTDIR\frontend\durations.xml" "$INSTDIR\frontend\_durations.ori.bak" 42
        CopyFiles "$INSTDIR\frontend\caranims\fe_animation_times.xml" "$INSTDIR\frontend\caranims\_fe_animation_times.ori.bak" 4
    SectionEnd

    Section "Intro Skip (by Garrett)"
        AddSize 4
        SetOutPath "$INSTDIR\@mulderload\introskip"

        # Download modded videos
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/w1ehcxk0m7t01n7/dirt3_nointro.zip/file" \
                                "https://cdn1.mulderload.eu/games/dirt-3/dirt3_nointro.zip" \
                                "dirt3_nointro.zip" "9981cb1d0fa5419afda3822ed47e99d17aba2daf"
        !insertmacro NSISUNZ_EXTRACT "dirt3_nointro.zip" ".\" "AUTO_DELETE"

        # Rename modded videos (to allow switch)
        !insertmacro FORCE_RENAME "video\AMD_sting.bik" "video\_AMD_sting.mod.bak"
        !insertmacro FORCE_RENAME "video\sting.bik" "video\_sting.mod.bak"

        # Apply
        SetOutPath "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\introskip" "$INSTDIR"

        # Backup original videos (to allow switch)
        CopyFiles "$INSTDIR\video\AMD_sting.bik" "$INSTDIR\video\_AMD_sting.ori.bak" 11846
        CopyFiles "$INSTDIR\video\sting.bik" "$INSTDIR\video\_sting.ori.bak" 3684
    SectionEnd
SectionGroupEnd

Function .onInit
    !ifndef BYOF_INSTALLER_NSI
        StrCpy $SELECT_FILENAME "dirt3_game.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\DiRT 3 Complete Edition"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
    !endif
    !insertmacro MULDERCONFIG_ONINIT
FunctionEnd
