!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer can install $\r$\n- dhewm3 (source port) as doom3.exe$\r$\n- NoisyPumpkin's HUD/UI widescreen fix $\r$\n(WARNING: incompatible with existing saves, so install it only for new run)$\r$\n- GrowlingGuy41's Texture Pack x4$\r$\n- The Lost Mission DLC port (requires Resurrection of Evil installed)$\r$\n$\r$\nEnjoy this updated game !"
!include "..\..\templates\select_exe.nsh"

Name "Doom 3 [PATCHS]"

Section "Dhewm3 v1.5.4"
    SetOutPath $INSTDIR

    # Clean temp files
    Delete $TEMP\dhewm3.zip
    RMDir /r $TEMP\dhewm3

    # Download in temp directory then move, because we don't want the "dhewm3" subfolder from the archive
    !insertmacro Download https://github.com/dhewm/dhewm3/releases/download/1.5.4/dhewm3-1.5.4_win32.zip "$TEMP\dhewm3.zip"
    nsisunz::Unzip "$TEMP\dhewm3.zip" "$TEMP\dhewm3"
    !insertmacro MoveFolder "$TEMP\dhewm3\dhewm3" "$INSTDIR\" "*.*"

    # Clean temp files
    Delete $TEMP\dhewm3.zip
    RMDir /r $TEMP\dhewm3

    # Rename executable
    Rename "Doom3.exe" "Doom3_original.exe"
    Rename "dhewm3.exe" "Doom3.exe"
SectionEnd

Section /o "HUD/UI Fix (by NoisyPumpkin) - break existing saves"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/vvk9vdsxksu9atw/UNSTRECHED_HUD.zip/file "UNSTRECHED_HUD.zip"
    nsisunz::Unzip /noextractpath /file "zzzz_hud_base.pk4" "UNSTRECHED_HUD.zip" "base\"
    nsisunz::Unzip /noextractpath /file "zzzz_hud_xp.pk4" "UNSTRECHED_HUD.zip" "d3xp\"
    Delete "UNSTRECHED_HUD.zip"
SectionEnd

Section "Textures Pack x4 v1.1 (by GrowlingGuy41)"
    SetOutPath $INSTDIR

    !insertmacro DownloadRedirect https://redirect.mulderload.eu/moddb/271929 "Doom3_GG41_textures_RoE.zip"
    nsisunz::Unzip "Doom3_GG41_textures_RoE.zip" ".\"
    Delete "Doom3_GG41_textures_RoE.zip"
    RMDir /r "GG41\"

    # Backup autoexec.cfg if it exists
    Delete "base\autoexec.cfg.bak"
    IfFileExists "base\autoexec.cfg" +2
        Rename "base\autoexec.cfg" "base\autoexec.cfg.bak"

    # Download autoexec.cfg that includes configuration for Texture Pack
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/doom-3/autoexec.cfg "base\autoexec.cfg"
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/doom-3/autoexec.cfg "d3xp\autoexec.cfg"
SectionEnd

Section "[DLC] Lost Mission (require RoE installed)" lost_mission
    SetOutPath $INSTDIR

    IfFileExists "$INSTDIR\d3xp\pak000.pk4" roe_installed roe_missing
    roe_missing:
        MessageBox MB_OK "Lost Mission requires Resurrection of Evil (RoE) to be installed. Skipping installation of Lost Mission."
        Return

    roe_installed:
    # Clean temp files
    Delete "$TEMP\Doom3_The_Lost_Mission.zip"
    RMDir /r "$TEMP\Doom3_The_Lost_Mission"

    !insertmacro DownloadRedirect https://redirect.mulderload.eu/moddb/182038 "$TEMP\Doom3_The_Lost_Mission.zip"
    nsisunz::Unzip "$TEMP\Doom3_The_Lost_Mission.zip" "$TEMP\Doom3_The_Lost_Mission"
    !insertmacro MoveFolder "$TEMP\Doom3_The_Lost_Mission\d3le" "$INSTDIR\d3le" "*.*"
    !insertmacro MoveFolder "$TEMP\Doom3_The_Lost_Mission\Extras\languages" "$INSTDIR\d3le" "*.*"

    # Clean temp files
    Delete "$TEMP\Doom3_The_Lost_Mission.zip"
    RMDir /r "$TEMP\Doom3_The_Lost_Mission"

    !insertmacro Download https://github.com/dhewm/dhewm3/releases/download/1.5.4/dhewm3-mods-1.5.4_win32.zip "dhewm3-mods.zip"
    nsisunz::Unzip /noextractpath /file "dhewm3-mods\d3le.dll" "dhewm3-mods.zip" ".\"
    Delete "dhewm3-mods.zip"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Doom3.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Doom 3"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
