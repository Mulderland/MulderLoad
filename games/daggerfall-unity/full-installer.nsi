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
                            "https://cdn2.mulderload.eu/g/daggerfall-unity/dfu_windows_64bit-v1.1.1.zip" \
                            "dfu.zip" "f4fbcdf7cf6af1c60f1bcdfaee426e955754a509"
    !insertmacro NSISUNZ_EXTRACT "dfu.zip" ".\" "AUTO_DELETE"

    # Daggerfall files from Archive.org (freeware since 2009)
    !insertmacro DOWNLOAD_1 "https://archive.org/download/daggerfall-play/Daggerfall.zip" "Daggerfall.zip" "8135a03065b9a4a8f114c77822756dab76745505"
    !insertmacro NSISUNZ_EXTRACT "Daggerfall.zip" ".\" "AUTO_DELETE"
    Rename "$INSTDIR\DAGGER\ARENA2" "$INSTDIR\ARENA2"
    RMDir /r "$INSTDIR\DAGGER"
    Delete "dagger.bat"
SectionEnd

Section /o "Patch FR (French Texts)"
    SetOutPath "$INSTDIR\DaggerfallUnity_Data\StreamingAssets"

    # https://www.nexusmods.com/daggerfallunity/mods/456
    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/hvptn1qhfrx16zt/VF_Daggerfall_Unity_1.1.1a-456-1-1-1a-1721921977.7z/file" \
                            "https://cdn2.mulderload.eu/g/daggerfall-unity/VF%20Daggerfall%20Unity%201.1.1a-456-1-1-1a-1721921977.7z" \
                            "VF_Daggerfall_Unity.7z" "49c355ff758c3277ce3ff053e5b60df0264e0a20"
    !insertmacro NSIS7Z_EXTRACT "VF_Daggerfall_Unity.7z" ".\" "AUTO_DELETE"
SectionEnd
