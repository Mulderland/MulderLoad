!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Fallout 4 (v1.11.191, Dec 2025). Works with all editions && languages.$\r$\n\
$\r$\n\
It auto-detects your installed language* and your installed DLCs, then downloads matching $\"xdelta patches$\".$\r$\n\
$\r$\n\
It can downgrade to 3 different versions (your choice):$\r$\n\
- v1.10.163 (Pre-Next-Gen - 2019)$\r$\n\
- v1.10.984 (Next-gen, Update 2 - 2024)$\r$\n\
- v1.11.169 (Anniversary, November Patch - 2025)$\r$\n\
$\r$\n\
*WARNING (for Chinese): Chinese language can't be auto detected, so you'll have to select $\"Chinese$\" during setup.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Fallout 4 [Steam Downgrader]"

!include "steam-downgrader-common.nsh"

SectionGroup /e "Downgrade Steam version (v1.11.191) to" version
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
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377161.7z" "377161.7z" "3d4c6560e2ff58aca5fabc7b0de425765d28cbc9"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377162.7z" "377162.7z" "0dcc5ad2169e59d54d64a0eb887b075dd9e265d2"
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
        !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377163.7z.001" "377163.7z.001" "6e969cd276f82958b1893e3ea10a7434210457cf" 22
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 22

        ${If} $F4_Language == "fr"
            DetailPrint " // Downloading downgrade 377165 (Base game, French)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377165.7z" "377165.7z" "fda5c6f265177e1e65da2967975c5f8ee1d5856f"
            !insertmacro NSIS7Z_EXTRACT "377165.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "de"
            DetailPrint " // Downloading downgrade 377166 (Base game, German)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377166.7z" "377166.7z" "fa953ac1932c022d344ef38e54367a496560f359"
            !insertmacro NSIS7Z_EXTRACT "377166.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "it"
            DetailPrint " // Downloading downgrade 377167 (Base game, Italian)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377167.7z" "377167.7z" "5712d91f1b4a40e560e6a6c90b43f9dad2c17f5e"
            !insertmacro NSIS7Z_EXTRACT "377167.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "es"
            DetailPrint " // Downloading downgrade 377168 (Base game, Spanish)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377168.7z" "377168.7z" "eea1b759ae0cee36caf65feedccab9a8038d1f4f"
            !insertmacro NSIS7Z_EXTRACT "377168.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "pl"
            DetailPrint " // Downloading downgrade 393880 (Base game, Polish)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393880.7z" "393880.7z" "0f0be553230c401b74c747e9be75ab131b201946"
            !insertmacro NSIS7Z_EXTRACT "393880.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ru"
            DetailPrint " // Downloading downgrade 393881 (Base game, Russian)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393881.7z" "393881.7z" "e688a4881f706a32e3b974558db41674d1a091f6"
            !insertmacro NSIS7Z_EXTRACT "393881.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "ptbr"
            DetailPrint " // Downloading downgrade 393882 (Base game, Portuguese-Brazil)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393882.7z" "393882.7z" "d04afe81210c432a100432bd8f6409fc3df4d0ca"
            !insertmacro NSIS7Z_EXTRACT "393882.7z" ".\" "AUTO_DELETE"
        ${ElseIf} $F4_Language == "cn"
            DetailPrint " // Downloading downgrade 393883 (Base game, Chinese-Traditional)"
            !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393883.7z.001" "393883.7z.001" "5fa434511b014b24a2ad44214340210637228282" 6
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
            !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393884.7z.001" "393884.7z.001" "4a63788d8ac3d49ec204c4ad0e9133884843c881" 4
            !insertmacro NSIS7Z_EXTRACT "393884.7z.001" ".\" ""
            !insertmacro DELETE_RANGE "393884.7z.001" 4
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            DetailPrint " // Downloading downgrade 435870 (Automatron DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435870.7z" "435870.7z" "392ced0c50ce22f578966debb64120caaf858a65"
            !insertmacro NSIS7Z_EXTRACT "435870.7z" ".\" "AUTO_DELETE"

            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/404091.7z" "404091.7z" "98fc3453624728dc8ff56753531d157dadcd045a"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435871.7z" "435871.7z" "45ae9dbe3168e2eceb7951ee4730b3d736ed0f24"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435872.7z" "435872.7z" "fed2f41878a37d6eba0a559163e1a04bd9c8d7b8"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435873.7z" "435873.7z" "b47e86614a9e5965151de02ac681244ef4d4e6f0"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435874.7z" "435874.7z" "f417bf5af0cf3f6dcd811a6422c3631cca184887"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435875.7z" "435875.7z" "5be1894ca92c4f426f07dd96eb031dd08cd8213c"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435876.7z" "435876.7z" "5f1791ac16b61760dd3279f5185a10c5dfa5e4ca"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435877.7z" "435877.7z" "05d6100c90c7be1e243ed954f1d5b5621505245e"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435878.7z" "435878.7z" "a6a064263a90990a878a7c2ab429a0a9f8639171"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435879.7z" "435879.7z" "19ba23e61a6ed9980b2b187063415eb8bfb76b56"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435880.7z" "435880.7z" "e598e29e0b9e6f7537b71911b067d3d9fec8a75f"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.10.984 (next-gen, update 2)" version_1_10_984
        AddSize 1677722
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377161.7z" "377161.7z" "20b2de27d1fd8491aec3c866860adc1ac2134636"
        !insertmacro NSIS7Z_EXTRACT "377161.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377162.7z" "377162.7z" "04dd09e54f737d6ae7470694d2def7648f2a952a"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377163.7z.001" "377163.7z.001" "df479685c7528530b7d7177d7be8abcab54c7bdb" 4
        !insertmacro NSIS7Z_EXTRACT "377163.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "377163.7z.001" 4

        ${If} $F4_Language == "ja"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/393884.7z" "393884.7z" "6052557424488a1ae44af2a09b4c7447fcc083af"
            !insertmacro NSIS7Z_EXTRACT "393884.7z" ".\" "AUTO_DELETE"
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/404091.7z" "404091.7z" "0dcce1ff15dfeed8fef7ae80feebb10b17abf482"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435871.7z" "435871.7z" "71657a53d3b2cb7a1c11403195e9f966892e48e6"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435872.7z" "435872.7z" "267f1ceff6d2c09258859a696aa70f3785219650"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435873.7z" "435873.7z" "ceaa914c6626863a8cd994becb75cc0b6ad2aacc"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435874.7z" "435874.7z" "59918e238571f2ebde5c6e9d1ba105424f7da1f7"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435875.7z" "435875.7z" "2c368557eb710740b39d3bdc78a2f2b3777a25e8"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435876.7z" "435876.7z" "6c8b61097be7e54b0b9a9784955c19e6f248bbe8"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435877.7z" "435877.7z" "84e1fb272d44daa1795e196c5e464cbad16327ed"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435878.7z" "435878.7z" "b61419be62f1c5bc6658c6c6be98de9c9be4c323"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435879.7z" "435879.7z" "ebbde5bc09bc40fe6f990469ace3ab554417fba1"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435880.7z" "435880.7z" "6efce4ef3afc283f9ed0dd5ab7634fef8e48dabe"
            !insertmacro NSIS7Z_EXTRACT "435880.7z" ".\" "AUTO_DELETE"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.169 (anniversary, november patch)" version_1_11_169
        AddSize 28672
        SetOutPath "$INSTDIR"
        !insertmacro ABORT_IF_UNSUPPORTED_VERSION
        !insertmacro ABORT_IF_USER_REFUSES

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/377162.7z" "377162.7z" "3c57c147f144d1d17387816899a485065de121fe"
        !insertmacro NSIS7Z_EXTRACT "377162.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/377163.7z" "377163.7z" "71631610d1d6494df42b39b1426f8d7858347931"
        !insertmacro NSIS7Z_EXTRACT "377163.7z" ".\" "AUTO_DELETE"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/404091.7z" "404091.7z" "0d6f76c6f26e22e565e6e7499e61a8adb162082e"
                !insertmacro NSIS7Z_EXTRACT "404091.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435871.7z" "435871.7z" "33c24b4e2acfdd6d06e57e69c61cdd92f7142df3"
                !insertmacro NSIS7Z_EXTRACT "435871.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435872.7z" "435872.7z" "e5ad185af2ce2530febab74ea31fc6cb682246df"
                !insertmacro NSIS7Z_EXTRACT "435872.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435873.7z" "435873.7z" "6263a95783b243c71dd43c0afebe6c5818001cce"
                !insertmacro NSIS7Z_EXTRACT "435873.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435874.7z" "435874.7z" "f5bb0645c89b1ff22b5847e97fa897f97d635d27"
                !insertmacro NSIS7Z_EXTRACT "435874.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435875.7z" "435875.7z" "21c31aac05292112740c8ed760b7859dc8f11c47"
                !insertmacro NSIS7Z_EXTRACT "435875.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435876.7z" "435876.7z" "af766531c1b3d92ab9f54d2d601a3aa9e24eaa07"
                !insertmacro NSIS7Z_EXTRACT "435876.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435877.7z" "435877.7z" "8b1144a74b315da624c9c7028c20d58ccf218c90"
                !insertmacro NSIS7Z_EXTRACT "435877.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435878.7z" "435878.7z" "cfca6d2cbffbe8b2d81f943766bb7f3e8afab61c"
                !insertmacro NSIS7Z_EXTRACT "435878.7z" ".\" "AUTO_DELETE"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435879.7z" "435879.7z" "880a0ca42b6fce124e28e16d4a8c28b0c86f3bd2"
                !insertmacro NSIS7Z_EXTRACT "435879.7z" ".\" "AUTO_DELETE"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435880.7z" "435880.7z" "e4e8fbc9ba565604c184c1d463e9d0ebf4328a66"
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
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
