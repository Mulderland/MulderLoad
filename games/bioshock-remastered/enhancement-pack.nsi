!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Bioshock Remastered, with:$\r$\n\
- Stability and bug fixes (by VoidCrownStudios)$\r$\n\
- Fullscreen cutscenes (by TopDollar86)$\r$\n\
- HQ sound for videos (by syrnyky)$\r$\n\
- HD Texture Pack (by FCH823)$\r$\n\
- Reflective water surfaces (by PhantomThief06)$\r$\n\
- Visual Fixes + AI Fix (by PhantomThief06)$\r$\n\
- TFC Installer for UE2-UE3$\r$\n\
- No Intro / No Splash (by Gametism)$\r$\n\
- Disable headbob (by FCH823)$\r$\n\
- DXVK$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
WARNING: TFC Installer is required for some included mods."

!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-Mulderland.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Bioshock Remastered [Enhancement Pack]"

Section "Stability & Bugs Fixes (by VoidCrownStudios)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/148?tab=files&file_id=606" \
                            "Stability_Patches_Bugs_Fixes.zip" \
                            "fddbab23e836d5cf67ec27cb21ae987a384c079b"

    !insertmacro NSISUNZ_EXTRACT "Stability_Patches_Bugs_Fixes.zip" ".\" "AUTO_DELETE"

    Delete "$INSTDIR\Export\INSTALL.txt"
    !insertmacro FOLDER_MERGE "$INSTDIR\Export" "$INSTDIR"

    Delete "$INSTDIR\ContentBaked\pc\System\ConfigINI.IBF"
    Delete "$APPDATA\BioshockHD\Bioshock\Bioshock.ini"
    Delete "$APPDATA\BioshockHD\Bioshock\User.ini"
SectionEnd

Section
    !insertmacro 7Z_GET
SectionEnd

SectionGroup "Cutscenes improvements"
    Section "Fullscreen cutscenes (by TopDollar86)"
        SetOutPath "$INSTDIR\@fullscreen_cutscenes"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/81?tab=files&file_id=375" \
                                "Fullscreen Cutscenes Mod.rar" \
                                "5b071dfa76c2f7e16066aa918a759d5013053f9a"

        !insertmacro 7Z_EXTRACT "Fullscreen Cutscenes Mod.rar" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "Fullscreen Cutscenes - Vanilla\HUDPC.swf" "$INSTDIR\ContentBaked\pc\FlashMovies"

        SetOutPath "$INSTDIR"
        RMDir /r "$INSTDIR\@fullscreen_cutscenes"
    SectionEnd

    Section "HQ Sound for Videos (by syrnyky)"
        AddSize 54879
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/4?tab=files&file_id=227" \
                                "01. BS1RM - HQ Sound For Video - MAIN.zip" \
                                "0de2c1fae7535ac3cf35b72db9cd90f5f91d001b"

        !insertmacro NSISUNZ_EXTRACT "01. BS1RM - HQ Sound For Video - MAIN.zip" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/4?tab=files&file_id=226" \
                                "02. BS1RM - HQ Sound For Video - LOCALIZATION.zip" \
                                "26bb6e9f09dfd955e37ee2980604aa258b366927"

        !insertmacro NSISUNZ_EXTRACT "02. BS1RM - HQ Sound For Video - LOCALIZATION.zip" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/4?tab=files&file_id=225" \
                                "03. BS1RM - HQ Sound For Video - Fixed Credits Videostream.zip" \
                                "ffaa6f8d444abfa452abb69a693d22493bae1986"

        !insertmacro NSISUNZ_EXTRACT "03. BS1RM - HQ Sound For Video - Fixed Credits Videostream.zip" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/4?tab=files&file_id=239" \
                                "04. BS1RM - HQ Sound For Video - Fixed HypnotiseBigDaddyPlasmidTraining.zip" \
                                "93421d9d378d99af9fb70c1773555bd08c76d0d1"

        !insertmacro NSISUNZ_EXTRACT "04. BS1RM - HQ Sound For Video - Fixed HypnotiseBigDaddyPlasmidTraining.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Graphical improvements"
    Section /o "HD Texture Pack (by FCH823)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/54?tab=files&file_id=314" \
                                "HD Texture pack.zip" \
                                "6e8aa075a2f8a38130679ebc80ebf2fc8dce8c28"

        !insertmacro 7Z_EXTRACT "HD Texture pack.zip" ".\" "AUTO_DELETE"
        AddSize 7440426

        Rename "HD Texture Pack v1.0" "01 - HD Texture Pack v1.0"
    SectionEnd

    Section "Reflective water surfaces (by PhantomThief06)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/80?tab=files&file_id=475" \
                                "Reflective Water Surface.zip" \
                                "b9aea34b1d5f6af290e2469fa768a308bc70263e"

        !insertmacro NSISUNZ_EXTRACT "Reflective Water Surface.zip" ".\03 - Reflective Water Surface v2.2" "AUTO_DELETE"
        AddSize 357
    SectionEnd

    Section "Visual Fixes + AI Fix (by PhantomThief06)"
        SetOutPath "$INSTDIR\TFC Mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/90?tab=files&file_id=585" \
                                "Visual Fixes.zip" \
                                "73fe6ffcee35159eb1a475005839c6bafe760b5d"

        !insertmacro NSISUNZ_EXTRACT "Visual Fixes.zip" ".\02 - Visual Fixes v2.3.1" "AUTO_DELETE"
        AddSize 733679
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

Section "No Intro / No Splash (by Gametism)"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/36?tab=files&file_id=601" \
                            "BSRNo-Intro-SplashFix.zip" \
                            "974b970bb2ea5dfd8fb9686a665c067321fdc87b"

    !insertmacro NSISUNZ_EXTRACT "BSRNo-Intro-SplashFix.zip" ".\" "AUTO_DELETE"
    RMDir /r "$INSTDIR\Optional Director's Commentary Removal"
    Delete "ReadMe.txt"
SectionEnd

Section "Disable headbob (by FCH823)"
    SetOutPath "$INSTDIR\TFC Mods"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/59?tab=files&file_id=321" \
                            "Disable headbob.zip" \
                            "360f769e0e17153ad76fc82b77c423cde24eebe4"

    !insertmacro NSISUNZ_EXTRACT "Disable headbob.zip" ".\" "AUTO_DELETE"
    AddSize 346

    Rename "Disable Headbob v1.0" "04 - Disable Headbob v1.0"
SectionEnd

Section "MulderConfig (latest)"
    # Minimal HUD
    SetOutPath "$INSTDIR\.MulderConfig\MinimalHUD\ContentBaked\pc\FlashMovies"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bioshock/mods/141?tab=files&file_id=592" \
                            "No Dot And Min Hud.rar" \
                            "d4fed80051af5afdce7008f71d06664ac28f7463"

    !insertmacro 7Z_EXTRACT_ONE "No Dot And Min Hud.rar" ".\" "no dot and min hud\HUDPC.swf" ""
    !insertmacro 7Z_EXTRACT_ONE "No Dot And Min Hud.rar" ".\" "no dot and min hud\sharedlibrary.swf" "AUTO_DELETE"

    # Create Backup
    CreateDirectory "$INSTDIR\.MulderConfig\Backup\ContentBaked\pc\FlashMovies"
    CopyFiles /SILENT "$INSTDIR\ContentBaked\pc\FlashMovies\HUDPC.swf" "$INSTDIR\.MulderConfig\Backup\ContentBaked\pc\FlashMovies\HUDPC.swf" 12034
    CopyFiles /SILENT "$INSTDIR\ContentBaked\pc\FlashMovies\sharedlibrary.swf" "$INSTDIR\.MulderConfig\Backup\ContentBaked\pc\FlashMovies\sharedlibrary.swf" 74423

    # DXVK
    SetOutPath "$INSTDIR\.MulderConfig\dxvk\Build\Final"

    !insertmacro DOWNLOAD_2 "https://github.com/doitsujin/dxvk/releases/download/v3.0.2/dxvk-3.0.2.tar.gz" \
                            "https://cdn.mulderload.eu/tools/dxvk/dxvk-3.0.2.tar.gz" \
                            "dxvk-3.0.2.tar.gz" \
                            "9c538924110a7cdef871ca36dee218c0774124374ffdeb38af4b76be55bdf7c2"

    !insertmacro 7Z_EXTRACT "dxvk-3.0.2.tar.gz" ".\" "AUTO_DELETE"
    !insertmacro 7Z_EXTRACT_ONE "dxvk-3.0.2.tar" ".\" "dxvk-3.0.2\x32\d3d11.dll" ""
    !insertmacro 7Z_EXTRACT_ONE "dxvk-3.0.2.tar" ".\" "dxvk-3.0.2\x32\dxgi.dll" "AUTO_DELETE"
    AddSize 13698

    # MulderConfig
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"

    # End
    !insertmacro 7Z_REMOVE
    RMDir /r "$INSTDIR\@mulderload"
    File /oname=README-Mulderland.txt resources\README.txt
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "BioshockHD.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\BioShock Remastered"
    StrCpy $SELECT_RELATIVE_PATH "Build\Final"
    StrCpy $SELECT_STEAM_FOLDER "BioShock Remastered"
FunctionEnd
