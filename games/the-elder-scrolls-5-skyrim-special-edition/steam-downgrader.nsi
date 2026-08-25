!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Skyrim SE (1.7.99, August 2026). Works with all languages.$\r$\n\
$\r$\n\
It auto-detects your installed language, then downloads and applies matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade to 3 different versions (your choice):$\r$\n\
- v1.5.97 (November 2019)$\r$\n\
- v1.6.640 (September 2022)$\r$\n\
- v1.6.1170 (the n-1 version, January 2024)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Buy me a coffee? :)"
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenKofi"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Skyrim Special Edition [Steam Downgrader]"

Var /GLOBAL Game_Language

Function OnSelectedFile
    # Todo change hash with new one
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\SkyrimSE.exe" "5516489a45d63e63ad5d24c74a8b80918cf403b6" $0
     ${If} "$0" == "1"
        MessageBox MB_OK "Correct game version detected!$\r$\nGame version: v1.7.99 (August 2026)$\r$\n$\r$\nYou may proceed."
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Skyrim SE version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.7.99 (August 2026).$\r$\n$\r$\nAborting."
        Quit
    ${EndIf}

    StrCpy $Game_Language "English"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_fr0.bsa" 0 +2
        StrCpy $Game_Language "French"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_it0.bsa" 0 +2
        StrCpy $Game_Language "Italian"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_de0.bsa" 0 +2
        StrCpy $Game_Language "German"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_es0.bsa" 0 +2
        StrCpy $Game_Language "Spanish"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_ru0.bsa" 0 +2
        StrCpy $Game_Language "Russian"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_pl0.bsa" 0 +2
        StrCpy $Game_Language "Polish"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_ja0.bsa" 0 +2
        StrCpy $Game_Language "Japanese"

    ${If} $Game_Language == "English"
        # We don't have discriminating files between English and Chinese (Traditional), so let's ask the user
        MessageBox MB_YESNO|MB_DEFBUTTON2 "Is your game in Chinese (Traditional)?" IDNO +2
        StrCpy $Game_Language "Chinese (Traditional)"
    ${EndIf}

    # Ask user to confirm the detected language
    MessageBox MB_YESNO|MB_ICONQUESTION "Detected game language: $Game_Language$\r$\n$\r$\nIs this correct?" IDYES +2
    Quit
FunctionEnd

SectionGroup /e "Downgrade Steam version (v1.7.99) to" version
    Section /o "v1.5.97 (November 2019)" version_1_5_97
        AddSize 4687135
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 489831"
        Delete "Data\_ResourcePack.bsa"
        Delete "Data\_ResourcePack.esl"
        Delete "Data\ccBGSSSE001-Fish.bsa"
        Delete "Data\ccBGSSSE001-Fish.esm"
        Delete "Data\ccBGSSSE025-AdvDSGS.bsa"
        Delete "Data\ccBGSSSE025-AdvDSGS.esm"
        Delete "Data\ccBGSSSE037-Curios.bsa"
        Delete "Data\ccBGSSSE037-Curios.esl"
        Delete "Data\ccQDRSSE001-SurvivalMode.bsa"
        Delete "Data\ccQDRSSE001-SurvivalMode.esl"
        Delete "Data\MarketplaceTextures.bsa"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489831.7z.001" "489831.7z.001" "a1ed03402451d0a1ba2dd4a55193ec7cbd79cd24" 3
        !insertmacro NSIS7Z_EXTRACT "489831.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "489831.7z.001" 3

        DetailPrint " // Downloading downgrade 489832"
        Delete "bink2w64.dll"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489832.7z.001" "489832.7z.001" "3b40e2d7ff429ca6cf011fbbeabdf2d5e29d2624" 7
        !insertmacro NSIS7Z_EXTRACT "489832.7z.001" ".\" "3b40e2d7ff429ca6cf011fbbeabdf2d5e29d2624"
        !insertmacro DELETE_RANGE "489832.7z.001" 7

        DetailPrint " // Downloading downgrade 489833"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489833.7z" "489833.7z" "e938f0dbddad93f451f1ac4d74250794f5f72db8"
        !insertmacro NSIS7Z_EXTRACT "489833.7z" ".\" "AUTO_DELETE"

        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 489834 (French)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489834.7z.001" "489834.7z.001" "e642aea4240a3b06b0dfc960e67130d1d31dd39f" 3
            !insertmacro NSIS7Z_EXTRACT "489834.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489834.7z.001" 3

        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 489835 (Italian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489835.7z.001" "489835.7z.001" "283370d2a720a35cb86539f0358e02ae4ccaf603" 3
            !insertmacro NSIS7Z_EXTRACT "489835.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489835.7z.001" 3

        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 489836 (German)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489836.7z.001" "489836.7z.001" "93786aff0ac2c120e5146586bd55c2b171393d29" 3
            !insertmacro NSIS7Z_EXTRACT "489836.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489836.7z.001" 3

        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 489837 (Spanish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489837.7z.001" "489837.7z.001" "b3672116409c7da72a6c27c9669bd1357059bfe4" 3
            !insertmacro NSIS7Z_EXTRACT "489837.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489837.7z.001" 3

        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 489838 (Russian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489838.7z.001" "489838.7z.001" "4f1eb5c2d882f224cac0559fd1bdf6e1d10f48c1" 2
            !insertmacro NSIS7Z_EXTRACT "489838.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489838.7z.001" 2

        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 489839 (Polish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/489839.7z.001" "489839.7z.001" "54c0aacd96de17b119e8e3ae80ef34d8b945a8bf" 2
            !insertmacro NSIS7Z_EXTRACT "489839.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489839.7z.001" 2

        ${ElseIf} $Game_Language == "Chinese (Traditional)"
            DetailPrint " // Downloading downgrade 544860 (Chinese Traditional)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/544860.7z" "544860.7z" "d561af144e244bddcda57fd764494cb42508420b"
            !insertmacro NSIS7Z_EXTRACT "544860.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 544861 (Japanese)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.5.97/544861.7z.001" "544861.7z.001" "df9040eeb7df9c8fe9a073b7221a081622f087fb" 3
            !insertmacro NSIS7Z_EXTRACT "544861.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "544861.7z.001" 3
        ${EndIf}
    SectionEnd

    Section /o "v1.6.640 (September 2022)" version_1_6_640
        AddSize 1195377
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 489831"
        Delete "Data\_ResourcePack.bsa"
        Delete "Data\_ResourcePack.esl"
        Delete "Data\MarketplaceTextures.bsa"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489831.7z.001" "489831.7z.001" "c56ab0bf9d381f32a6e2e0015de9d4ab76cc1a20" 3
        !insertmacro NSIS7Z_EXTRACT "489831.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "489831.7z.001" 3

        DetailPrint " // Downloading downgrade 489832"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489832.7z" "489832.7z" "3dfafe25980361f9e62cecf1c280ab48c7bc25ce"
        !insertmacro NSIS7Z_EXTRACT "489832.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489833"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489833.7z" "489833.7z" "acc486858a60c7edc77dac3e0bebaa7988d87472"
        !insertmacro NSIS7Z_EXTRACT "489833.7z" ".\" "AUTO_DELETE"

        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 489834 (French)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489834.7z.001" "489834.7z.001" "537743eca56cbabecefd3fa5e3ce89f986e24754" 3
            !insertmacro NSIS7Z_EXTRACT "489834.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489834.7z.001" 3

        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 489835 (Italian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489835.7z.001" "489835.7z.001" "5931e49806c7d42a11865f88e31136df6daca9a6" 3
            !insertmacro NSIS7Z_EXTRACT "489835.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489835.7z.001" 3

        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 489836 (German)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489836.7z.001" "489836.7z.001" "903b69bddcc4fe83676772fbf8c487e9d55a14e4" 3
            !insertmacro NSIS7Z_EXTRACT "489836.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489836.7z.001" 3

        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 489837 (Spanish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489837.7z.001" "489837.7z.001" "d348cde03f344cd770d001fedb5eaa10c061427a" 3
            !insertmacro NSIS7Z_EXTRACT "489837.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489837.7z.001" 3

        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 489838 (Russian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489838.7z.001" "489838.7z.001" "f2fb33c7746ec220a88dbb3f8bc47c0ffb457cbd" 2
            !insertmacro NSIS7Z_EXTRACT "489838.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489838.7z.001" 2

        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 489839 (Polish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489839.7z.001" "489839.7z.001" "331c499e35053f0b6183cbae8672f43598ab3eae" 2
            !insertmacro NSIS7Z_EXTRACT "489839.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489839.7z.001" 2

        ${ElseIf} $Game_Language == "Chinese (Traditional)"
            DetailPrint " // Downloading downgrade 544860 (Chinese Traditional)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/544860.7z" "544860.7z" "313fbaee08f670badf79d5e4934768c9333fc3db"
            !insertmacro NSIS7Z_EXTRACT "544860.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 544861 (Japanese)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/544861.7z.001" "544861.7z.001" "b8a6754b383892b460dc4e4e5811ba688039c386" 3
            !insertmacro NSIS7Z_EXTRACT "544861.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "544861.7z.001" 3
        ${EndIf}
    SectionEnd

    Section "v1.6.1170 (January 2024)" version_1_6_1170
        AddSize 1132462
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 489831"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.1170/489831.7z.001" "489831.7z.001" "ed06fc1b1713789e7697472d414678e088c52288" 2
        !insertmacro NSIS7Z_EXTRACT "489831.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "489831.7z.001" 2

        DetailPrint " // Downloading downgrade 489832"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.1170/489832.7z" "489832.7z" "d8ce071753b01947c9d23e5669c3a96141545bb6"
        !insertmacro NSIS7Z_EXTRACT "489832.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489833"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.1170/489833.7z" "489833.7z" "0005f930854cf0b1de7c3f4488c8b90399e44720"
        !insertmacro NSIS7Z_EXTRACT "489833.7z" ".\" "AUTO_DELETE"

        # Languages manifests for v1.6.1170 are the same as for v1.6.640, so we can reuse the same xdelta patches.
        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 489834 (French)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489834.7z.001" "489834.7z.001" "537743eca56cbabecefd3fa5e3ce89f986e24754" 3
            !insertmacro NSIS7Z_EXTRACT "489834.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489834.7z.001" 3

        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 489835 (Italian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489835.7z.001" "489835.7z.001" "5931e49806c7d42a11865f88e31136df6daca9a6" 3
            !insertmacro NSIS7Z_EXTRACT "489835.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489835.7z.001" 3

        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 489836 (German)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489836.7z.001" "489836.7z.001" "903b69bddcc4fe83676772fbf8c487e9d55a14e4" 3
            !insertmacro NSIS7Z_EXTRACT "489836.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489836.7z.001" 3

        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 489837 (Spanish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489837.7z.001" "489837.7z.001" "d348cde03f344cd770d001fedb5eaa10c061427a" 3
            !insertmacro NSIS7Z_EXTRACT "489837.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489837.7z.001" 3

        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 489838 (Russian)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489838.7z.001" "489838.7z.001" "f2fb33c7746ec220a88dbb3f8bc47c0ffb457cbd" 2
            !insertmacro NSIS7Z_EXTRACT "489838.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489838.7z.001" 2

        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 489839 (Polish)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/489839.7z.001" "489839.7z.001" "331c499e35053f0b6183cbae8672f43598ab3eae" 2
            !insertmacro NSIS7Z_EXTRACT "489839.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "489839.7z.001" 2

        ${ElseIf} $Game_Language == "Chinese (Traditional)"
            DetailPrint " // Downloading downgrade 544860 (Chinese Traditional)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/544860.7z" "544860.7z" "313fbaee08f670badf79d5e4934768c9333fc3db"
            !insertmacro NSIS7Z_EXTRACT "544860.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 544861 (Japanese)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.7.99_to_1.6.640/544861.7z.001" "544861.7z.001" "b8a6754b383892b460dc4e4e5811ba688039c386" 3
            !insertmacro NSIS7Z_EXTRACT "544861.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "544861.7z.001" 3
        ${EndIf}
    SectionEnd

    Section "" version_common
        # Common for both downgrades
        SetOutPath "$INSTDIR"

        # Some users reported crashes when Creations content was installed. The issue appears to depend on which Creations content is installed.
        # Since the format of ContentCatalog.txt changed in v1.7.99, renaming it will force the game to generate a new one.
        DetailPrint " // Checking ContentCatalog.txt for potential crash issues"
        !insertmacro FILE_STR_CONTAINS "$LOCALAPPDATA\Skyrim Special Edition\ContentCatalog.txt" "AchievementSafe" $9
        ${If} $9 == "1"
            DetailPrint "Found ContentCatalog.txt in new format (v1.7.99)"
            MessageBox MB_YESNO|MB_DEFBUTTON1 "It looks like you have a ContentCatalog.txt in the new format (v1.7.99). This may cause crashes with downgraded version.$\r$\n$\r$\nDo you want to rename it to ContentCatalog.bak? (recommended)" IDNO skip_rename
            !insertmacro FORCE_RENAME "$LOCALAPPDATA\Skyrim Special Edition\ContentCatalog.txt" "$LOCALAPPDATA\Skyrim Special Edition\ContentCatalog.bak"
            skip_rename:
        ${EndIf}

        # Another potential crash fix
        RMDIR /r "$INSTDIR\Data\ShaderCache"

        # Apply xdelta patches
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
        !insertmacro XDELTA3_REMOVE
    SectionEnd
SectionGroupEnd

Section /o "Block future Steam update"
    SetOutPath "$INSTDIR\..\.."
    DetailPrint " // Block future update (appmanifest_489830.acf)"
    SetFileAttributes "appmanifest_489830.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "SkyrimSE.exe"
    StrCpy $SELECT_STEAM_FOLDER "Skyrim Special Edition"
    StrCpy $1 ${version_1_6_1170} ; Radio Button
    StrCpy $2 ${version_common}
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${version_1_5_97}
            !insertmacro RadioButton ${version_1_6_640}
            !insertmacro RadioButton ${version_1_6_1170}
        !insertmacro EndRadioButtons
        !insertmacro SelectSection $2
    ${EndIf}
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
