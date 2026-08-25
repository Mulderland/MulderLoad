!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4: Creation Kit (1.11.240, August 2026).$\r$\n\
$\r$\n\
WARNING: this is for the Creation Kit only! The game downgrader is also available at www.mulderland.com$\r$\n\
$\r$\n\
It can downgrade to 4 different versions (your choice):$\r$\n\
- v1.10.162.0 (April 2022)$\r$\n\
- v1.10.982.3 (May 2024)$\r$\n\
- v1.11.137.0 (November 2025)$\r$\n\
- v1.11.221.0 (May 2026, the n-1 version)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Buy me a coffee? :)"
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenKofi"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4: Creation Kit [Steam Downgrader]"

Function OnSelectedFile
    # Todo change hash with new one
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\CreationKit.exe" "05accf35db49b99c8f61bf56b022881127ae112f" $0
     ${If} "$0" == "1"
        MessageBox MB_OK "Correct app version detected!$\r$\nApp version: v1.11.240 (August 2026)$\r$\n$\r$\nYou may proceed."
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4: Creation Kit version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.240 (August 2026).$\r$\n$\r$\nAborting."
        Quit
    ${EndIf}
FunctionEnd

SectionGroup /e "Downgrade Steam version (v1.11.240) to" version
    Section /o "v1.10.162.0 (April 2022)" version_1_10_162_0
        AddSize 62749
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.10.162.0/1946161.7z" "1946161.7z" "d6c287b5ac247d456b43940c9c182691823bd019"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        Delete "Tools\LipGen\LipGenerator\FonixData.cdf"
        Delete "Tools\LipGen\LipGenerator\LipGenerator.exe"
        Delete "Tools\LipGen\LipGenerator\LipGenerator.pdb"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.10.162.0/1946162.7z" "1946162.7z" "4f0377c2fa09ebdc57f18903969df2c9643eb137"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.10.982.3 (May 2024)" version_1_10_982_3
        AddSize 13732
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.10.982.3/1946161.7z" "1946161.7z" "fd9984c4d5b30eee66e1b0f281d1e752017f5882"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.10.982.3/1946162.7z" "1946162.7z" "a65e0454eb7e33a56829b807cfbc3c25c859f46d"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.11.137.0 (November 2025)" version_1_11_137_0
        AddSize 12151
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.11.137.0/1946161.7z" "1946161.7z" "099de315c3464726d5caaf8772f893025a8c509c"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.11.137.0/1946162.7z" "1946162.7z" "8972fcb012c8fd48b317ff692c29ecb6de8b92a2"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "v1.11.221.0 (May 2026)" version_1_11_221_0
        AddSize 12146
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.11.221.0/1946161.7z" "1946161.7z" "0811ff473fc7bf833f5c34fbf7c48013d95f52b2"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.240.0_to_1.11.221.0/1946162.7z" "1946162.7z" "43a6a6a223432d0f06e8183aa33d30d3ac1b362d"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
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
    DetailPrint " // Block future update (appmanifest_1946160.acf)"
    SetFileAttributes "appmanifest_1946160.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "CreationKit.exe"
    StrCpy $SELECT_STEAM_FOLDER "Fallout 4"
    StrCpy $1 ${version_1_11_221_0} ; Radio Button
    StrCpy $2 ${version_common}
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${version_1_10_162_0}
            !insertmacro RadioButton ${version_1_10_982_3}
            !insertmacro RadioButton ${version_1_11_137_0}
            !insertmacro RadioButton ${version_1_11_221_0}
        !insertmacro EndRadioButtons
        !insertmacro SelectSection $2
    ${EndIf}
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
