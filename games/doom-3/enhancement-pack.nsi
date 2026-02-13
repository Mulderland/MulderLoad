!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Doom 3. It includes:$\r$\n\
- dhewm3 (source port)$\r$\n\
- HUD/UI widescreen fix (by NoisyPumpkin)$\r$\n\
- Texture Pack x4 (by GrowlingGuy41)$\r$\n\
- The Lost Mission DLC port (requires Resurrection of Evil installed)$\r$\n\
$\r$\n\
WARNING: the HUD/UI fix is incompatible with existing saves, so install it only for a new run.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the dhewm3 team for their amazing work!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Doom 3 [Enhancement Pack]"

Section "Dhewm3 v1.5.4"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/dhewm/dhewm3/releases/download/1.5.4/dhewm3-1.5.4_win32.zip" \
                            "https://cdn2.mulderload.eu/g/doom-3/dhewm3-1.5.4_win32.zip" \
                            "dhewm3.zip" "6bcf95625bd274a67c4b81a90f38956fba8f029c"
    !insertmacro NSISUNZ_EXTRACT "dhewm3.zip" ".\" "AUTO_DELETE"
    Rename "dhewm3\dhewm3.exe" "dhewm3\doom3.exe"
    !insertmacro FORCE_RENAME "Doom3.exe" "Doom3_o.exe"
    !insertmacro FOLDER_MERGE "$INSTDIR\dhewm3" "$INSTDIR"
SectionEnd

Section /o "HUD/UI Fix (by NoisyPumpkin) - break existing saves"
    SetOutPath "$INSTDIR"

    # https://www.moddb.com/addons/unstretched-hud-for-dhewm3
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/addons/start/237720" \
                            "https://cdn2.mulderload.eu/g/doom-3/UNSTRECHED_HUD.rar" \
                            "UNSTRECHED_HUD.rar" "6a50d27cfc0f9a1af1b3597e2ae7043b"
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT_ONE "UNSTRECHED_HUD.rar" ".\base\" "zzzz_hud_base.pk4" ""
    !insertmacro 7Z_EXTRACT_ONE "UNSTRECHED_HUD.rar" ".\d3xp\" "zzzz_hud_xp.pk4" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE
SectionEnd

Section "Textures Pack x4 v1.1 (by GrowlingGuy41)"
    SetOutPath "$INSTDIR"

    # https://www.moddb.com/mods/gg41-doom3/downloads/x4-texture-upscale-for-doom-3-v11-roe
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/271929" \
                            "https://cdn2.mulderload.eu/g/doom-3/Doom3_GG41_textures_RoE.zip" \
                            "Doom3_GG41_textures_RoE.zip" "73e8e1cc90dce64b3f1fa743b131ce6e"
    !insertmacro NSISUNZ_EXTRACT "Doom3_GG41_textures_RoE.zip" "$INSTDIR" "AUTO_DELETE"
    RMDir /r "$INSTDIR\GG41"

    !insertmacro FORCE_RENAME "$INSTDIR\base\autoexec.cfg" "$INSTDIR\base\autoexec.cfg.bak"
    !insertmacro FORCE_RENAME "$INSTDIR\d3xp\autoexec.cfg" "$INSTDIR\d3xp\autoexec.cfg.bak"

    # Copy autoexec.cfg that includes configuration for Texture Pack
    File /oname=base\autoexec.cfg resources\autoexec.cfg
    File /oname=d3xp\autoexec.cfg resources\autoexec.cfg
SectionEnd

Section "[DLC] Lost Mission (require RoE installed)" lost_mission
    IfFileExists "$INSTDIR\d3xp\pak000.pk4" roe_installed roe_missing
    roe_missing:
        MessageBox MB_OK "Lost Mission requires Resurrection of Evil (RoE) to be installed. Skipping installation of Lost Mission."
        Return
    roe_installed:
    SetOutPath "$INSTDIR\@mulderload\lost_mission"

    # https://www.moddb.com/mods/the-lost-mission/downloads/d3-lost-mission
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/182038" \
                            "https://cdn2.mulderload.eu/g/doom-3/Doom3_The_Lost_Mission_1.5.7.zip" \
                            "Doom3_The_Lost_Mission.zip" \
                            "dd8b80d4798b28fa97131748338135fb"
    !insertmacro NSISUNZ_EXTRACT "Doom3_The_Lost_Mission.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE ".\d3le" "$INSTDIR\d3le"
    !insertmacro FOLDER_MERGE ".\Extras\languages" "$INSTDIR\d3le"

    SetOutPath "$INSTDIR\@mulderload"
    RMDir /r "$INSTDIR\@mulderload\lost_mission"

    !insertmacro DOWNLOAD_2 "https://github.com/dhewm/dhewm3/releases/download/1.5.4/dhewm3-mods-1.5.4_win32.zip" \
                            "https://cdn2.mulderload.eu/g/doom-3/dhewm3-mods-1.5.4_win32.zip" \
                            "dhewm3-mods.zip" \
                            "c7126fbe8badd6076846b07f90ebbb0ae5020c72"
    !insertmacro NSISUNZ_EXTRACT_ONE "dhewm3-mods.zip" "$INSTDIR" "dhewm3-mods\d3le.dll" "AUTO_DELETE"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Doom3.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Doom 3"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
