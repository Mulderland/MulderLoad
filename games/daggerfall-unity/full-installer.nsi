!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download the latest version of Daggerfall Unity (v1.1.1)$\r$\n- download original game files from Archive.org$\r$\n- (optionally) download french patch"
!include "..\..\templates\standard.nsh"

Name "Daggerfall Unity"
InstallDir "C:\MulderLoad\Daggerfall Unity"

Section "Daggerfall Unity v1.1.1"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/Interkarma/daggerfall-unity/releases/download/v1.1.1/dfu_windows_64bit-v1.1.1.zip "dfu.zip"
    nsisunz::Unzip "dfu.zip" ".\"
    Delete "dfu.zip"
SectionEnd

Section "Required Original Game Files"
    SetOutPath $INSTDIR

    !insertmacro Download https://archive.org/download/daggerfall-play/Daggerfall.zip "Daggerfall.zip"
    nsisunz::Unzip "Daggerfall.zip" ".\"
    Delete "Daggerfall.zip"

    Rename "$INSTDIR\DAGGER\ARENA2" "$INSTDIR\ARENA2"
    RMDir /r "$INSTDIR\DAGGER"
    Delete "dagger.bat"
SectionEnd

Section /o "Patch FR (French Texts)"
    SetOutPath $INSTDIR\DaggerfallUnity_Data\StreamingAssets

    !insertmacro Download https://www.mediafire.com/file_premium/jesqxtf9gegvvql/VF_Daggerfall_Unity_1.1.1a-456-1-1-1a-1721921977.7z/file "VF_Daggerfall_Unity.7z"
    Nsis7z::ExtractWithDetails "VF_Daggerfall_Unity.7z" "Installing package %s..."
    Delete "VF_Daggerfall_Unity.7z"
SectionEnd
