!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Skyrim SE (1.?.????, August 26). Works with all languages.$\r$\n\
$\r$\n\
It auto-detects your installed language, then downloads and applies matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade your game to 1.6.1170, the n-1 version from January 2024.$\r$\n\
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
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\SkyrimSE.exe" "1c9636207b4613254b03d76c410540e10b539dc9" $0
     ${If} "$0" == "1"
        MessageBox MB_OK "Correct game version detected!$\r$\nGame version: v1.?.???? (August 2026)$\r$\n$\r$\nYou may proceed."
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Skyrim SE version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.?.???? (August 2026).$\r$\n$\r$\nAborting."
        Quit
    ${EndIf}

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_fr0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "French"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_it0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "Italian"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_de0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "German"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_es0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "Spanish"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_ru0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "Russian"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_pl0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "Polish"

    IfFileExists "$INSTDIR\Data\Skyrim - Voices_ja0.bsa" 0 lang_detection_end
        StrCpy $Game_Language "Japanese"

    # Auto-detection doesn't work for Chinese, so we ask the user to select it manually
    MessageBox MB_YESNO|MB_DEFBUTTON2 "Is your game in Traditional Chinese?" IDYES lang_yes IDNO lang_no
    lang_yes:
        StrCpy $Game_Language "Traditional Chinese"
        Goto lang_detection_end
    lang_no:
        StrCpy $Game_Language "English"

    # Ask user to confirm the detected language
    lang_detection_end:
    MessageBox MB_YESNO|MB_ICONQUESTION "Detected game language: $Game_Language$\r$\n$\r$\nIs this correct?" IDYES +2
    Quit
FunctionEnd

SectionGroup /e "Downgrade Steam version (v?.?.????) to" version
    Section /o "v1.5.97 (November 2019)" version_1_5_97
        AddSize 1
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 489831"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489831.7z" "489831.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489831.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489832"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489832.7z" "489832.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489832.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489833"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489833.7z" "489833.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489833.7z" ".\" "AUTO_DELETE"

        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 489834 (French)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489834.7z" "489834.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489834.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 489835 (Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489835.7z" "489835.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489835.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 489836 (German)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489836.7z" "489836.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489836.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 489837 (Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489837.7z" "489837.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489837.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 489838 (Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489838.7z" "489838.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489838.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 489839 (Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/489839.7z" "489839.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489839.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Traditional Chinese"
            DetailPrint " // Downloading downgrade 544860 (Traditional Chinese)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/544860.7z" "544860.7z" ""
            !insertmacro NSIS7Z_EXTRACT "544860.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 544861 (Japanese)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.5.97/544861.7z" "544861.7z" ""
            !insertmacro NSIS7Z_EXTRACT "544861.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section "v1.6.1170 (January 2024)" version_1_6_1170
        AddSize 1
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 489831"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489831.7z" "489831.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489831.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489832"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489832.7z" "489832.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489832.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 489833"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489833.7z" "489833.7z" ""
        !insertmacro NSIS7Z_EXTRACT "489833.7z" ".\" "AUTO_DELETE"

        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 489834 (French)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489834.7z" "489834.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489834.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 489835 (Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489835.7z" "489835.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489835.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 489836 (German)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489836.7z" "489836.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489836.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 489837 (Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489837.7z" "489837.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489837.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 489838 (Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489838.7z" "489838.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489838.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 489839 (Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/489839.7z" "489839.7z" ""
            !insertmacro NSIS7Z_EXTRACT "489839.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Traditional Chinese"
            DetailPrint " // Downloading downgrade 544860 (Traditional Chinese)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/544860.7z" "544860.7z" ""
            !insertmacro NSIS7Z_EXTRACT "544860.7z" ".\" "AUTO_DELETE"

        ${ElseIf} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 544861 (Japanese)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/the-elder-scrolls-5-skyrim-special-edition/steam-downgrader/1.?.????_to_1.6.1170/544861.7z" "544861.7z" ""
            !insertmacro NSIS7Z_EXTRACT "544861.7z" ".\" "AUTO_DELETE"

        ${EndIf}
    SectionEnd

    Section
        SetOutPath "$INSTDIR"
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
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${version_1_6_1170} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${version_1_5_97}
            !insertmacro RadioButton ${version_1_6_1170}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
