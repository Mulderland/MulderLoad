!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (1.11.240, August 26). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language and your installed DLCs, then downloads matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade to 4 different versions (your choice):$\r$\n\
- v1.10.163 (Pre-Next-Gen - 2019)$\r$\n\
- v1.10.984 (Next-Gen Update 2 - 2024)$\r$\n\
- v1.11.191 (Anniversary - December 2025)$\r$\n\
- v1.11.221 (Anniversary - May 2026)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Buy me a coffee? :)"
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenKofi"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.240) to" version
    Section /o "v1.10.163 (Pre-Next-Gen)" version_1_10_163
        AddSize 10485760
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377161.7z" "377161.7z" "ac0f60f3bbc57aa7424fc3869845d3031900b7bf"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377162.7z" "377162.7z" "f8a0689340967707421822d41cd73ed82b69607e"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        MessageBox MB_YESNO|MB_DEFBUTTON2 "Do you want to keep Creation Club content?$\r$\n$\r$\n\
Yes (experimental, requires 'Backported Archive2 Support System')$\r$\n\
No (recommended for a pure 1.10.163 downgrade)" IDYES cc_keep IDNO cc_delete
        cc_delete:
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
        cc_keep:

        Delete "Data\Fallout4 - TexturesPatch.ba2"
        Delete "Fallout4IDs.ccc"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377163.7z.001" "377163.7z.001" "02a2a310c1a1ce4cb5851d1c342be5e93b07621b" 22
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 22

        ${If} $Game_Language == "French"
            DetailPrint " // Downloading downgrade 377165 (Base game, French)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377165.7z" "377165.7z" "6fe40434c1db88a087cccd7b39e68f4d93d454c6"
            !insertmacro NSIS7Z_EXTRACT "377165.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "German"
            DetailPrint " // Downloading downgrade 377166 (Base game, German)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377166.7z" "377166.7z" "a2287aa08c2b7e6332f458b929567c22379e8cd2"
            !insertmacro NSIS7Z_EXTRACT "377166.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Italian"
            DetailPrint " // Downloading downgrade 377167 (Base game, Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377167.7z" "377167.7z" "c93f5c1b89ae4d16ca7c70c9cd89e1f5ef724e43"
            !insertmacro NSIS7Z_EXTRACT "377167.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Spanish"
            DetailPrint " // Downloading downgrade 377168 (Base game, Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/377168.7z" "377168.7z" "6d39147a98c39ad02f7646da2fa700b44db32803"
            !insertmacro NSIS7Z_EXTRACT "377168.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Polish"
            DetailPrint " // Downloading downgrade 393880 (Base game, Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393880.7z" "393880.7z" "3c0d5250230ba4245740e5de7b6c79fbde3837aa"
            !insertmacro NSIS7Z_EXTRACT "393880.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Russian"
            DetailPrint " // Downloading downgrade 393881 (Base game, Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393881.7z" "393881.7z" "3670dfb1fc9061b61572b002daf1307067eb0462"
            !insertmacro NSIS7Z_EXTRACT "393881.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Portuguese (Brazil)"
            DetailPrint " // Downloading downgrade 393882 (Base game, Portuguese-Brazil)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393882.7z" "393882.7z" "fdd5c85ebd54346902d7013e5fd8be15bc48b70e"
            !insertmacro NSIS7Z_EXTRACT "393882.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $Game_Language == "Chinese (Traditional)"
            DetailPrint " // Downloading downgrade 393883 (Base game, Chinese-Traditional)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393883.7z.001" "393883.7z.001" "a78a9d1cb4ed1e3ec05c34c384cc2dd4112ea6be" 6
            !insertmacro NSIS7Z_EXTRACT "393883.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393883.7z.001" 6
        ${ElseIf} $Game_Language == "Japanese"
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
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/393884.7z.001" "393884.7z.001" "fbeb5e2de4e7f1ab579a897a0440dacfaa0bc5dd" 4
            !insertmacro NSIS7Z_EXTRACT "393884.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393884.7z.001" 4
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            DetailPrint " // Downloading downgrade 435870 (Automatron DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435870.7z" "435870.7z" "2c6a85ed1713e7389990ea49ab4941168e487fec"
            !insertmacro NSIS7Z_EXTRACT "435870.7z" ".\" "AUTO_DELETE"

            ${If} $Game_Language == "Japanese"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/404091.7z" "404091.7z" "62c5220829a890b98a2b9ac0ce1f144ba13e71a4"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "English"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435871.7z" "435871.7z" "2447c84949bc8ede7b698683bb56ed54eb057ef9"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "French"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435872.7z" "435872.7z" "ee9e4967f031f7d24d0a50d3793833b57b23ff25"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "German"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435873.7z" "435873.7z" "3d7de0c16bb977e3a46be32a36e2020009f5259e"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Italian"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435874.7z" "435874.7z" "c4f38f1d88db2dcc403dd4c38fb0a00bedc24579"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Spanish"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435875.7z" "435875.7z" "d0b7fa8fd87ed9c4ed03a82c7bc1c2e0d6568132"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Polish"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435876.7z" "435876.7z" "64f982c8eb0c7f54283fd7e80ac7562153288a83"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Russian"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435877.7z" "435877.7z" "0b870598a9757df4896be77e2edc389f6024adc0"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Portuguese (Brazil)"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435878.7z" "435878.7z" "7a7cb7de03501e97a96544d0abdd0d869bfe76f7"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Chinese (Traditional)"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435879.7z" "435879.7z" "25bd6b8418da454d1fec133eb96231cc1a22b322"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.163/435880.7z" "435880.7z" "916090add462122654c08ffa03e6935b60cae0b7"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.10.984 (Next-Gen Update 2)" version_1_10_984
        AddSize 1677722
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377161.7z" "377161.7z" "ba50fe4d8d9e7593a035eb759e76a9aecdbf9f07"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377162.7z" "377162.7z" "5860b7c2c41d7007c15ca1813eaf147a5865c6f9"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/377163.7z.001" "377163.7z.001" "2901bfab3738db01c3077806702a3e0876b36836" 4
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 4

        ${If} $Game_Language == "Japanese"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/393884.7z" "393884.7z" "362942a03bd79efbb1450ecff580e35ae1a995c2"
            !insertmacro NSIS7Z_EXTRACT "393884.7z" ".\" "AUTO_DELETE"
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            ${If} $Game_Language == "Japanese"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/404091.7z" "404091.7z" "9618717691d3e913dfa29bb044281440e13f5040"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "English"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435871.7z" "435871.7z" "57a99a16e20597d635548ba7de1e4a223519b9b0"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "French"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435872.7z" "435872.7z" "3c100de1b15fa18d03823623f1875bf427942d4f"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "German"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435873.7z" "435873.7z" "cce4c83cde4d34a1204dcf0c0c6f4438f9eeee7f"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Italian"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435874.7z" "435874.7z" "2a6d91fc98648ac77a8536717945abe4ee230d35"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Spanish"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435875.7z" "435875.7z" "5554aacb32fdea667e51d32c3a83ab1e1c14e2ef"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Polish"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435876.7z" "435876.7z" "58cc29a770645a6d1431a4dbbb6672c2e8fc819e"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Russian"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435877.7z" "435877.7z" "da7ccda2999bf647caf184686dc2c7054204eefc"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Portuguese (Brazil)"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435878.7z" "435878.7z" "8496770e3285ebd21d4202fb59b9a794f888deb6"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Chinese (Traditional)"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435879.7z" "435879.7z" "d7e1d8fc40e2cbc95e66092982ad577892110cc9"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.10.984/435880.7z" "435880.7z" "052c08ab36cf56d327725ac017c08da1aa955880"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.191 (Anniversary, December 2025)" version_1_11_191
        AddSize 28672
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/377162.7z" "377162.7z" "f48be4df6b3b4bc861e14e79c93bc09c00da3ac9"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/377163.7z" "377163.7z" "f83f0ea741a243c2d2a3c26bb63f5ec3424b6fd1"
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $Game_Language == "Japanese"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/404091.7z" "404091.7z" "eceef4f7ffdc3a6e9de1f0fddcf2b8e99ffb2c70"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "English"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435871.7z" "435871.7z" "c01186379239ca4000b3ea5a118328e14262e30c"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "French"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435872.7z" "435872.7z" "072a4ff2ae5c954e9555a37e061859b09144fafc"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "German"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435873.7z" "435873.7z" "3f525b824dc715266718c59cc610654b7553d3e5"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Italian"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435874.7z" "435874.7z" "49c4003501a0de8c8a18edab9a751104f4320de3"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Spanish"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435875.7z" "435875.7z" "07e3571319b8e535c5c97cc4cf6f2150b5907b4a"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Polish"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435876.7z" "435876.7z" "3c853e55e90f8c4472f78c4b257bb76f54cb68bf"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Russian"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435877.7z" "435877.7z" "083d2195e43bb5b5001b52cca300a1cc9ea3726f"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Portuguese (Brazil)"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435878.7z" "435878.7z" "90672b8f15c9b2073245ea74e6c239e1517d6a28"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Chinese (Traditional)"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435879.7z" "435879.7z" "c62b9e3c75be59b9a248c5bb7a6a50a545936657"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.191/435880.7z" "435880.7z" "39fedea0781bd45e1a1eb34c413ee0c81913d7f9"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section "v1.11.221 (Anniversary, May 2026)" version_1_11_221
        AddSize 28672
        SetOutPath "$INSTDIR"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/377162.7z" "377162.7z" "0d9cedb6fff42fb1e7139e9679f4442e9748b0a2"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/377163.7z" "377163.7z" "08a91cc8ab7bdb56d538afcc830a950a9b497604"
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $Game_Language == "Japanese"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/404091.7z" "404091.7z" "ff4fd3d701c972ab2fc8fc2cf7fb1a99e32598e1"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "English"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435871.7z" "435871.7z" "0710a3cae50bdf363e79bb0521e83004c5d2fd9d"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "French"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435872.7z" "435872.7z" "1f947f7a7eded98be510cfdc8f1edde1aa18a770"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "German"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435873.7z" "435873.7z" "eeb78bcd428c17ae935f5116f21116ea238f84e1"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Italian"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435874.7z" "435874.7z" "699f02f266731c0d24e1f7ba147eef86b1a6fa46"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Spanish"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435875.7z" "435875.7z" "e582ba55dfdffc6bdd8bb34d44296fd25bebf2e2"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Polish"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435876.7z" "435876.7z" "4f272a18de6b61b6ed5ed5c756640065c8360b8f"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Russian"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435877.7z" "435877.7z" "4271c92f72b7f361d76ef27fa81902983a340bb8"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Portuguese (Brazil)"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435878.7z" "435878.7z" "5a11852f6f11ac3900b55efe292c6347a61fe208"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $Game_Language == "Chinese (Traditional)"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435879.7z" "435879.7z" "e9e28c44797777a8a7a0241f54635b98f29cc9ba"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.240_to_1.11.221/435880.7z" "435880.7z" "27323bf9392d5e7e18013b49c2e0089f428d086d"
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
    StrCpy $1 ${version_1_10_163} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${version}
        !insertmacro UnSelectSection ${version}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${version_1_10_163}
            !insertmacro RadioButton ${version_1_10_984}
            !insertmacro RadioButton ${version_1_11_191}
            !insertmacro RadioButton ${version_1_11_221}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
