!define MUI_WELCOMEPAGE_TEXT "This installer requires user-provided copies of the original Bloodborne GOTY (CUSA03173) and its v1.09 update. It will verify both PKG files. Other versions have not been tested.$\r$\n\
$\r$\n\
It will install the unofficial port, apply a default configuration, unpack your PKGs, and install a curated selection of graphics and quality-of-life mods to enhance the vanilla experience.$\r$\n\
$\r$\n\
Huge thanks to FromSoftware, Sony, the ShadPS4 Team, this port's contributors (deadinside28, Supermedo && others), and the modding community for making this possible!$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
$\r$\n\
This installer && this port are not affiliated with or endorsed by Sony, From Software or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Bloodborne (Unofficial PC Port)"
InstallDir "C:\Mulderland\Bloodborne"

!insertmacro BYOF_DEFINE "GAME" "PKG files|*.pkg" "a990fef2579fedfa088f4eb46b8337ea81fe9974"
!insertmacro BYOF_DEFINE "UPDATE" "PKG files|*.pkg" "7fa1ae28c810042688ca62ae1e1e8a0a3a77faee"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Var /GLOBAL BBPORT_DIR
Var /GLOBAL BBPORT_CONFIG_DIR
Var /GLOBAL LAUNCHER_CONFIG_DIR

Section
    !insertmacro DETECT_OS $R0
    ${If} $R0 == "Linux"
        StrCpy $BBPORT_DIR "$INSTDIR"
        ReadEnvStr $R0 "USER"
        StrCpy $BBPORT_CONFIG_DIR "Z:\home\$R0\.local\share\bbport"
        StrCpy $LAUNCHER_CONFIG_DIR "Z:\home\$R0\.config\bbport-launcher"
    ${Else}
        StrCpy $BBPORT_DIR "$INSTDIR\bbport-windows"
        StrCpy $BBPORT_CONFIG_DIR "$INSTDIR\bbport-windows"
        StrCpy $LAUNCHER_CONFIG_DIR "$APPDATA\bbport-launcher"
    ${EndIf}
    CreateDirectory "$BBPORT_DIR\mods"
    CreateDirectory "$BBPORT_DIR\patches"
    CreateDirectory "$BBPORT_CONFIG_DIR"
    CreateDirectory "$BBPORT_LAUNCHER_DIR"

    !insertmacro 7Z_GET
SectionEnd

SectionGroup "bloodborne_pc (by deadinside28)" bloodborne_pc
    Section "Linux v0.5 (by deadinside28)" bloodborne_pc_linux
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://github.com/deadinside28/bloodborne_pc/releases/download/0.5/Bloodborne-bbport-x86_64.AppImage" \
                                "Bloodborne-bbport-x86_64.AppImage" \
                                "09fc1d13f645631decc06d427c71a08564a2c153df0734ce7bd2a73aad5b9952"
        AddSize 864256

        # Copy settings.json
        File "/oname=$BBPORT_LAUNCHER_DIR\settings.json" "resources\linux\settings.json"

        # Edit settings.json with real __GAMEDIR__
        StrCpy $R0 $INSTDIR "" 2 ; copy INSTDIR without first 2 char (Z: for example)
        !insertmacro STR_REPLACE "\" "/" $R0 $R0
        !insertmacro FILE_STR_REPLACE "__GAMEDIR__" "$R0" 1 4 "Z:\home\$R0\.config\bbport-launcher\settings.json"

        # Write bbport.ini (if user accepts)
        ${If} ${FileExists} "$BBPORT_CONFIG_DIR\bbport.ini"
            MessageBox MB_YESNO|MB_DEFBUTTON1 "You have an old 'bbport.ini' on your computer.$\r$\n$\r$\nDo you want to replace it with Mulderland's default (recommended)?" IDNO linux_skip_ini
        ${EndIf}
        File "/oname=$BBPORT_CONFIG_DIR\bbport.ini" "resources\linux\bbport.ini"
        linux_skip_ini:
    SectionEnd

    Section "Windows fork v1.6 (by Supermedo)" bloodborne_pc_windows
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://github.com/Supermedo/bloodborne_pc/releases/download/windows-v1.6/Bloodborne-Windows.zip" \
                                "https://cdn.mulderload.eu/games/bloodborne/Bloodborne-Windows-v1.6.zip" \
                                "Bloodborne-Windows.zip" \
                                "8410d1ca83c5335c2178c742c8a077b9cb07bf262018537f85fba7ac1808bd7d"

        !insertmacro NSISUNZ_EXTRACT "Bloodborne-Windows.zip" ".\" "AUTO_DELETE"
        AddSize 273495

        # Write settings.json
        File "/oname=$BBPORT_LAUNCHER_DIR\settings.json" "resources\windows\settings.json"

        # Write bbport.ini (if user accepts)
        ${If} ${FileExists} "$BBPORT_CONFIG_DIR\bbport.ini"
            MessageBox MB_YESNO|MB_DEFBUTTON1 "You have an old 'bbport.ini' on your computer.$\r$\n$\r$\nDo you want to replace it with Mulderland's default (recommended)?" IDNO windows_skip_ini
        ${EndIf}
        File "/oname=$BBPORT_CONFIG_DIR\bbport.ini" "resources\windows\bbport.ini"
        windows_skip_ini:
    SectionEnd
SectionGroupEnd

Section "Extract game files from PKGs"
    SetOutPath "$INSTDIR"

    DetailPrint " // Get pkgextract"
    !insertmacro DOWNLOAD_2 "https://github.com/paulomanrique/ps4-pkg-extractor/releases/download/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                            "https://cdn.mulderload.eu/dependencies/ps4-pkg-extractor/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                            "pkgextract.zip" \
                            "0c736ee02779fb5cf4403a91da23f94fdaa72debf995be0c400ac9c36acee63a"

    !insertmacro NSISUNZ_EXTRACT "pkgextract.zip" ".\" "AUTO_DELETE"

    DetailPrint " // Extracting game files from PKGs"
    nsExec::ExecToStack '"$INSTDIR\pkgextract.exe" -o ".\CUSA03173" -f "$byofPath_GAME"'
    nsExec::ExecToStack '"$INSTDIR\pkgextract.exe" -o ".\CUSA03173-update" -f "$byofPath_UPDATE"'
    !insertmacro FOLDER_MERGE "$INSTDIR\CUSA03173-update" "$INSTDIR\CUSA03173"
    AddSize 30774794

    DetailPrint " // Cleaning up"
    Delete "pkgextract.exe"
SectionEnd

Section "Ebrietas Charge Hitbox Fix (by thetrashlp)"
    SetOutPath "$BBPORT_DIR\mods\Ebrietas Charge Hitbox Fix\chr"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/524?tab=files&file_id=2793" \
                            "Ebriatas Charge 524 1 2026-07-11T01-35Z ZWUkAdu2t.7z" \
                            "f7090c88cf7c347a700bc39feee903204b763860"

    !insertmacro NSIS7Z_EXTRACT "Ebriatas Charge 524 1 2026-07-11T01-35Z ZWUkAdu2t.7z" ".\" "AUTO_DELETE"
    AddSize 12001
SectionEnd

SectionGroup /e "Graphical improvements"
    Section "4K Upscaled UI + Xbox prompts (by MoxIsABox)"
        SetOutPath "$BBPORT_DIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/182?tab=files&file_id=1108" \
                                "4K UI Xbox Prompts-182-1-1-1735339618.7z" \
                                "f75a1800c88d41360d57c74aa1a694300e3929f3"

        !insertmacro NSIS7Z_EXTRACT "4K UI Xbox Prompts-182-1-1-1735339618.7z" ".\" "AUTO_DELETE"
        AddSize 1455
    SectionEnd

    Section "Ultrawide Support (by Kyo & Dziggy)"
        SetOutPath "$BBPORT_DIR\patches"
        File "resources\Bloodborne_Ultrawide.xml"

        SetOutPath "$BBPORT_DIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/202?tab=files&file_id=1286" \
                                "02 - 21.5x9  (43x18)-202-1-0-1-1736754983.zip" \
                                "7addc5c11d530e46ac225213ade6b7c33ede8764"

        !insertmacro NSISUNZ_EXTRACT "02 - 21.5x9  (43x18)-202-1-0-1-1736754983.zip" ".\" "AUTO_DELETE"
        RMDir /r "Ultrawide UI (21-9)"
        Rename "21.5x9 UI Fixes v1.0.1" "Ultrawide UI (21-9)"
        AddSize 736

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/202?tab=files&file_id=1288" \
                                "04 - 32x9-202-1-0-1-1736755039.zip" \
                                "d6583304ee3fcafb7f6614f73fba77522560f155"

        !insertmacro NSISUNZ_EXTRACT "04 - 32x9-202-1-0-1-1736755039.zip" ".\" "AUTO_DELETE"
        RMDir /r "Ultrawide UI (32-9)"
        Rename "32x9 UI Fixes v1.0.1" "Ultrawide UI (32-9)"
        AddSize 736

        # Disable Ultrawide Mods by default
        File "/oname=$BBPORT_CONFIG_DIR\mods.json" "resources\mods.json"
    SectionEnd

    Section /o "Upscaled Skybox and Clouds (by johnnycoax)"
        SetOutPath "$BBPORT_DIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/436?tab=files&file_id=2289" \
                                "High Res Sky v2.0 (includes ArcRays Moon Fix mod)-436-2-0-1766723031.zip" \
                                "226aeaa94c9529152920136ac8066d4a67e7dcba"

        !insertmacro 7Z_EXTRACT "High Res Sky v2.0 (includes ArcRays Moon Fix mod)-436-2-0-1766723031.zip" ".\" "AUTO_DELETE"
        AddSize 4548075
    SectionEnd
SectionGroupEnd

SectionGroup "Quality of Life improvements"
    Section "Auto refill from storage (by LordTPS)"
        SetOutPath "$BBPORT_DIR\mods\Auto refill from storage"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/217?tab=files&file_id=1313" \
                                "Auto Refill From Storage-217-1-0-1737135942.rar" \
                                "f5c93a12400add1fcf06ddf8a2bf7d687c393b77"

        !insertmacro 7Z_EXTRACT "Auto Refill From Storage-217-1-0-1737135942.rar" ".\" "AUTO_DELETE"
        AddSize 1455
    SectionEnd

    Section "Coldblood Items Show Value (by BaselDev)"
        SetOutPath "$BBPORT_DIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/542?tab=files&file_id=2896" \
                                "Coldblood Items Show Value 542 3 2026-08-14T18-27Z 37KAeahjb.zip" \
                                "986aac4821ddcca27b935ab999b591c32ee4f564"

        !insertmacro NSISUNZ_EXTRACT "Coldblood Items Show Value 542 3 2026-08-14T18-27Z 37KAeahjb.zip" ".\" "AUTO_DELETE"
        AddSize 408
    SectionEnd

    Section "Lamp2Lamp: Warp Between Lamps (by Disschorde)"
        SetOutPath "$BBPORT_DIR\mods\Lamp2Lamp"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/455?tab=files&file_id=2404" \
                                "Lamp2Lamp - Core-455-1-1-0-1771802685.zip" \
                                "958921a0f472c33be993549d30bae4469753031d"

        !insertmacro NSISUNZ_EXTRACT "Lamp2Lamp - Core-455-1-1-0-1771802685.zip" ".\" "AUTO_DELETE"
        AddSize 1173
    SectionEnd
SectionGroupEnd

Section
    !insertmacro 7Z_REMOVE
    RMDir "$INSTDIR\@mulderload"
SectionEnd

Function .onInit
    !insertmacro DETECT_OS $R0
    ${If} $R0 == "Linux"
        ReadEnvStr $R0 STEAM_APP_PATH
        ${If} $R0 != ""
            MessageBox MB_ICONEXCLAMATION \
                "This installer should not be run through Protontricks.$\r$\n\
                $\r$\n\
                Please run it directly with Wine, or temporarily add it to Steam as a non-Steam game."
            Quit
        ${EndIf}
        SectionSetFlags ${bloodborne_pc_windows} ${SF_RO}
        ReadEnvStr $R0 "USER"
        StrCpy $INSTDIR "Z:\home\$R0\Mulderland\Bloodborne"
    ${Else}
        SectionSetFlags ${bloodborne_pc_linux} ${SF_RO}
    ${EndIf}
FunctionEnd
