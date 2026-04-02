!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Daggerfall Unity, a fan-remake of the classic Elder Scrolls II: Daggerfall. It will:$\r$\n\
- download the latest version of Daggerfall Unity (v1.1.1)$\r$\n\
- download original game files from Archive.org (as it's freeware since 2009, thanks to Bethesda)$\r$\n\
- (optionally) download French patch$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Interkarma for this fan-remake, the Unity developers, and of course Bethesda!"

!include "..\..\includes\templates\ClassicTemplate.nsh"

Name "Daggerfall Unity"
InstallDir "C:\MulderLoad\Daggerfall Unity"

Section "Daggerfall Unity v1.1.1"
    AddSize 652288
    SetOutPath "$INSTDIR"

    # Daggerfall Unity
    !insertmacro DOWNLOAD_2 "https://github.com/Interkarma/daggerfall-unity/releases/download/v1.1.1/dfu_windows_64bit-v1.1.1.zip" \
                            "https://cdn1.mulderload.eu/games/daggerfall-unity/dfu_windows_64bit-v1.1.1.zip" \
                            "dfu.zip" "f4fbcdf7cf6af1c60f1bcdfaee426e955754a509"
    !insertmacro NSISUNZ_EXTRACT "dfu.zip" ".\" "AUTO_DELETE"

    # Daggerfall files (freeware since 2009)
    !insertmacro DOWNLOAD_1 "https://www.mediafire.com/file_premium/1xjjcgx9bksbo6i/arena2.7z/file" "arena2.7z" "797be804f240d876f1ba5f5160d6b009f4c136da"
    !insertmacro NSIS7Z_EXTRACT "arena2.7z" ".\" "AUTO_DELETE"
SectionEnd

Section /o "Patch FR (French Texts) v1.1.1a"
    SetOutPath "$INSTDIR\DaggerfallUnity_Data\StreamingAssets"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/daggerfallunity/mods/456?tab=files&file_id=3926" \
                            "VF_Daggerfall_Unity.7z" "49c355ff758c3277ce3ff053e5b60df0264e0a20"
    !insertmacro NSIS7Z_EXTRACT "VF_Daggerfall_Unity.7z" ".\" "AUTO_DELETE"
SectionEnd
