!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Dark Souls PTDE, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- DSFix (by Durante), with 3 pre-configured presets$\r$\n\
- FPSFixPlus (by SeanPesce) to fix some 60 FPS bugs$\r$\n\
- Morten242's UI for DSFix$\r$\n\
- 2 HD interface mods$\r$\n\
- 4 HD texture mods (that don't change the look && feel)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Dark Souls: Prepare To Die Edition [Enhancement Pack]"

SectionGroup /e "DSFix v2.4 + FPSFix-Plus + Morten242's UI v1.5.1"
    Section
        AddSize 1024
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/games/dark-souls-prepare-to-die-edition/downloads/dsfix" \
                                "DSfix.zip" \
                                "efb76063fef728737d2204f21099261c"

        !insertmacro NSISUNZ_EXTRACT "DSfix.zip" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_2 "https://github.com/SeanPesce/FPSFix-Plus/releases/download/2017-09-01/FPSFix-Plus-Bundle_v2017-09-07.zip" \
                                "https://cdn.mulderload.eu/games/dark-souls-prepare-to-die-edition/impr_gfx/FPSFix-Plus-Bundle_v2017-09-07.zip" \
                                "FPSFix-Plus-Bundle.zip" \
                                "19690f7dea168f7971cc79c75047338a2b5367f0"

        !insertmacro NSISUNZ_EXTRACT_ONE "FPSFix-Plus-Bundle.zip" ".\" "d3dx9_43\d3dx9_43.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "FPSFix-Plus-Bundle.zip" ".\" "d3dx9_43\FPSFix-Plus-Readme.txt" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "FPSFix-Plus-Bundle.zip" ".\" "d3dx9_43\FPSFix.ini" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/45?tab=files&file_id=1000001121" \
                                "Morten242s UI for DSfix.zip" \
                                "bd969141f065c731b8d19eced2ae3cde2c3258c5"

        !insertmacro NSISUNZ_EXTRACT "Morten242s UI for DSfix.zip" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Preset: rendering @ 1080p60" config_1080
        AddSize 8
        SetOutPath "$INSTDIR"
        File /oname=DSfix.ini resources\DSfix_1080.ini
    SectionEnd

    Section /o "Preset: rendering @ 1440p60" config_1440
        AddSize 8
        SetOutPath "$INSTDIR"
        File /oname=DSfix.ini resources\DSfix_1440.ini
    SectionEnd

    Section /o "Preset: rendering @ 2160p60" config_2160
        AddSize 8
        SetOutPath "$INSTDIR"
        File /oname=DSfix.ini resources\DSfix_2160.ini
    SectionEnd
SectionGroupEnd

Section
    !insertmacro 7Z_GET
SectionEnd

Section "HD Interface (Fonts + Controller Icons)"
    AddSize 11949
    SetOutPath "$INSTDIR\dsfix\tex_override"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/21?tab=files&file_id=209" \
                            "Dark Souls - High-Res UI and Subtitles.rar" \
                            "4e8ca9a729b63eea36fc40169b0d13e1a2f9a0ce"

    !insertmacro 7Z_EXTRACT "Dark Souls - High-Res UI and Subtitles.rar" "." "AUTO_DELETE"

    # https://www.nexusmods.com/darksouls/mods/171 (converted to DDS format for better performance)
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/dark-souls-prepare-to-die-edition/impr_gfx/Xbox 360 HD Interface Icons-171-1 [DDS Repack-MLD].7z" \
                            "Xbox 360 HD Interface Icons-171-1 [DDS Repack-MLD].7z" \
                            "9717ac0593c69f4026e166d39be8544174d4ea42"

    !insertmacro NSIS7Z_EXTRACT "Xbox 360 HD Interface Icons-171-1 [DDS Repack-MLD].7z" ".\" "AUTO_DELETE"
SectionEnd

Section "HD Textures (LCD v1.5 + Lava Fix + Random HD Textures + HD Player Messages)"
    AddSize 20583
    SetOutPath "$INSTDIR\dsfix\tex_override"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/268?tab=files&file_id=1000000511" \
                            "LCD Textures.zip" \
                            "6115e33a9078f9bbe0108b976e3e2b5d4969790c"

    !insertmacro NSISUNZ_EXTRACT "LCD Textures.zip" ".\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/1025?tab=files&file_id=1000001471" \
                            "Lava Fix High Res.zip" \
                            "bf74be6aa7a2dfcbb21cd8d140098a0b3a55f64f"

    !insertmacro NSISUNZ_EXTRACT "Lava Fix High Res.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\dsfix\tex_override\Lava Fix High Res" "$INSTDIR\dsfix\tex_override"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/1670?tab=files&file_id=1000003291" \
                            "HD Textures.zip" \
                            "f28998684a8e81e32a06380cba7b6fa6acd93e72"

    !insertmacro NSISUNZ_EXTRACT "HD Textures.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\dsfix\tex_override\Demon Ruins" "$INSTDIR\dsfix\tex_override"
    !insertmacro FOLDER_MERGE "$INSTDIR\dsfix\tex_override\Duke's Archives" "$INSTDIR\dsfix\tex_override"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/darksouls/mods/389?tab=files&file_id=1000000337" \
                            "HD Player Messages DDS Version.rar" \
                            "1ca3bca8c1aec66604919150908ff6dc98b7dbe1"

    !insertmacro 7Z_EXTRACT "HD Player Messages DDS Version.rar" "." "AUTO_DELETE"
SectionEnd

Section
    !insertmacro 7Z_REMOVE
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DARKSOULS.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Dark Souls Prepare to Die Edition\DATA"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${config_1080} ; Radio Button - Option 1080 is selected by default
FunctionEnd

Function .onSelChange
    !insertmacro StartRadioButtons $1
        !insertmacro RadioButton ${config_1080}
        !insertmacro RadioButton ${config_1440}
        !insertmacro RadioButton ${config_2160}
    !insertmacro EndRadioButtons
FunctionEnd
