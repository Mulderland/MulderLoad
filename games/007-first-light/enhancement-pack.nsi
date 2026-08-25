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

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=577" \
                            "70_farther_default.zip" \
                            "7b1bb3cb1fe5823e2e16074ff6d5967f0c058a4a"
    !insertmacro NSISUNZ_EXTRACT "70_farther_default.zip" ".\70_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=588" \
                            "70_farther_higher.zip" \
                            "3c2ba0f98ac5221d503ca7ce2212007003f2f0d1"
    !insertmacro NSISUNZ_EXTRACT "70_farther_higher.zip" ".\70_farther_higher\" "AUTO_DELETE"

    # FOV 80
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=585" \
                            "80_default_default.zip" \
                            "5ea410f83af2d754c57d294e62a2e1bfb96df8ed"
    !insertmacro NSISUNZ_EXTRACT "80_default_default.zip" ".\80_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=586" \
                            "80_farther_default.zip" \
                            "75043a378129d2c8cf3c9f46f828f0e72c4e9d51"
    !insertmacro NSISUNZ_EXTRACT "80_farther_default.zip" ".\80_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=591" \
                            "80_farther_higher.zip" \
                            "af6e8918e6ff1cc21ff25df945b698a1e5bd2f3e"
    !insertmacro NSISUNZ_EXTRACT "80_farther_higher.zip" ".\80_farther_higher\" "AUTO_DELETE"

    # FOV 90
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=576" \
                            "90_closer_default.zip" \
                            "52d182d7d7c03a22147ced58c2b3d51d54bfddb2"
    !insertmacro NSISUNZ_EXTRACT "90_closer_default.zip" ".\90_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=587" \
                            "90_closer_higher.zip" \
                            "95e2e005879ae07174213a681b1df925249c3ceb"
    !insertmacro NSISUNZ_EXTRACT "90_closer_higher.zip" ".\90_closer_higher\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=581" \
                            "90_default_default.zip" \
                            "2596142c1fa03414c21fdcdf3454113de564e865"
    !insertmacro NSISUNZ_EXTRACT "90_default_default.zip" ".\90_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=582" \
                            "90_farther_default.zip" \
                            "a895d98f462d0d24c63573cbdbc0e5bf7e068bed"
    !insertmacro NSISUNZ_EXTRACT "90_farther_default.zip" ".\90_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=592" \
                            "90_farther_higher.zip" \
                            "5aca5ba89c63e8e34ac75f62e0b683e4d1533a8b"
    !insertmacro NSISUNZ_EXTRACT "90_farther_higher.zip" ".\90_farther_higher\" "AUTO_DELETE"

    # FOV 100
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=584" \
                            "100_closer_default.zip" \
                            "372f5f3220928634b6acc94d3cd9f12fd0103572"
    !insertmacro NSISUNZ_EXTRACT "100_closer_default.zip" ".\100_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=590" \
                            "100_closer_higher.zip" \
                            "364faa1a1440324f39759c228dc91f075d59b4e1"
    !insertmacro NSISUNZ_EXTRACT "100_closer_higher.zip" ".\100_closer_higher\" "AUTO_DELETE"

    # FOV 110
    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=583" \
                            "110_closer_default.zip" \
                            "c9be58bebbb026c66b7e4bc31c29851abf7b6b62"
    !insertmacro NSISUNZ_EXTRACT "110_closer_default.zip" ".\110_closer_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=589" \
                            "110_closer_higher.zip" \
                            "9fa6d72f4ff18fa2d6b686368dbc2ebb12f5152e"
    !insertmacro NSISUNZ_EXTRACT "110_closer_higher.zip" ".\110_closer_higher\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=580" \
                            "110_default_default.zip" \
                            "b44a96d433a5d19bae955180ebe8348789a11d71"
    !insertmacro NSISUNZ_EXTRACT "110_default_default.zip" ".\110_default_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=579" \
                            "110_farther_default.zip" \
                            "76d859535d2c149a45d65d75ccb75186124336cb"
    !insertmacro NSISUNZ_EXTRACT "110_farther_default.zip" ".\110_farther_default\" "AUTO_DELETE"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/007firstlight/mods/15?tab=files&file_id=593" \
                            "110_farther_higher.zip" \
                            "ae7ee51cb1cbd5f05c2e873f8eb3328dd8c725aa"
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
