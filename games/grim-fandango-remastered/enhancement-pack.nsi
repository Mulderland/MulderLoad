!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Grim Fandango Remastered, with:$\r$\n\
- GrimMod (by Hexagon)$\r$\n\
- GrimHD Textures Pack (by Hexagon)$\r$\n\
- Czech translation (by ren7o)$\r$\n\
- Romanian translation (by Indurin)$\r$\n\
- Russian translation (by ENPY Studio/Spirit Team)$\r$\n\
- MulderConfig (by Mulder)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Hexagon for the dedication and hard work on this game!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Grim Fandango Remastered [Enhancement Pack]"

Section
    !insertmacro 7Z_GET
SectionEnd

SectionGroup /e "Improvements configurable via MulderConfig"
    Section "Czech translation (by ren7o)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\translation.cz"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/grim-fandango-remastered/translation/Grim_Fandango_Remastered_2015_1.02_08032025_1242.zip" \
                                "Grim_Fandango_Remastered_2015_1.02_08032025_1242.zip" \
                                "8985a11fd3ae80ef463b1a51ba4dcb845524b57f"

        !insertmacro NSISUNZ_EXTRACT "Grim_Fandango_Remastered_2015_1.02_08032025_1242.zip" ".\" "AUTO_DELETE"
        !insertmacro 7Z_EXTRACT "Grim Fandango Remastered cz v1.02.exe" ".\" "AUTO_DELETE"
    SectionEnd

    Section "GrimMod v1.1.1 (by Hexagon)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\grimmod"

        # GrimMod: use fork until my PR is merged: https://github.com/TheHexagonCodes/grimmod/pull/8
        !insertmacro DOWNLOAD_2 "https://github.com/mulderf0x/grimmod/releases/download/v1.1.1/glu32.dll" \
                                "https://cdn.mulderload.eu/games/grim-fandango-remastered/glu32_v1.1.1.dll" \
                                "glu32.dll" \
                                "fbe08fba0c0eed48173076f402760fb912d33e88b9a05be7c1aac4fb48affe7c"
        AddSize 3493
    SectionEnd

    Section "Romanian translation (by Indurin)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\translation.ro"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/grimfandangoremastered/mods/3?tab=files&file_id=3" \
                                "Romana 3 1 2026-08-05T05-14Z qrSD72xVn.rar" \
                                "3bd625309aa2f4c61b9f0084b62d87c303cd2c3eae2b124b447c75626449c566"

        !insertmacro 7Z_EXTRACT "Romana 3 1 2026-08-05T05-14Z qrSD72xVn.rar" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Russian translation (by ENPY Studio/Spirit Team)"
        SectionIn RO
        SetOutPath "$INSTDIR\.MulderConfig\translation.ru"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/grim-fandango-remastered/translation/Grim.Fandango.Remastered.ENPY.NET.20150223.zip" \
                                "Grim.Fandango.Remastered.ENPY.NET.20150223.zip" \
                                "366bcfaa2e1b75333b00f5ce6209de6589f946c7"

        !insertmacro NSISUNZ_EXTRACT "Grim.Fandango.Remastered.ENPY.NET.20150223.zip" ".\" "AUTO_DELETE"
    SectionEnd

    Section
        ${IfNot} ${FileExists} "$INSTDIR\.MulderConfig\Backup\grim.en.tab"
            CopyFiles /SILENT "$INSTDIR\grim.en.tab" "$INSTDIR\.MulderConfig\Backup\grim.en.tab" 512
        ${EndIf}
        ${IfNot} ${FileExists} "$INSTDIR\.MulderConfig\Backup\FontsHD\*.*"
            CopyFiles /SILENT "$INSTDIR\FontsHD" "$INSTDIR\.MulderConfig\Backup\FontsHD" 1320
        ${EndIf}
        SetOutPath "$INSTDIR"
        File "resources\grimmod.toml"
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
    SectionEnd
SectionGroupEnd

Section "GrimHD (HQ Backgrounds, by Hexagon) v1.0.1"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn.hexagon.codes/GrimHD_1.0.1.zip" \
                            "https://cdn.mulderload.eu/games/grim-fandango-remastered/impr_gfx/GrimHD_1.0.1.zip" \
                            "GrimHD_1.0.1.zip" \
                            "2ecd86053e2d84e36523b06211f579c9030d0fdc"

    !insertmacro 7Z_EXTRACT "GrimHD_1.0.1.zip" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "readme.txt" "readme_GrimHD.txt"
    AddSize 2045354
SectionEnd

Section
    !insertmacro 7Z_REMOVE
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "GrimFandango.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Grim Fandango Remastererd"
    StrCpy $SELECT_STEAM_FOLDER "Grim Fandango Remastered"
FunctionEnd
