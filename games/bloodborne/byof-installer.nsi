!define MUI_WELCOMEPAGE_TEXT "This installer requires user-provided copies of the original Bloodborne GOTY (CUSA03173) and its v1.09 update. It will verify both PKG files. Other versions have not been tested.$\r$\n\
$\r$\n\
It will install the unofficial port, apply a default configuration, unpack your PKGs, and install a curated selection of graphics and quality-of-life mods to enhance the vanilla experience.$\r$\n\
$\r$\n\
Huge thanks to FromSoftware, Sony, the ShadPS4 Team, this port's contributors (deadinside28, Supermedo && others), and the modding community for making this possible!$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
$\r$\n\
This installer && this port are not affiliated with or endorsed by Sony, From Software or any of the original developers."

!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\MulderConfig-README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show ultrawide instructions"
!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Bloodborne (Unofficial PC Port)"
InstallDir "C:\Mulderland\Bloodborne"

!insertmacro BYOF_DEFINE "GAME" "PKG files|*.pkg" "a990fef2579fedfa088f4eb46b8337ea81fe9974"
!insertmacro BYOF_DEFINE "UPDATE" "PKG files|*.pkg" "7fa1ae28c810042688ca62ae1e1e8a0a3a77faee"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Var /GLOBAL LINUX_HOME
!include "GetUnixPath.nsh"

Section
    !insertmacro 7Z_GET
    CreateDirectory "$INSTDIR\mods"
    CreateDirectory "$INSTDIR\patches"
    CreateDirectory "$INSTDIR\user"
SectionEnd

SectionGroup "bbport / bloodborne_pc (by deadinside28)"
    Section "Linux v0.51 (by deadinside28)" bbport
        # Delete previous binary (that was not in a bbport subfolder)
        Delete "$INSTDIR\Bloodborne-bbport-x86_64.AppImage"

        # Install
        SetOutPath "$INSTDIR\bbport"

        !insertmacro DOWNLOAD_2 "https://github.com/deadinside28/bloodborne_pc/releases/download/0.51/Bloodborne-bbport-x86_64.AppImage" \
                                "https://cdn.mulderload.eu/games/bloodborne/Bloodborne-bbport-x86_64-v0.51.AppImage" \
                                "Bloodborne-bbport-x86_64.AppImage" \
                                "3dbbec828aebd542622cf25f0ea10a16f50b13f8b5338fb6596a1a69a635fcce"
        AddSize 390144

        # Copy settings.json
        CreateDirectory "$LINUX_HOME\.config\bbport-launcher"
        File "/oname=$LINUX_HOME\.config\bbport-launcher\settings.json" "resources\bbport\settings.json"

        # Transform $INSTDIR to Unix Format, and write it to settings.json
        !insertmacro GET_UNIX_PATH $INSTDIR $R0
        !insertmacro FILE_STR_REPLACE "__INSTDIR__" "$R0" 1 4 "$LINUX_HOME\.config\bbport-launcher\settings.json"

        # Copy bbport.ini (if user accepts)
        ${If} ${FileExists} "$LINUX_HOME\.local\share\bbport\bbport.ini"
            MessageBox MB_YESNO|MB_DEFBUTTON1 "You have an old 'bbport.ini' on your computer.$\r$\n$\r$\nDo you want to replace it with Mulderland's default (recommended)?" IDNO skip_ini
        ${EndIf}
        CreateDirectory "$LINUX_HOME\.local\share\bbport"
        File "/oname=$LINUX_HOME\.local\share\bbport\bbport.ini" "resources\bbport\bbport.ini"
        skip_ini:
    SectionEnd

    Section "Windows fork v1.7.2 (by Supermedo)" bbport_supermedo
        # Migrate important folders from previous install
        IfFileExists "$INSTDIR\bbport-windows\mods\*.*" 0 end_migrate_mods
            !insertmacro FOLDER_MERGE "$INSTDIR\bbport-windows\mods" "$INSTDIR\mods"
        end_migrate_mods:
        IfFileExists "$INSTDIR\bbport-windows\user\*.*" 0 end_migrate_user
            !insertmacro FOLDER_MERGE "$INSTDIR\bbport-windows\user" "$INSTDIR\user"
        end_migrate_user:

        # Delete previous install
        RMDir /r "$INSTDIR\bbport-windows"

        # Install
        SetOutPath "$INSTDIR\bbport-supermedo"

        !insertmacro DOWNLOAD_2 "https://github.com/Supermedo/bloodborne_pc/releases/download/windows-v1.7.2/Bloodborne-Windows.zip" \
                                "https://cdn.mulderload.eu/games/bloodborne/Bloodborne-Windows-v1.7.2.zip" \
                                "Bloodborne-Windows.zip" \
                                "0e47412530079e41c4b3d0b7ac07081a58f68e6b05f82732196abdb3ad7840fe"

        !insertmacro NSISUNZ_EXTRACT "Bloodborne-Windows.zip" ".\" "AUTO_DELETE"
        !insertmacro FOLDER_MERGE "$INSTDIR\bbport-supermedo\bbport-windows" "$INSTDIR\bbport-supermedo"
        AddSize 285483

        # Copy settings.json
        CreateDirectory "$APPDATA\bbport-launcher"
        File "/oname=$APPDATA\bbport-launcher\settings.json" "resources\bbport-supermedo\settings.json"

        # Copy bbport.ini (if user accepts)
        ${If} ${FileExists} "$INSTDIR\bbport-supermedo\bbport.ini"
            MessageBox MB_YESNO|MB_DEFBUTTON1 "You have an old 'bbport.ini' on your computer.$\r$\n$\r$\nDo you want to replace it with Mulderland's default (recommended)?" IDNO skip_ini_supermedo
        ${EndIf}
        File "/oname=$INSTDIR\bbport-supermedo\bbport.ini" "resources\bbport-supermedo\bbport.ini"
        skip_ini_supermedo:
    SectionEnd
SectionGroupEnd

Section "Extract game files from PKGs"
    AddSize 30774794
    SetOutPath "$INSTDIR"

    DetailPrint " // Get pkgextract"
    !insertmacro DOWNLOAD_2 "https://github.com/paulomanrique/ps4-pkg-extractor/releases/download/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                            "https://cdn.mulderload.eu/dependencies/ps4-pkg-extractor/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                            "pkgextract.zip" \
                            "0c736ee02779fb5cf4403a91da23f94fdaa72debf995be0c400ac9c36acee63a"

    !insertmacro NSISUNZ_EXTRACT "pkgextract.zip" ".\" "AUTO_DELETE"

    DetailPrint " // Extracting game files"
    nsExec::Exec '"$INSTDIR\pkgextract.exe" -o "$INSTDIR\CUSA03173" -f "$byofPath_GAME"'
    Pop $R0
    ${If} $R0 != "0"
        MessageBox MB_ICONEXCLAMATION "An error occurred while extracting the game files."
    ${EndIf}

    DetailPrint " // Extracting update files"
    nsExec::Exec '"$INSTDIR\pkgextract.exe" -o "$INSTDIR\CUSA03173-update" -f "$byofPath_UPDATE"'
    Pop $R1
    ${If} $R1 != "0"
        MessageBox MB_ICONEXCLAMATION "An error occurred while extracting the update files."
    ${EndIf}

    ${If} $R0 == "0"
    ${AndIf} $R1 == "0"
        DetailPrint " // Merging update files"
        !insertmacro FOLDER_MERGE "$INSTDIR\CUSA03173-update" "$INSTDIR\CUSA03173"

        DetailPrint " // Cleaning up"
        Delete "pkgextract.exe"
    ${EndIf}
SectionEnd

Section "Ebrietas Charge Hitbox Fix (by thetrashlp)"
    SetOutPath "$INSTDIR\mods\Ebrietas Charge Hitbox Fix\chr"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/524?tab=files&file_id=2793" \
                            "Ebriatas Charge 524 1 2026-07-11T01-35Z ZWUkAdu2t.7z" \
                            "f7090c88cf7c347a700bc39feee903204b763860"

    !insertmacro NSIS7Z_EXTRACT "Ebriatas Charge 524 1 2026-07-11T01-35Z ZWUkAdu2t.7z" ".\" "AUTO_DELETE"
    AddSize 12001
SectionEnd

SectionGroup /e "Graphical improvements"
    Section "4K Upscaled UI + Xbox prompts (by MoxIsABox)"
        SetOutPath "$INSTDIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/182?tab=files&file_id=1108" \
                                "4K UI Xbox Prompts-182-1-1-1735339618.7z" \
                                "f75a1800c88d41360d57c74aa1a694300e3929f3"

        !insertmacro NSIS7Z_EXTRACT "4K UI Xbox Prompts-182-1-1-1735339618.7z" ".\" "AUTO_DELETE"
        AddSize 1455
    SectionEnd

    Section /o "Upscaled Skybox and Clouds (by johnnycoax)"
        SetOutPath "$INSTDIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/436?tab=files&file_id=2289" \
                                "High Res Sky v2.0 (includes ArcRays Moon Fix mod)-436-2-0-1766723031.zip" \
                                "226aeaa94c9529152920136ac8066d4a67e7dcba"

        !insertmacro 7Z_EXTRACT "High Res Sky v2.0 (includes ArcRays Moon Fix mod)-436-2-0-1766723031.zip" ".\" "AUTO_DELETE"
        AddSize 4548075
    SectionEnd

    Section "[WIN] Ultrawide Support (by Kyo, Dziggy & Mulder)" ultrawide
        SetOutPath "$INSTDIR\.MulderConfig"
        File "resources\ultrawide\Bloodborne_Ultrawide.xml"

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

        ${IfNot} ${FileExists} "$INSTDIR\bbport-supermedo\mods.json"
            File "/oname=$INSTDIR\bbport-supermedo\mods.json" "resources\ultrawide\mods.json"
        ${EndIf}
        ${IfNot} ${FileExists} "$INSTDIR\bbport-supermedo\patches.json"
            File "/oname=$INSTDIR\bbport-supermedo\patches.json" "resources\ultrawide\patches.json"
        ${EndIf}

        SetOutPath "$INSTDIR"
        File "resources\ultrawide\MulderConfig-README.txt"
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources\ultrawide"
    SectionEnd
SectionGroupEnd

SectionGroup "Quality of Life improvements"
    Section "Auto refill from storage (by LordTPS)"
        SetOutPath "$INSTDIR\mods\Auto refill from storage"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/217?tab=files&file_id=1313" \
                                "Auto Refill From Storage-217-1-0-1737135942.rar" \
                                "f5c93a12400add1fcf06ddf8a2bf7d687c393b77"

        !insertmacro 7Z_EXTRACT "Auto Refill From Storage-217-1-0-1737135942.rar" ".\" "AUTO_DELETE"
        AddSize 1455
    SectionEnd

    Section "Coldblood Items Show Value (by BaselDev)"
        SetOutPath "$INSTDIR\mods"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/bloodborne/mods/542?tab=files&file_id=2896" \
                                "Coldblood Items Show Value 542 3 2026-08-14T18-27Z 37KAeahjb.zip" \
                                "986aac4821ddcca27b935ab999b591c32ee4f564"

        !insertmacro NSISUNZ_EXTRACT "Coldblood Items Show Value 542 3 2026-08-14T18-27Z 37KAeahjb.zip" ".\" "AUTO_DELETE"
        AddSize 408
    SectionEnd

    Section "Lamp2Lamp: Warp Between Lamps (by Disschorde)"
        SetOutPath "$INSTDIR\mods\Lamp2Lamp"

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
        SectionSetFlags ${bbport_supermedo} ${SF_RO}
        SectionSetFlags ${ultrawide} ${SF_RO}
        ReadEnvStr $R0 "USER"
        StrCpy $LINUX_HOME "Z:\home\$R0"
        StrCpy $INSTDIR "$LINUX_HOME\Mulderland\Bloodborne"
    ${Else}
        SectionSetFlags ${bbport} ${SF_RO}
    ${EndIf}
FunctionEnd
