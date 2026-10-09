!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for 007: First Light, which can$\r$\n\
- Adjust the FOV and camera settings (by Su4enka)$\r$\n\
- Fix cutscenes on ultrawide displays$\r$\n\
- Provide a more immersive HUD (by Charc0al)$\r$\n\
- Skip the intro (by Su4enka)$\r$\n\
$\r$\n\
Everything is configurable via the MulderConfig UI.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Su4enka and Charc0al!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "007: First Light [Enhancement Pack]"

Section "Higher FOV and Camera (by Su4enka)"
    AddSize 88371
    SetOutPath "$INSTDIR\.MulderConfig\HigherFOVAndCamera"

    # FOV 70

    # No need to fetch the "70_default_default": https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=578
    # MulderConfig will just disable the mod instead

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=687" \
                            "70_farther_default.zip" \
                            "673d08b8b683d500166c43f725173c1fb517fcaf"
    !insertmacro NSISUNZ_EXTRACT "70_farther_default.zip" ".\70_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=698" \
                            "70_farther_higher.zip" \
                            "7c02b0e05838006c962daf1c5587eca973d5237a"
    !insertmacro NSISUNZ_EXTRACT "70_farther_higher.zip" ".\70_farther_higher\" "AUTO_DELETE"

    # FOV 80
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=695" \
                            "80_default_default.zip" \
                            "2dd2c009c41339631f65e3e15ca281787c33fff3"
    !insertmacro NSISUNZ_EXTRACT "80_default_default.zip" ".\80_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=696" \
                            "80_farther_default.zip" \
                            "0c19998b34fae33aa2c6d96785a0861ee15169ac"
    !insertmacro NSISUNZ_EXTRACT "80_farther_default.zip" ".\80_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=701" \
                            "80_farther_higher.zip" \
                            "6918899dd49b094a557dc4f1e19b7889a1869d73"
    !insertmacro NSISUNZ_EXTRACT "80_farther_higher.zip" ".\80_farther_higher\" "AUTO_DELETE"

    # FOV 90
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=686" \
                            "90_closer_default.zip" \
                            "87b9443f50629010bc7fed75b8c09558ad7e9913"
    !insertmacro NSISUNZ_EXTRACT "90_closer_default.zip" ".\90_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=697" \
                            "90_closer_higher.zip" \
                            "298b7033522c7f67451add8323b4d379fcd7491d"
    !insertmacro NSISUNZ_EXTRACT "90_closer_higher.zip" ".\90_closer_higher\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=691" \
                            "90_default_default.zip" \
                            "eed9a0ea9940fef2a6da7d32f77daa05516ddeb8"
    !insertmacro NSISUNZ_EXTRACT "90_default_default.zip" ".\90_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=692" \
                            "90_farther_default.zip" \
                            "0317ed85919e866eb43547acadbffe7b7113f743"
    !insertmacro NSISUNZ_EXTRACT "90_farther_default.zip" ".\90_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=702" \
                            "90_farther_higher.zip" \
                            "dd677e55ee9a8a0f55037df5269681d18853b417"
    !insertmacro NSISUNZ_EXTRACT "90_farther_higher.zip" ".\90_farther_higher\" "AUTO_DELETE"

    # FOV 100
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=694" \
                            "100_closer_default.zip" \
                            "3232fc30dff0048604b4a9e39db01adfd6f4b41c"
    !insertmacro NSISUNZ_EXTRACT "100_closer_default.zip" ".\100_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=700" \
                            "100_closer_higher.zip" \
                            "0050d2f77c865cb768393acf47d7a1e76606a37c"
    !insertmacro NSISUNZ_EXTRACT "100_closer_higher.zip" ".\100_closer_higher\" "AUTO_DELETE"

    # FOV 110
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=693" \
                            "110_closer_default.zip" \
                            "a189871096d864d3f0d47288b902d0101c068f45"
    !insertmacro NSISUNZ_EXTRACT "110_closer_default.zip" ".\110_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=699" \
                            "110_closer_higher.zip" \
                            "e4874e9fb8c3c0d8fa858c6b39aa8ed56de6143a"
    !insertmacro NSISUNZ_EXTRACT "110_closer_higher.zip" ".\110_closer_higher\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=690" \
                            "110_default_default.zip" \
                            "bd7678b0a14e4bced92e1abd0ec162fcac2c53a3"
    !insertmacro NSISUNZ_EXTRACT "110_default_default.zip" ".\110_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=689" \
                            "110_farther_default.zip" \
                            "1a757c0e19282b7f0941b7235d028da13087cdf3"
    !insertmacro NSISUNZ_EXTRACT "110_farther_default.zip" ".\110_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=703" \
                            "110_farther_higher.zip" \
                            "714b17401e3282347e9e7d82699fdf872c70a433"
    !insertmacro NSISUNZ_EXTRACT "110_farther_higher.zip" ".\110_farther_higher\" "AUTO_DELETE"
SectionEnd

Section "Immersive HUD (by Charc0al)"
    AddSize 13005
    SetOutPath "$INSTDIR\.MulderConfig\ImmersiveHUD\Runtime"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/60?tab=files&file_id=436" \
                            "Immersive HUD.zip" \
                            "b891fa89cb2d5f82ad8fef69842066c65ba41346"
    !insertmacro NSISUNZ_EXTRACT "Immersive HUD.zip" ".\" "AUTO_DELETE"
SectionEnd

Section "Skip Intro (by Su4enka)"
    AddSize 85783
    SectionIn RO
    SetOutPath "$INSTDIR\.MulderConfig\SkipIntro"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/12?tab=files&file_id=25" \
                            "SkipIntro.zip" \
                            "6ec072153fbd6262ef5e8247a445ffef083079c1"

    !insertmacro NSISUNZ_EXTRACT "SkipIntro.zip" ".\" "AUTO_DELETE"

    !insertmacro FORCE_RENAME "$INSTDIR\.MulderConfig\SkipIntro\Runtime\packagedefinition.txt" "$INSTDIR\Runtime\packagedefinition.txt"
SectionEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "007FirstLight.exe"
    StrCpy $SELECT_RELATIVE_PATH "Retail"
    StrCpy $SELECT_STEAM_FOLDER "007 First Light"
FunctionEnd
