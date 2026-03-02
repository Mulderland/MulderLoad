!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Doom 3. It includes:$\r$\n\
- dhewm3 (source port)$\r$\n\
- dhewm3 Wide Patch for GUI / HUD$\r$\n\
- The Lost Mission DLC port (requires Resurrection of Evil)$\r$\n\
- Texture Pack x4 (by GrowlingGuy41)$\r$\n\
- MulderConfig$\r$\n\
$\r$\n\
NOTE: The Wide Patch will be installed but $\"disabled$\" by default, as it breaks existing save games. You should enable it only for new runs. You can enable it easily and individually (base game, RoE, LM) via MulderConfig.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to the dhewm3 team && GrowlingGuy41!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Doom 3 [Enhancement Pack]"

SectionGroup /e "Dhewm3 v1.5.5 RC2 + GUI Wide Patch"
    Section
        AddSize 51200
        SetOutPath "$INSTDIR"

        # Install dhewm3
        !insertmacro DOWNLOAD_2 "https://github.com/dhewm/dhewm3/releases/download/1.5.5_RC2/dhewm3-1.5.5_RC2_win32.zip" \
                                "https://cdn2.mulderload.eu/g/doom-3/dhewm3-1.5.5_RC2_win32.zip" \
                                "dhewm3.zip" "dac89f84b9de5819dff5267c3ba8b186f27f57e8"
        !insertmacro NSISUNZ_EXTRACT "dhewm3.zip" ".\" "AUTO_DELETE"

        # Backup original executable, and make dhewm3 the default one (will be switchable via MulderConfig)
        !insertmacro FORCE_RENAME "Doom3.exe" "Doom3_o.exe"
        CopyFiles "$INSTDIR\dhewm3\dhewm3.exe" "$INSTDIR\dhewm3\doom3.exe" 15649

        # Merge dhewm3 in root folder
        !insertmacro FOLDER_MERGE "$INSTDIR\dhewm3" "$INSTDIR"
    SectionEnd

    Section
        AddSize 386
        SetOutPath "$INSTDIR"

        # Install dhewm3 Wide Patch
        !insertmacro DOWNLOAD_2 "https://github.com/dhewm/dhewm3/releases/download/1.5.5_RC2/dhewm3-wide-guis-v0.2.zip" \
                                "https://cdn2.mulderload.eu/g/doom-3/dhewm3-wide-guis-v0.2.zip" \
                                "dhewm3-wide-guis.zip" "80872ca06ef2df2f05c3d8efcd3a955592218502"
        !insertmacro NSISUNZ_EXTRACT "dhewm3-wide-guis.zip" ".\" "AUTO_DELETE"
        Delete "dhewm3-wide-guis\README.txt"

        # Disable by default as it breaks existing save games (will be switchable via MulderConfig)
        Rename "dhewm3-wide-guis\base\zWideGuis_D3.pk4" "dhewm3-wide-guis\base\_zWideGuis_D3.pk4.bak"
        Rename "dhewm3-wide-guis\d3xp\zWideGuis_RoE.pk4" "dhewm3-wide-guis\d3xp\_zWideGuis_RoE.pk4.bak"
        Rename "dhewm3-wide-guis\d3le\zWideGuis_LM.pk4" "dhewm3-wide-guis\d3le\_zWideGuis_LM.pk4.bak"

        # Merge dhewm3-wide-guis in root folder
        !insertmacro FOLDER_MERGE "dhewm3-wide-guis" "$INSTDIR"
        RMDir /r "$INSTDIR\dhewm3-wide-guis"
    SectionEnd

    Section "[DLC] The Lost Mission (require RoE)" lost_mission
        AddSize 324072
        SetOutPath "$INSTDIR\@mulderload\lost_mission"

        # https://www.moddb.com/mods/the-lost-mission/downloads/d3-lost-mission
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/182038" \
                                "https://cdn2.mulderload.eu/g/doom-3/Doom3_The_Lost_Mission_1.5.7.zip" \
                                "Doom3_The_Lost_Mission.zip" "dd8b80d4798b28fa97131748338135fb"
        !insertmacro NSISUNZ_EXTRACT "Doom3_The_Lost_Mission.zip" ".\" "AUTO_DELETE"
        CreateDirectory "$INSTDIR\d3le"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\lost_mission\d3le" "$INSTDIR\d3le"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\lost_mission\Extras\languages" "$INSTDIR\d3le"

        SetOutPath "$INSTDIR"
        RMDir /r "$INSTDIR\@mulderload\lost_mission"

        !insertmacro DOWNLOAD_2 "https://github.com/dhewm/dhewm3/releases/download/1.5.5_RC2/dhewm3-mods-1.5.5_RC2_win32.zip" \
                                "https://cdn2.mulderload.eu/g/doom-3/dhewm3-mods-1.5.5_RC2_win32.zip" \
                                "dhewm3-mods.zip" "6c6883655813e2a0d9c5a4795eab75bd5b7c5753"
        !insertmacro NSISUNZ_EXTRACT_ONE "dhewm3-mods.zip" ".\" "dhewm3-mods\d3le.dll" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section "Textures Pack x4 v1.1 (by GrowlingGuy41)"
    AddSize 6312428
    SetOutPath "$INSTDIR"

    # https://www.moddb.com/mods/gg41-doom3/downloads/x4-texture-upscale-for-doom-3-v11-roe
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/271929" \
                            "https://cdn2.mulderload.eu/g/doom-3/Doom3_GG41_textures_RoE.zip" \
                            "Doom3_GG41_textures_RoE.zip" "73e8e1cc90dce64b3f1fa743b131ce6e"
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "Doom3_GG41_textures_RoE.zip" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE
    RMDir /r "$INSTDIR\GG41"

    # Copy autoexec.cfg that includes configuration for Texture Pack
    File /oname=base\autoexec.cfg resources\autoexec.cfg
    CreateDirectory "$INSTDIR\d3xp"
    File /oname=d3xp\autoexec.cfg resources\autoexec.cfg
    CreateDirectory "$DOCUMENTS\My Games\dhewm3\base"
    File "/oname=$DOCUMENTS\My Games\dhewm3\base\autoexec.cfg" resources\autoexec.cfg
    CreateDirectory "$DOCUMENTS\My Games\dhewm3\d3xp"
    File "/oname=$DOCUMENTS\My Games\dhewm3\d3xp\autoexec.cfg" resources\autoexec.cfg
SectionEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/Mulderland/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
        File resources\MulderConfig.json
        File resources\MulderConfig.save.json
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.23 (x64)"
        SetOutPath "$INSTDIR"
        AddSize 100000

        !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.23/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "windowsdesktop-runtime-win-x64.exe" "0ecfc9a9dab72cb968576991ec34921719039d70"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Doom3.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Doom 3"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd

Function OnSelectedFile
    ${IfNot} ${FileExists} "$INSTDIR\d3xp\pak000.pk4"
        SectionSetFlags ${lost_mission} ${SF_RO}
        MessageBox MB_ICONINFORMATION "The DLC Resurection of Evil is not installed.$\r$\n$\r$\nThe Lost Mission will not be downloadable.$\r$\n$\r$\nIf you own it on Steam, download it and retry."
    ${Else}
        SectionSetFlags ${lost_mission} ${SF_SELECTED}
    ${EndIf}
FunctionEnd
