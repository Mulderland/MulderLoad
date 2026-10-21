!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4: Creation Kit (1.11.246, October 2026).$\r$\n\
$\r$\n\
WARNING: this is for the Creation Kit only! The game downgrader is also available at www.mulderland.com$\r$\n\
$\r$\n\
It can downgrade to 5 different versions (your choice):$\r$\n\
- v1.10.162.0 (April 2022)$\r$\n\
- v1.10.982.3 (May 2024)$\r$\n\
- v1.11.137.0 (November 2025)$\r$\n\
- v1.11.221.0 (May 2026)$\r$\n\
- v1.11.240.0 (August 2026, the n-1 version)$\r$\n\
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
    !insertmacro STACKFRAME_BEGIN 0 2
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\CreationKit.exe" "6acfc678a621b136ae00f9441e8fe126889a0df6" $R0
     ${If} "$R0" == "1"
        MessageBox MB_OK "Correct app version detected!$\r$\nApp version: v1.11.246 (October 2026)$\r$\n$\r$\nYou may proceed."
        StrCpy $R1 1
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4: Creation Kit version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.246 (October 2026)"
        StrCpy $R1 0
    ${EndIf}
    !insertmacro STACKFRAME_RETURN 0 2 $R1
    !insertmacro STACKFRAME_END 0 2
FunctionEnd

SectionGroup /e "Downgrade Steam version (v1.11.246) to" version
    Section /o "v1.10.162.0 (April 2022)" version_1_10_162_0
        AddSize 62741
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.10.162.0/1946161.7z" "1946161.7z" "a8008c911a3fb67929ae75a9f069c58c7dd03139"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        Delete "Tools\LipGen\LipGenerator\FonixData.cdf"
        Delete "Tools\LipGen\LipGenerator\LipGenerator.exe"
        Delete "Tools\LipGen\LipGenerator\LipGenerator.pdb"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.10.162.0/1946162.7z" "1946162.7z" "8049a1a1ee10c88b1826b74be673af242befd3f6"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.10.982.3 (May 2024)" version_1_10_982_3
        AddSize 13767
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.10.982.3/1946161.7z" "1946161.7z" "c1c965ae65aaee9753a40207de34edd9e5f34240"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.10.982.3/1946162.7z" "1946162.7z" "367088884abbf19f99943012f0cf03f27e5c1b19"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.11.137.0 (November 2025)" version_1_11_137_0
        AddSize 12182
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.137.0/1946161.7z" "1946161.7z" "00c6f0345223012e8c98d76deba92175570ec5bb"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.137.0/1946162.7z" "1946162.7z" "a280a2b2b1df3587a9eaf1cc0662f5db9a7fe82f"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "v1.11.221.0 (May 2026)" version_1_11_221_0
        AddSize 12159
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.221.0/1946161.7z" "1946161.7z" "c6e1272a65b8872f956eb1e22612d286eaa61328"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        Delete "Tools\Elric\DDS_to_TGA.bat"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.221.0/1946162.7z" "1946162.7z" "da9083bfd94333f5c193777dba7d6b1fe303ebc9"
        !insertmacro NSIS7Z_EXTRACT "1946162.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "v1.11.240.0 (August 2026)" version_1_11_240_0
        AddSize 12002
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 1946161"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.240.0/1946161.7z" "1946161.7z" "a6bf0e3be860441434cdc2b95fa1baea959e839c"
        !insertmacro NSIS7Z_EXTRACT "1946161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 1946162"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/creation-kit-steam-downgrader/1.11.246.0_to_1.11.240.0/1946162.7z" "1946162.7z" "8e656b922cd9113d63c3e3f5d99ca63c7f885c8e"
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
    StrCpy $1 ${version_1_11_240_0} ; Radio Button
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
            !insertmacro RadioButton ${version_1_11_240_0}
        !insertmacro EndRadioButtons
        !insertmacro SelectSection $2
    ${EndIf}
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
