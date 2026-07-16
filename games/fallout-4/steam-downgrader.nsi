!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (v1.11.221, May 2026). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language* and your installed DLCs, then downloads matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade to 4 different versions (your choice):$\r$\n\
- v1.10.163 (Pre-Next-Gen - 2019)$\r$\n\
- v1.10.984 (Next-gen, Update 2 - 2024)$\r$\n\
- v1.11.169 (Anniversary, November Patch 1 - 2025)$\r$\n\
- v1.11.191 (Anniversary, December Patch 2 - 2025)$\r$\n\
$\r$\n\
*WARNING (for Chinese): Chinese language can't be auto detected, so you'll have to select $\"Chinese$\" during setup.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.221) to" version
    Section
        StrCpy $DLC_Automatron "no"
        StrCpy $DLC_Workshop "no"

        IfFileExists "$INSTDIR\Data\DLCRobot.cdx" 0 +2
            StrCpy $DLC_Automatron "yes"

        IfFileExists "$INSTDIR\Data\DLCworkshop01.cdx" 0 +2
            StrCpy $DLC_Workshop "yes"
    SectionEnd

    Section "v1.10.163 (pre-next-gen)" version_1_10_163
        AddSize 10485760
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377161.7z" "377161.7z" "d3c782aea649b83cf62dbea6296f3711334c0320"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377162.7z" "377162.7z" "861b35540c4d2419b927f61988e0a53094f7a729"
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
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377163.7z.001" "377163.7z.001" "d14f02bfdbdfde7d48725da6e559c26138f24a68" 22
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 22

        ${If} $F4_Language == "fr"
            DetailPrint " // Downloading downgrade 377165 (Base game, French)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377165.7z" "377165.7z" "b35b4a48997def37581b0377a76a2e719be9ce59"
            !insertmacro NSIS7Z_EXTRACT "377165.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "de"
            DetailPrint " // Downloading downgrade 377166 (Base game, German)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377166.7z" "377166.7z" "707321bc7b9c0be207149e079c720ee851b17f91"
            !insertmacro NSIS7Z_EXTRACT "377166.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "it"
            DetailPrint " // Downloading downgrade 377167 (Base game, Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377167.7z" "377167.7z" "2ed2fd07e98c0d9e94345cbed8f891df11361ea0"
            !insertmacro NSIS7Z_EXTRACT "377167.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "es"
            DetailPrint " // Downloading downgrade 377168 (Base game, Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/377168.7z" "377168.7z" "6919bac91ffc1bf298d059b4baf7a177a33ca239"
            !insertmacro NSIS7Z_EXTRACT "377168.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "pl"
            DetailPrint " // Downloading downgrade 393880 (Base game, Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/393880.7z" "393880.7z" "3c0d5250230ba4245740e5de7b6c79fbde3837aa"
            !insertmacro NSIS7Z_EXTRACT "393880.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ru"
            DetailPrint " // Downloading downgrade 393881 (Base game, Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/393881.7z" "393881.7z" "3670dfb1fc9061b61572b002daf1307067eb0462"
            !insertmacro NSIS7Z_EXTRACT "393881.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ptbr"
            DetailPrint " // Downloading downgrade 393882 (Base game, Portuguese-Brazil)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/393882.7z" "393882.7z" "fdd5c85ebd54346902d7013e5fd8be15bc48b70e"
            !insertmacro NSIS7Z_EXTRACT "393882.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "cn"
            DetailPrint " // Downloading downgrade 393883 (Base game, Chinese-Traditional)"
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/393883.7z.001" "393883.7z.001" "b1d63afee69343bfe09a249757c2320619655ef6" 6
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
            !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/393884.7z.001" "393884.7z.001" "9b2322f755d83b42e793235ff88ec49ea3653086" 4
            !insertmacro NSIS7Z_EXTRACT "393884.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393884.7z.001" 4
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            DetailPrint " // Downloading downgrade 435870 (Automatron DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435870.7z" "435870.7z" "651a0ecd12dd3cd607060189a55402f35ac6ebd3"
            !insertmacro NSIS7Z_EXTRACT "435870.7z" ".\" "AUTO_DELETE"

            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/404091.7z" "404091.7z" "f24d2cee58467dfe5658308b6a99f24cc96835c3"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435871.7z" "435871.7z" "c433f48bbfc01d5cd3fe0ebe82c47f6ec76dbcbc"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435872.7z" "435872.7z" "149eb19ae78f13eddae18849eab23d4289343bb5"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435873.7z" "435873.7z" "f3ddd12d932d8108fe7e3e6a5ec70350d86365a7"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435874.7z" "435874.7z" "4e724149425cb1ae2d6394aa7eeb52fdc65c34f1"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435875.7z" "435875.7z" "3eeb97f05dd5c543352475b44c816b33a0eb4dcf"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435876.7z" "435876.7z" "c9e1465e19080e1fae262c8cee04ab630298e4d5"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435877.7z" "435877.7z" "a6dfa19a2992de7ee86b2b5feb5fac0697586e95"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435878.7z" "435878.7z" "43f1968b36ffaa3de916ae5c672821a8d3ca72b8"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435879.7z" "435879.7z" "8d73e425ddb1cb12a3dcb93295c3a13f0cfc5465"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.163/435880.7z" "435880.7z" "bddb1a64552890eeb05abc19b8fb7f79d5df351a"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.10.984 (next-gen, update 2)" version_1_10_984
        AddSize 1677722
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/377161.7z" "377161.7z" "b4945795c95ab4221d0bd3e85d9c155bde5a6fc1"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/377162.7z" "377162.7z" "7ba588747b17b93720cc2b2d3a5153ea579e3ddb"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/377163.7z.001" "377163.7z.001" "c7211ce2e42240d1c05825999ff436c05c39a6b5" 4
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 4

        ${If} $F4_Language == "ja"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/393884.7z" "393884.7z" "362942a03bd79efbb1450ecff580e35ae1a995c2"
            !insertmacro NSIS7Z_EXTRACT "393884.7z" ".\" "AUTO_DELETE"
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/404091.7z" "404091.7z" "3372d3d424508629d1ca5508b559cc47086bafc1"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435871.7z" "435871.7z" "a1aaaa128b44e02f54025caefcedb23bb2328740"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435872.7z" "435872.7z" "052d026941cb3f20572268746bd8efa84c42247a"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435873.7z" "435873.7z" "66f80729e79954ae66653b84703841e75b6eb593"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435874.7z" "435874.7z" "79309f3d3e356b1569c12b98cf4052685bfe1a6e"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435875.7z" "435875.7z" "f48f063e98191602090d1fe4f3e4d40bd449f2d5"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435876.7z" "435876.7z" "38cda76eb31e4b4bc1724f40fce6307a1e626ab0"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435877.7z" "435877.7z" "b660ff7be47d8d9a45cfecc84565566ce205ee83"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435878.7z" "435878.7z" "bf993388122e3531be7966f9d066a27fdff8b968"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435879.7z" "435879.7z" "237e75c127763f423e53556f5814bf82b918a77d"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.10.984/435880.7z" "435880.7z" "6c4e0d8610acdb1b99ad7dd97875b214acc5d85e"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.169 (anniversary, november patch 1)" version_1_11_169
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/377162.7z" \
                                "377162.7z" "ccc65943d17de780b88cd9d7b0fa252332115113"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/377163.7z" \
                                "377163.7z" "5b7023f7bf6bb23b10269fd85dcf10d8f451d8d1"
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/404091.7z" \
                                        "404091.7z" "063526c3b0dc8585c58ec7fcec7a978c4c2b5757"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435871.7z" \
                                        "435871.7z" "aa849f239e7e8bb56b3a0e95f7775a3d0c8865e1"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435872.7z" \
                                        "435872.7z" "94d962bed08e8b551891f771b9edec4cda1c3f7b"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435873.7z" \
                                        "435873.7z" "2056cb214f407fcff1dd4890667c7667c4106489"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435874.7z" \
                                        "435874.7z" "0be9f3461dcea8fd8016b6517ef183afb4230b42"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435875.7z" \
                                        "435875.7z" "060c37b31abcd5d3ea9e2a579a987b2a324c60c5"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435876.7z" \
                                        "435876.7z" "e08e0161bf7bb3e159ebf97958b1dd22d7a6c632"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435877.7z" \
                                        "435877.7z" "104e682ca2cfa23b9f25267160726ca1d8afc21f"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435878.7z" \
                                        "435878.7z" "5118d3787f65d4047c96acf92ed28ebc1f741071"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435879.7z" \
                                        "435879.7z" "b3173d12befa4775f94acad3bef9be65a8017041"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.169/435880.7z" \
                                    "435880.7z" "6db5cd321f3eabc54b33a7b8d78fe423c763938a"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.191 (anniversary, december patch 2)" version_1_11_191
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/377162.7z" \
                                "377162.7z" "97b2e842b566681704eb750d683b84fcdc773877"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/377163.7z" \
                                "377163.7z" "34f18a8711539abe975b15233999e414919c3fdd"
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/404091.7z" \
                                        "404091.7z" "5dc2197131994f9e454f059edc74effa474862d2"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435871.7z" \
                                        "435871.7z" "fe24456646aff7d594bf201c88d5962357e13de3"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435872.7z" \
                                        "435872.7z" "1eb646c9b189e5c2b139d53d5095d0dd9c7e915b"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435873.7z" \
                                        "435873.7z" "5e30b23a8919a05dc60a57af78f74d44840b1f39"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435874.7z" \
                                        "435874.7z" "649d4b212c378e67a174cd51dc7739a1303c1d64"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435875.7z" \
                                        "435875.7z" "711976e1fce0197b7d2946740619ea45988ed6ae"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435876.7z" \
                                        "435876.7z" "bbc6e70a1a3c8fd8863608421dad7563a0131539"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435877.7z" \
                                        "435877.7z" "1d45c0fb12662dd6702c50cf1ab2554c28c6cb48"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435878.7z" \
                                        "435878.7z" "d9cdacd1f8e115e3753b157b2cefb7ebba341f43"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435879.7z" \
                                        "435879.7z" "b51e3ce8d5100285c235ce3eab92f0f592c0bb9b"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/fallout-4/steam-downgrader/1.11.221_to_1.11.191/435880.7z" \
                                    "435880.7z" "aa8351ed9a7ccb4df5b1c4b436918cb2b18f0771"
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
            !insertmacro RadioButton ${version_1_11_169}
            !insertmacro RadioButton ${version_1_11_191}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
