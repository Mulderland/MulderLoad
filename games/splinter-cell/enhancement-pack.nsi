!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Splinter Cell 1, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Widescreen Fix (by ThirteenAG), updated with the latest Ultimate ASI Loader$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- (optionally) PS3 HD Textures$\r$\n\
- (optionally) Missing missions from Steam release$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to ThirteenAG and the dgVoodoo2 project!"

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Tom Clancy's Splinter Cell [Enhancement Pack]"

SectionGroup /e "Graphical improvements"
    Section "ThirteenAG's Widescreen Fix (with updated components)"
        AddSize 10854
        SetOutPath "$INSTDIR\system\scripts"

        # ThirteenAG's Widescreen Fix
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/sc/SplinterCell.WidescreenFix.zip" "WidescreenFix.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "WidescreenFix.zip" ".\" "system\scripts\SplinterCell.WidescreenFix.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "WidescreenFix.zip" ".\" "system\scripts\SplinterCell.WidescreenFix.ini" "AUTO_DELETE"

        SetOutPath "$INSTDIR\system"

        # Ultimate ASI Loader (latest)
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/msacm32-Win32.zip" "msacm32.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "msacm32.zip" ".\" "msacm32.dll" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/msvfw32-Win32.zip" "msvfw32.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "msvfw32.zip" ".\" "msvfw32.dll" "AUTO_DELETE"

        # DgVoodoo2
        !insertmacro DOWNLOAD_DGVOODOO2
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D8.dll" "AUTO_DELETE"
    SectionEnd

    Section /o "PS3 HD Textures"
        AddSize 252928
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/740-splinter-cell-ps3-hd-textures/#2939" \
                                "https://cdn2.mulderload.eu/g/splinter-cell/SC1_PS3_Textures.zip" \
                                "SC1_PS3_Textures.zip" "5f00dfc82db3ec8a067224d6bac0f19212af545c"

        !insertmacro NSISUNZ_EXTRACT "SC1_PS3_Textures.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section /o "Bonus missions (missing from Steam release)"
    AddSize 108544
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://archive.org/download/splinter-cell-extra-content/Splinter_cell_missing_maps.7z" \
                            "https://cdn2.mulderload.eu/g/splinter-cell/Splinter_cell_missing_maps.7z" \
                            "Splinter_cell_missing_maps.7z" "be5b222fc4b861f697058eddf4e497985b156b4e"

    !insertmacro NSIS7Z_EXTRACT "Splinter_cell_missing_maps.7z" ".\" "AUTO_DELETE"
SectionEnd

Section /o "Skip intro videos"
    !insertmacro FORCE_RENAME "$INSTDIR\Videos\Logos.bik" "$INSTDIR\Videos\Logos.bik.bak"
    !insertmacro FORCE_RENAME "$INSTDIR\Videos\videointro.bik" "$INSTDIR\Videos\videointro.bik.bak"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "splintercell.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Splinter Cell\system"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
