!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nIt includes:$\r$\n- Widescreen Fix$\r$\n- PS3 HD Textures$\r$\n- Bonus Missions$\r$\n$\r$\nA big thanks to ThirteenAG and the dgVoodoo project !"
!include "..\..\templates\select_exe.nsh"

Name "Tom Clancy's Splinter Cell [PATCHS]"

SectionGroup /e "Graphical improvements"
    Section "ThirteenAG's Widescreen Fix (with updated components)"
        SectionIn RO
        SetOutPath $INSTDIR

        # ThirteenAG's Widescreen Fix
        !insertmacro Download https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/sc/SplinterCell.WidescreenFix.zip "WidescreenFix.zip"
        nsisunz::Unzip /file "system\scripts\SplinterCell.WidescreenFix.asi" "WidescreenFix.zip" ".\"
        nsisunz::Unzip /file "system\scripts\SplinterCell.WidescreenFix.ini" "WidescreenFix.zip" ".\"
        Delete "WidescreenFix.zip"

        # Ultimate ASI Loader (latest)
        !insertmacro Download https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/msacm32-Win32.zip "msacm32.zip"
        nsisunz::Unzip /noextractpath /file "msacm32.dll" "msacm32.zip" ".\system"
        Delete "msacm32.zip"
        !insertmacro Download https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/msvfw32-Win32.zip "msvfw32.zip"
        nsisunz::Unzip /noextractpath /file "msvfw32.dll" "msvfw32.zip" ".\system"
        Delete "msvfw32.zip"

        # DgVoodoo v2.85
        !insertmacro Download https://github.com/dege-diosg/dgVoodoo2/releases/download/v2.85/dgVoodoo2_85.zip "dgVoodoo.zip"
        nsisunz::Unzip /noextractpath /file "dgVoodoo.conf" "dgVoodoo.zip" ".\system"
        nsisunz::Unzip /noextractpath /file "dgVoodooCpl.exe" "dgVoodoo.zip" ".\system"
        nsisunz::Unzip /noextractpath /file "MS\x86\D3d8.dll" "dgVoodoo.zip" ".\system"
        Delete "dgVoodoo.zip"
    SectionEnd

    Section /o "PS3 HD Textures"
        !insertmacro Download https://www.mediafire.com/file_premium/knqozd59uomqzuc/SC1_PS3_Textures.7z/file "SC1_PS3_Textures.7z"
        Nsis7z::ExtractWithDetails "SC1_PS3_Textures.7z" "Installing package %s..."
        Delete "SC1_PS3_Textures.7z"
    SectionEnd
SectionGroupEnd

Section /o "Bonus missions (missing from Steam release)"
    SetOutPath $INSTDIR

    !insertmacro Download https://archive.org/download/splinter-cell-extra-content/Splinter_cell_missing_maps.7z "Splinter_cell_missing_maps.7z"
    Nsis7z::ExtractWithDetails "Splinter_cell_missing_maps.7z" "Installing package %s..."
    Delete "Splinter_cell_missing_maps.7z"
SectionEnd

Section /o "Skip intro videos"
    SetOutPath $INSTDIR\Videos

    Rename "Logos.bik" "Logos.bik.bak"
    Rename "videointro.bik" "videointro.bik.bak"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "splintercell.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Splinter Cell\system"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
