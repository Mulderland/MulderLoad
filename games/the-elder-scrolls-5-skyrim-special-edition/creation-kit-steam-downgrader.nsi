!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Skyrim SE: Creation Kit (1.7.99, August 2026).$\r$\n\
$\r$\n\
WARNING: this is for the Creation Kit only! The game downgrader is also available at www.mulderland.com$\r$\n\
$\r$\n\
It can downgrade to 3 different versions (your choice):$\r$\n\
- v1.6.438.0 (April 2022)$\r$\n\
- v1.6.1130.0 (December 2023)$\r$\n\
- v1.6.1378.1 (November 2024, the n-1 version)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Buy me a coffee? :)"
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenKofi"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Skyrim SE: Creation Kit [Steam Downgrader]"

Function OnSelectedFile
    # Todo change hash with new one
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\CreationKit.exe" "bbfd6c4295148fcead4f3ab878cd95c6ace9dc53" $0
     ${If} "$0" == "1"
        MessageBox MB_OK "Correct app version detected!$\r$\nApp version: v1.7.99 (August 2026)$\r$\n$\r$\nYou may proceed."
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Skyrim SE: Creation Kit version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.7.99 (August 2026).$\r$\n$\r$\nAborting."
        Quit
    ${EndIf}
FunctionEnd

SectionGroup /e "Downgrade Steam version (v1.7.99) to" version
    Section /o "v1.6.438.0 (April 2022)" version_1_6_438_0
        AddSize 34612
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946182"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.438.0/1946182.7z" "1946182.7z" "dfc06d6c0fc180b9f8371aeee45688de634eb01f"
        !insertmacro NSIS7Z_EXTRACT "1946182.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946183"
        Delete "flowchartx32.dll"
        Delete "SkyrimReservedAddOnIndexes.txt"
        Delete "Tools\ArtTools\Blender\bgs_skyrim_tools.zip"
        Delete "Tools\ArtTools\Blender\io_scene_bsfbx_skyrim.zip"
        Delete "Tools\AssetWatcher\AssetWatcher.exe"
        Delete "Tools\AssetWatcher\platforms\qminimal.dll"
        Delete "Tools\AssetWatcher\platforms\qoffscreen.dll"
        Delete "Tools\AssetWatcher\platforms\qwindows.dll"
        Delete "Tools\AssetWatcher\Plugins\Skyrim\BSFBXDLL.dll"
        Delete "Tools\AssetWatcher\Plugins\Skyrim\Meshes_Settings.json"
        Delete "Tools\AssetWatcher\Qt5Core.dll"
        Delete "Tools\AssetWatcher\Qt5Gui.dll"
        Delete "Tools\AssetWatcher\Qt5Network.dll"
        Delete "Tools\AssetWatcher\Qt5Svg.dll"
        Delete "Tools\AssetWatcher\Qt5Widgets.dll"
        Delete "Tools\AssetWatcher\SettingsGeneration.py"
        Delete "Tools\AssetWatcher\styles\Default.css"
        Delete "Tools\AssetWatcher\styles\qwindowsvistastyle.dll"
        Delete "Tools\Exporting Blender Art Assets for Skyrim.pdf"
        Delete "Tools\LipGen\LipFuzer\LIPFuzer.exe"
        Delete "Tools\LipGen\LipFuzer\LIPFuzer.txt"
        Delete "Tools\LipGen\LipGenerator\FonixData.cdf"
        Delete "Tools\LipGen\LipGenerator\LipGenerator.exe"
        Delete "Tools\redist\dxwebsetup.exe"
        Delete "Tools\redist\VC_redist.x64.exe"
        Delete "Tools\RoboVoicer.exe"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.438.0/1946183.7z" "1946183.7z" "a53df2d0580ac9d1217f6b37696311dc5f51d43d"
        !insertmacro NSIS7Z_EXTRACT "1946183.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.6.1130.0 (December 2023)" version_1_6_1130_0
        AddSize 8881
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946182"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.1130.0/1946182.7z" "1946182.7z" "c47b5126866f10dadd86f8554aad94a928d2a55b"
        !insertmacro NSIS7Z_EXTRACT "1946182.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946183"
        Delete "flowchartx32.dll"
        Delete "Tools\ArtTools\Blender\bgs_skyrim_tools.zip"
        Delete "Tools\ArtTools\Blender\io_scene_bsfbx_skyrim.zip"
        Delete "Tools\AssetWatcher\AssetWatcher.exe"
        Delete "Tools\AssetWatcher\platforms\qminimal.dll"
        Delete "Tools\AssetWatcher\platforms\qoffscreen.dll"
        Delete "Tools\AssetWatcher\platforms\qwindows.dll"
        Delete "Tools\AssetWatcher\Plugins\Skyrim\BSFBXDLL.dll"
        Delete "Tools\AssetWatcher\Plugins\Skyrim\Meshes_Settings.json"
        Delete "Tools\AssetWatcher\Qt5Core.dll"
        Delete "Tools\AssetWatcher\Qt5Gui.dll"
        Delete "Tools\AssetWatcher\Qt5Network.dll"
        Delete "Tools\AssetWatcher\Qt5Svg.dll"
        Delete "Tools\AssetWatcher\Qt5Widgets.dll"
        Delete "Tools\AssetWatcher\SettingsGeneration.py"
        Delete "Tools\AssetWatcher\styles\Default.css"
        Delete "Tools\AssetWatcher\styles\qwindowsvistastyle.dll"
        Delete "Tools\Exporting Blender Art Assets for Skyrim.pdf"
        Delete "Tools\redist\dxwebsetup.exe"
        Delete "Tools\redist\VC_redist.x64.exe"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.1130.0/1946183.7z" "1946183.7z" "0ddd9596bb01adab34994c17aa71412fb860db43"
        !insertmacro NSIS7Z_EXTRACT "1946183.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "v1.6.1378.1 (November 2024)" version_1_6_1378_1
        AddSize 9073
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946182"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.1378.1/1946182.7z" "1946182.7z" "62390dc8f528d3f211bed5ea28e28abb26ffaac3"
        !insertmacro NSIS7Z_EXTRACT "1946182.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946183"
        Delete "flowchartx32.dll"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/creation-kit-steam-downgrader/1.7.99_to_1.6.1378.1/1946183.7z" "1946183.7z" "e585e9d97195059888935ae2513c5c156551b9b5"
        !insertmacro NSIS7Z_EXTRACT "1946183.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "" version_common
        SetOutPath "$INSTDIR"

        # Apply xdelta patches
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
        !insertmacro XDELTA3_REMOVE
    SectionEnd
SectionGroupEnd

Section /o "Block future Steam update"
    SetOutPath "$INSTDIR\..\.."
    DetailPrint " // Block future update (appmanifest_1946180.acf)"
    SetFileAttributes "appmanifest_1946180.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "CreationKit.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${version_1_6_1378_1} ; Radio Button
    StrCpy $2 ${version_common}
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${version_1_6_438_0}
            !insertmacro RadioButton ${version_1_6_1130_0}
            !insertmacro RadioButton ${version_1_6_1378_1}
        !insertmacro EndRadioButtons
        !insertmacro SelectSection $2
    ${EndIf}
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
