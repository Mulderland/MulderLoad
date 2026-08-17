!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dishonored, with:$\r$\n\
- Mission Stats (by AdM244)$\r$\n\
- Skippable Cutscenes (by FCH823)$\r$\n\
- Borderless fullscreen support (by jschneider170)$\r$\n\
- PS4 Textures (by TheEnmitrol)$\r$\n\
- PS4 Loading Screens (by THG327)$\r$\n\
- Disable crouch vignette (by FCH823)$\r$\n\
- Disable pickups glow (by FCH823)$\r$\n\
- FOV Hack (by Racer_S)$\r$\n\
- TFC Installer for UE2-UE3$\r$\n\
- MulderConfig to configure the pack + graphical tweaks$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
WARNING: TFC Installer is required for some included mods."

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-Mulderland.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Dishonored [Enhancement Pack]"

SectionGroup "Quality of Life"
    Section "Mission Stats (by AdM244)"
        SetOutPath "$INSTDIR\.MulderConfig\MissionStats\Binaries\Win32"

        !insertmacro DOWNLOAD_2 "https://github.com/adm244/Dishonored-MissionStats/releases/download/v1.1_hotfix/missionstats_v1.1_hotfix.zip" \
                                "https://www.nexusmods.com/dishonored/mods/17?tab=files&file_id=140" \
                                "missionstats_v1.1_hotfix.zip" \
                                "d23f4b3746790de6d607f0d1683fb7ba34d61a73"

        !insertmacro NSISUNZ_EXTRACT "missionstats_v1.1_hotfix.zip" ".\" "AUTO_DELETE"
        AddSize 137
    SectionEnd

    Section "Skippable Cutscenes (by FCH823)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/127?tab=files&file_id=262" \
                                "Skippable Cutscenes.zip" \
                                "34f98d9fff3d47a3d0ac0a2fa0fbc71ef77968bf"

        !insertmacro NSISUNZ_EXTRACT "Skippable Cutscenes.zip" ".\" "AUTO_DELETE"
        Rename "Skippable Cutscenes v1.0" "01 - Skippable Cutscenes v1.0"
        AddSize 1245
    SectionEnd
SectionGroupEnd

SectionGroup /e "Graphic enhancements"
    Section "Borderless support (by jschneider170)"
        SetOutPath "$INSTDIR\.MulderConfig\BorderlessFullscreen\Binaries\Win32"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/379?tab=files&file_id=400" \
                                "DishonoredBorderless.zip" \
                                "80a8a3f82688316651b76e05a0c6664f3a0e9af3"

        !insertmacro NSISUNZ_EXTRACT "DishonoredBorderless.zip" ".\" "AUTO_DELETE"
        AddSize 86
    SectionEnd

    Section
        !insertmacro 7Z_GET
    SectionEnd

    Section "PS4 Textures (by TheEnmitrol)"
        # Texture Pack
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/372?tab=files&file_id=381" \
                                "Definitive Edition Asset Pack MOD.rar" \
                                "8b5739b2a162c954d1f3e34437023957c456c746"

        !insertmacro 7Z_EXTRACT "Definitive Edition Asset Pack MOD.rar" ".\" "AUTO_DELETE"
        AddSize 1692834
        Rename "Base Game" "04 - Definitive Edition Asset Pack v1.1 (Base)"
        Rename "DLC5" "05 - Definitive Edition Asset Pack v1.1 (DLC5)"
        Rename "DLC6" "06 - Definitive Edition Asset Pack v1.1 (DLC6)"
        Rename "DLC7" "07 - Definitive Edition Asset Pack v1.1 (DLC7)"

        # 4GB Patch
        SetOutPath "$INSTDIR\Binaries\Win32"

        !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/tools/ntcore/4gb_patch.zip" \
                        "https://ntcore.com/files/4gb_patch.zip" \
                        "4gb_patch.zip" \
                        "c8b0d61937cb54fc8215124c0f737a1d29479c97"

        !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"

        ExecWait '4gb_patch.exe Dishonored.exe' $0
        Delete "4gb_patch.exe"
        AddSize 17619
    SectionEnd

    Section "PS4 Loading Screens (by THG327)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/195?tab=files&file_id=371" \
                                "Dishonored FullHD Loading.zip" \
                                "784043389a43128d9fc95b292a94a156d4ce152f"

        !insertmacro 7Z_EXTRACT "Dishonored FullHD Loading.zip" "$INSTDIR" "AUTO_DELETE" # NSISUNZ_EXTRACT_ONE doesn't work for an unknown reason
        AddSize 468949
    SectionEnd

    Section
        !insertmacro 7Z_REMOVE
    SectionEnd

    Section "Disable crouch vignette (by FCH823)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/131?tab=files&file_id=270" \
                                "Disable crouch vignette.zip" \
                                "e698d5b0435b9edac9b59b854b091164a914681a"

        !insertmacro NSISUNZ_EXTRACT "Disable crouch vignette.zip" ".\" "AUTO_DELETE"
        Rename "Disable crouch vignette v1.0" "02 - Disable crouch vignette v1.0"
        AddSize 722
    SectionEnd

    Section "Disable pickups glow (by FCH823)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/dishonored/mods/105?tab=files&file_id=338" \
                                "Disable pickup glow.zip" \
                                "514af0a5976d538ca2196598082bfb017e0efbfd"

        !insertmacro NSISUNZ_EXTRACT "Disable pickup glow.zip" ".\" "AUTO_DELETE"
        Rename "Disable pickup glow v1.3" "03 - Disable pickup glow v1.3"
        AddSize 4715
    SectionEnd

    Section "FOV Hack (by Racer_S)"
        SetOutPath "$INSTDIR\.MulderConfig\FOVHack\Binaries\Win32"

        !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/2328-dishonored-fov-hack/" \
                                "dishonoredfov10.zip" \
                                "0ceaa2e02893366822efb2be11f6850c2e1bc76d"

        !insertmacro NSISUNZ_EXTRACT "dishonoredfov10.zip" ".\" "AUTO_DELETE"
        AddSize 75
    SectionEnd
SectionGroupEnd

Section "TFC Installer for UE2-UE3"
    SetOutPath "$INSTDIR"
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/site/mods/588?tab=files&file_id=8694" \
                            "TFC Installer.zip" \
                            "dae642032aa401fbf439ac6a11f53161e6fe6a0e"
    !insertmacro NSISUNZ_EXTRACT "TFC Installer.zip" ".\" "AUTO_DELETE"
    AddSize 24576

    SetOutPath "$INSTDIR\TFCInstaller\redist"
    !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/6.0.36/windowsdesktop-runtime-6.0.36-win-x64.exe" \
                            "https://cdn.mulderload.eu/redistributables/microsoft/dotnet/windowsdesktop-runtime-6.0.36-win-x64.exe" \
                            "windowsdesktop-runtime-6.0.36-win-x64.exe" \
                            "c290c59e58f6629f0d0fa66b05ee740079b6ccda"
    AddSize 56036
SectionEnd

Section "MulderConfig (latest)"
    # MulderConfig
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"

    # End
    RMDir /r "$INSTDIR\@mulderload"
    File /oname=README-Mulderland.txt resources\README.txt
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Dishonored.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Dishonored\Binaries\Win32"
    StrCpy $SELECT_RELATIVE_INSTDIR "..\.."
FunctionEnd
