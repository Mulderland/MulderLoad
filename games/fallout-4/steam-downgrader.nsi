!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (v1.11.240, August 2026). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language* and your installed DLCs, then downloads matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade to 4 different versions (your choice):$\r$\n\
- v1.10.163 (Pre-Next-Gen - 2019)$\r$\n\
- v1.10.984 (Next-Gen Update 2 - 2024)$\r$\n\
- v1.11.191 (Anniversary - December 2025)$\r$\n\
- v1.11.221 (Anniversary - May 2026)$\r$\n\
$\r$\n\
*WARNING (for Chinese): Chinese language can't be auto detected, so you'll have to select $\"Chinese$\" during setup.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.240) to" version
    Section
        StrCpy $DLC_Automatron "no"
        StrCpy $DLC_Workshop "no"

        IfFileExists "$INSTDIR\Data\DLCRobot.cdx" 0 +2
            StrCpy $DLC_Automatron "yes"

        IfFileExists "$INSTDIR\Data\DLCworkshop01.cdx" 0 +2
            StrCpy $DLC_Workshop "yes"
    SectionEnd

    Section "v1.10.163 (Pre-Next-Gen)" version_1_10_163
        AddSize 10485760
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377161.7z" "377161.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377162.7z" "377162.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\ccBGSFO4044-HellfirePowerArmor.esl"
        Delete "Data\ccBGSFO4046-TesCan - Main.ba2"
        Delete "Data\ccBGSFO4046-TesCan - Textures.ba2"
        Delete "Data\ccBGSFO4046-TesCan.esl"
        Delete "Data\ccBGSFO4096-AS_Enclave - Main.ba2"
        Delete "Data\ccBGSFO4096-AS_Enclave - Textures.ba2"
        Delete "Data\ccBGSFO4096-AS_Enclave.esl"
        Delete "Data\ccBGSFO4110-WS_Enclave - Main.ba2"
        Delete "Data\ccBGSFO4110-WS_Enclave - Textures.ba2"
        Delete "Data\ccBGSFO4110-WS_Enclave.esl"
        Delete "Data\ccBGSFO4115-X02 - Main.ba2"
        Delete "Data\ccBGSFO4115-X02 - Textures.ba2"
        Delete "Data\ccBGSFO4115-X02.esl"
        Delete "Data\ccBGSFO4116-HeavyFlamer - Main.ba2"
        Delete "Data\ccBGSFO4116-HeavyFlamer - Textures.ba2"
        Delete "Data\ccBGSFO4116-HeavyFlamer.esl"
        Delete "Data\ccFSVFO4007-Halloween - Main.ba2"
        Delete "Data\ccFSVFO4007-Halloween - Textures.ba2"
        Delete "Data\ccFSVFO4007-Halloween.esl"
        Delete "Data\ccOTMFO4001-Remnants - Main.ba2"
        Delete "Data\ccOTMFO4001-Remnants - Textures.ba2"
        Delete "Data\ccOTMFO4001-Remnants.esl"
        Delete "Data\ccSBJFO4003-Grenade - Main.ba2"
        Delete "Data\ccSBJFO4003-Grenade - Textures.ba2"
        Delete "Data\ccSBJFO4003-Grenade.esl"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        Delete "Fallout4IDs.ccc"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377163.7z.001" "377163.7z.001" "" 22
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 22

        ${If} $F4_Language == "fr"
            DetailPrint " // Downloading downgrade 377165 (Base game, French)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377165.7z" "377165.7z" ""
            !insertmacro NSIS7Z_EXTRACT "377165.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "de"
            DetailPrint " // Downloading downgrade 377166 (Base game, German)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377166.7z" "377166.7z" ""
            !insertmacro NSIS7Z_EXTRACT "377166.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "it"
            DetailPrint " // Downloading downgrade 377167 (Base game, Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377167.7z" "377167.7z" ""
            !insertmacro NSIS7Z_EXTRACT "377167.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "es"
            DetailPrint " // Downloading downgrade 377168 (Base game, Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377168.7z" "377168.7z" ""
            !insertmacro NSIS7Z_EXTRACT "377168.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "pl"
            DetailPrint " // Downloading downgrade 393880 (Base game, Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393880.7z" "393880.7z" ""
            !insertmacro NSIS7Z_EXTRACT "393880.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ru"
            DetailPrint " // Downloading downgrade 393881 (Base game, Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393881.7z" "393881.7z" ""
            !insertmacro NSIS7Z_EXTRACT "393881.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ptbr"
            DetailPrint " // Downloading downgrade 393882 (Base game, Portuguese-Brazil)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393882.7z" "393882.7z" ""
            !insertmacro NSIS7Z_EXTRACT "393882.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "cn"
            DetailPrint " // Downloading downgrade 393883 (Base game, Chinese-Traditional)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393883.7z.001" "393883.7z.001" "" 6
            !insertmacro NSIS7Z_EXTRACT "393883.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393883.7z.001" 6
        ${ElseIf} $F4_Language == "ja"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            Rename "Data\Video\AGILITY_ja.bk2" "Data\Video\AGILITY.bk2"
            Rename "Data\Video\CHARISMA_ja.bk2" "Data\Video\CHARISMA.bk2"
            Rename "Data\Video\Endgame_FEMALE_A_ja.bk2" "Data\Video\Endgame_FEMALE_A.bk2"
            Rename "Data\Video\Endgame_FEMALE_B_ja.bk2" "Data\Video\Endgame_FEMALE_B.bk2"
            Rename "Data\Video\Endgame_MALE_A_ja.bk2" "Data\Video\Endgame_MALE_A.bk2"
            Rename "Data\Video\Endgame_MALE_B_ja.bk2" "Data\Video\Endgame_MALE_B.bk2"
            Rename "Data\Video\ENDURANCE_ja.bk2" "Data\Video\ENDURANCE.bk2"
            Rename "Data\Video\GameIntro_V3_B_ja.bk2" "Data\Video\GameIntro_V3_B.bk2"
            Rename "Data\Video\INTELLIGENCE_ja.bk2" "Data\Video\INTELLIGENCE.bk2"
            Rename "Data\Video\Intro_ja.bk2" "Data\Video\Intro.bk2"
            Rename "Data\Video\LUCK_ja.bk2" "Data\Video\LUCK.bk2"
            Rename "Data\Video\PERCEPTION_ja.bk2" "Data\Video\PERCEPTION.bk2"
            Rename "Data\Video\STRENGTH_ja.bk2" "Data\Video\STRENGTH.bk2"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393884.7z.001" "393884.7z.001" "" 4
            !insertmacro NSIS7Z_EXTRACT "393884.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393884.7z.001" 4
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            DetailPrint " // Downloading downgrade 435870 (Automatron DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435870.7z" "435870.7z" ""
            !insertmacro NSIS7Z_EXTRACT "435870.7z" ".\" "AUTO_DELETE"

            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/404091.7z" "404091.7z" ""
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435871.7z" "435871.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435872.7z" "435872.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435873.7z" "435873.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435874.7z" "435874.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435875.7z" "435875.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435876.7z" "435876.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435877.7z" "435877.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435878.7z" "435878.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435879.7z" "435879.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435880.7z" "435880.7z" ""
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.10.984 (Next-Gen Update 2)" version_1_10_984
        AddSize 1677722
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377161.7z" "377161.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377162.7z" "377162.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377163.7z.001" "377163.7z.001" "" 4
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 4

        ${If} $F4_Language == "ja"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/393884.7z" "393884.7z" ""
            !insertmacro NSIS7Z_EXTRACT "393884.7z" ".\" "AUTO_DELETE"
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/404091.7z" "404091.7z" ""
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435871.7z" "435871.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435872.7z" "435872.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435873.7z" "435873.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435874.7z" "435874.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435875.7z" "435875.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435876.7z" "435876.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435877.7z" "435877.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435878.7z" "435878.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435879.7z" "435879.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435880.7z" "435880.7z" ""
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.191 (Anniversary, December 2025)" version_1_11_191
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/377162.7z" "377162.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/377163.7z" "377163.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/404091.7z" "404091.7z" ""
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435871.7z" "435871.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435872.7z" "435872.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435873.7z" "435873.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435874.7z" "435874.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435875.7z" "435875.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435876.7z" "435876.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435877.7z" "435877.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435878.7z" "435878.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435879.7z" "435879.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435880.7z" "435880.7z" ""
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.221 (Anniversary, May 2026)" version_1_11_221
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/377162.7z" "377162.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/377163.7z" "377163.7z" ""
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/404091.7z" "404091.7z" ""
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435871.7z" "435871.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435872.7z" "435872.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435873.7z" "435873.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435874.7z" "435874.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435875.7z" "435875.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435876.7z" "435876.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435877.7z" "435877.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435878.7z" "435878.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435879.7z" "435879.7z" ""
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435880.7z" "435880.7z" ""
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
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
    DetailPrint " // Block future update (appmanifest_377160.acf)"
    SetFileAttributes "appmanifest_377160.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Fallout4.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Fallout 4"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${lang_auto} ; Radio Button
    StrCpy $2 ${version_1_10_163} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_auto}
            !insertmacro RadioButton ${lang_cn}
        !insertmacro EndRadioButtons
    ${EndIf}

    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $2
            !insertmacro RadioButton ${version_1_10_163}
            !insertmacro RadioButton ${version_1_10_984}
            !insertmacro RadioButton ${version_1_11_191}
            !insertmacro RadioButton ${version_1_11_221}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
