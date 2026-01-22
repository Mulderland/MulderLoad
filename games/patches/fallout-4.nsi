!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nIt will downgrade your Steam installation of Fallout 4 from v1.11.191 (december 2025) to a version of your choice (3 target versions available).$\r$\n$\r$\nIt is compatible with every editions (base game only, GOTY, and anything between) and every languages.$\r$\n$\r$\nThis installer will auto-detect your installed language and your installed DLCs, then will download 'delta' downgrades for the necessary Steam depots.$\r$\n$\r$\nWARNING (for chineses): if your Fallout 4 is in chinese, auto language detection will sadly not work for you. So, you will have to check Chinese in the components page."
!include "..\..\templates\select_exe.nsh"
!include "..\..\templates\includes\xdelta3.nsh"
Name "Fallout 4 [Steam Downgrader]"

Var /GLOBAL F4_Language
Var /GLOBAL DLC_Automatron
Var /GLOBAL DLC_Workshop

!macro AbortIfUnsupportedVersion
    NScurl::sha1 "$INSTDIR\Fallout4.exe"
    Pop $0
    ${If} $0 == "b4d944af1d97cde4786ad5bbeddc9c40f25e634c"
        DetailPrint " // Supported version detected: v1.11.191 (december 2025)"
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4 version detected (sha1: $0).$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.191 (december 2025).$\r$\n$\r$\nAborting."
        Abort
    ${EndIf}
!macroend

!macro AbortIfUserRefuses
    MessageBox MB_YESNO|MB_ICONQUESTION "Please check auto-detection before continue.$\r$\n$\r$\nDetected language : $F4_Language$\r$\nAutomatron DLC: $DLC_Automatron$\r$\nWasteland Workshop DLC: $DLC_Workshop$\r$\n$\r$\nIs this correct?$\r$\n$\r$\n(other DLCs don't need downgrade so I don't look for them)" IDYES +2
    Abort
!macroend

!macro DownloadXDelta
    DetailPrint " // Downloading xdelta3"
    !insertmacro Download https://github.com/jmacd/xdelta-gpl/releases/download/v3.0.11/xdelta3-3.0.11-x86_64.exe.zip "xdelta3.zip"
    nsisunz::Unzip "xdelta3.zip" ".\"
    Delete "xdelta3.zip"
    Rename "xdelta3-3.0.11-x86_64.exe" "xdelta3.exe"
!macroend

SectionGroup "Language Detection" lang
    Section "Auto-detect (doesn't work for chinese)" lang_auto
        StrCpy $F4_Language "en"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_fr.ba2" 0 +2
            StrCpy $F4_Language "fr"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_de.ba2" 0 +2
            StrCpy $F4_Language "de"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_it.ba2" 0 +2
            StrCpy $F4_Language "it"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_es.ba2" 0 +2
            StrCpy $F4_Language "es"

        IfFileExists "$INSTDIR\Data\Video\Intro_pl.bk2" 0 +2
            StrCpy $F4_Language "pl"

        IfFileExists "$INSTDIR\Data\Video\Intro_ru.bk2" 0 +2
            StrCpy $F4_Language "ru"

        IfFileExists "$INSTDIR\Data\Video\Intro_ptbr.bk2" 0 +2
            StrCpy $F4_Language "ptbr"

        IfFileExists "$INSTDIR\Data\Video\Intro_ja.bk2" 0 +2
            StrCpy $F4_Language "ja"
    SectionEnd

    Section /o "My game is in traditional chinese" lang_cn
        StrCpy $F4_Language "cn"
    SectionEnd
SectionGroupEnd

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
        SetOutPath $INSTDIR
        !insertmacro AbortIfUnsupportedVersion
        !insertmacro AbortIfUserRefuses
        !insertmacro DownloadXDelta

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377161.7z "377161.7z"
        Nsis7z::ExtractWithDetails "377161.7z" "Extracting downgrade 377161 %s..."
        Delete "377161.7z"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377162.7z "377162.7z"
        Nsis7z::ExtractWithDetails "377162.7z" "Extracting downgrade 377162 %s..."
        Delete "377162.7z"

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
        !insertmacro DownloadRange https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377163.7z "377163.7z" 22
        Nsis7z::ExtractWithDetails "377163.7z.001" "Extracting downgrade 377163 %s..."
        !insertmacro DeleteRange "377163.7z" 22

        ${If} $F4_Language == "fr"
            DetailPrint " // Downloading downgrade 377165 (Base game, French)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377165.7z "377165.7z"
            Nsis7z::ExtractWithDetails "377165.7z" "Extracting downgrade 377165 %s..."
            Delete "377165.7z"
        ${ElseIf} $F4_Language == "de"
            DetailPrint " // Downloading downgrade 377166 (Base game, German)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377166.7z "377166.7z"
            Nsis7z::ExtractWithDetails "377166.7z" "Extracting downgrade 377166 %s..."
            Delete "377166.7z"
        ${ElseIf} $F4_Language == "it"
            DetailPrint " // Downloading downgrade 377167 (Base game, Italian)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377167.7z "377167.7z"
            Nsis7z::ExtractWithDetails "377167.7z" "Extracting downgrade 377167 %s..."
            Delete "377167.7z"
        ${ElseIf} $F4_Language == "es"
            DetailPrint " // Downloading downgrade 377168 (Base game, Spanish)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/377168.7z "377168.7z"
            Nsis7z::ExtractWithDetails "377168.7z" "Extracting downgrade 377168 %s..."
            Delete "377168.7z"
        ${ElseIf} $F4_Language == "pl"
            DetailPrint " // Downloading downgrade 393880 (Base game, Polish)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393880.7z "393880.7z"
            Nsis7z::ExtractWithDetails "393880.7z" "Extracting downgrade 393880 %s..."
            Delete "393880.7z"
        ${ElseIf} $F4_Language == "ru"
            DetailPrint " // Downloading downgrade 393881 (Base game, Russian)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393881.7z "393881.7z"
            Nsis7z::ExtractWithDetails "393881.7z" "Extracting downgrade 393881 %s..."
            Delete "393881.7z"
        ${ElseIf} $F4_Language == "ptbr"
            DetailPrint " // Downloading downgrade 393882 (Base game, Portuguese-Brazil)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393882.7z "393882.7z"
            Nsis7z::ExtractWithDetails "393882.7z" "Extracting downgrade 393882 %s..."
            Delete "393882.7z"
        ${ElseIf} $F4_Language == "cn"
            DetailPrint " // Downloading downgrade 393883 (Base game, Chinese-Traditional)"
            !insertmacro DownloadRange https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393883.7z "393883.7z" 6
            Nsis7z::ExtractWithDetails "393883.7z.001" "Extracting downgrade 393883 %s..."
            !insertmacro DeleteRange "393883.7z" 6
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
            !insertmacro DownloadRange https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/393884.7z "393884.7z" 4
            Nsis7z::ExtractWithDetails "393884.7z.001" "Extracting downgrade 393884 %s..."
            !insertmacro DeleteRange "393884.7z" 4
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            DetailPrint " // Downloading downgrade 435870 (Automatron DLC)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435870.7z "435870.7z"
            Nsis7z::ExtractWithDetails "435870.7z" "Extracting downgrade 435870 %s..."
            Delete "435870.7z"

            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/404091.7z "404091.7z"
                Nsis7z::ExtractWithDetails "404091.7z" "Extracting downgrade 404091 %s..."
                Delete "404091.7z"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435871.7z "435871.7z"
                Nsis7z::ExtractWithDetails "435871.7z" "Downgrading depot 435871 %s..."
                Delete "435871.7z"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435872.7z "435872.7z"
                Nsis7z::ExtractWithDetails "435872.7z" "Downgrading depot 435872 %s..."
                Delete "435872.7z"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435873.7z "435873.7z"
                Nsis7z::ExtractWithDetails "435873.7z" "Downgrading depot 435873 %s..."
                Delete "435873.7z"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435874.7z "435874.7z"
                Nsis7z::ExtractWithDetails "435874.7z" "Downgrading depot 435874 %s..."
                Delete "435874.7z"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435875.7z "435875.7z"
                Nsis7z::ExtractWithDetails "435875.7z" "Downgrading depot 435875 %s..."
                Delete "435875.7z"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435876.7z "435876.7z"
                Nsis7z::ExtractWithDetails "435876.7z" "Extracting downgrade 435876 %s..."
                Delete "435876.7z"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435877.7z "435877.7z"
                Nsis7z::ExtractWithDetails "435877.7z" "Extracting downgrade 435877 %s..."
                Delete "435877.7z"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435878.7z "435878.7z"
                Nsis7z::ExtractWithDetails "435878.7z" "Extracting downgrade 435878 %s..."
                Delete "435878.7z"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435879.7z "435879.7z"
                Nsis7z::ExtractWithDetails "435879.7z" "Extracting downgrade 435879 %s..."
                Delete "435879.7z"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_2025_12/435880.7z "435880.7z"
            Nsis7z::ExtractWithDetails "435880.7z" "Extracting downgrade 435880 %s..."
            Delete "435880.7z"
        ${EndIf}
    SectionEnd

    Section /o "v1.10.984 (next-gen, update 2)" version_1_10_984
        AddSize 1677722
        SetOutPath $INSTDIR
        !insertmacro AbortIfUnsupportedVersion
        !insertmacro AbortIfUserRefuses
        !insertmacro DownloadXDelta

        DetailPrint " // Downloading downgrade 377161 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377161.7z "377161.7z"
        Nsis7z::ExtractWithDetails "377161.7z" "Extracting downgrade 377161 %s..."
        Delete "377161.7z"

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377162.7z "377162.7z"
        Nsis7z::ExtractWithDetails "377162.7z" "Extracting downgrade 377162 %s..."
        Delete "377162.7z"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        Delete "Data\Fallout4 - TexturesPatch.ba2"
        !insertmacro DownloadRange https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/377163.7z "377163.7z" 4
        Nsis7z::ExtractWithDetails "377163.7z.001" "Extracting downgrade 377163 %s..."
        !insertmacro DeleteRange "377163.7z" 4

        ${If} $F4_Language == "ja"
            DetailPrint " // Downloading downgrade 393884 (Base game, Japanese)"
            Rename "Data\Fallout4 - Voices_jp.ba2" "Data\Fallout4 - Voices.ba2"
            Rename "Data\Fallout4 - Voices_rep_ja.ba2" "Data\Fallout4 - Voices_rep.ba2"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/393884.7z "393884.7z"
            Nsis7z::ExtractWithDetails "393884.7z" "Extracting downgrade 393884 %s..."
            Delete "393884.7z"
        ${EndIf}

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/404091.7z "404091.7z"
                Nsis7z::ExtractWithDetails "404091.7z" "Extracting downgrade 404091 %s..."
                Delete "404091.7z"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435871.7z "435871.7z"
                Nsis7z::ExtractWithDetails "435871.7z" "Downgrading depot 435871 %s..."
                Delete "435871.7z"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435872.7z "435872.7z"
                Nsis7z::ExtractWithDetails "435872.7z" "Downgrading depot 435872 %s..."
                Delete "435872.7z"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435873.7z "435873.7z"
                Nsis7z::ExtractWithDetails "435873.7z" "Downgrading depot 435873 %s..."
                Delete "435873.7z"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435874.7z "435874.7z"
                Nsis7z::ExtractWithDetails "435874.7z" "Downgrading depot 435874 %s..."
                Delete "435874.7z"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435875.7z "435875.7z"
                Nsis7z::ExtractWithDetails "435875.7z" "Downgrading depot 435875 %s..."
                Delete "435875.7z"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435876.7z "435876.7z"
                Nsis7z::ExtractWithDetails "435876.7z" "Extracting downgrade 435876 %s..."
                Delete "435876.7z"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435877.7z "435877.7z"
                Nsis7z::ExtractWithDetails "435877.7z" "Extracting downgrade 435877 %s..."
                Delete "435877.7z"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435878.7z "435878.7z"
                Nsis7z::ExtractWithDetails "435878.7z" "Extracting downgrade 435878 %s..."
                Delete "435878.7z"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435879.7z "435879.7z"
                Nsis7z::ExtractWithDetails "435879.7z" "Extracting downgrade 435879 %s..."
                Delete "435879.7z"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.10.984/435880.7z "435880.7z"
            Nsis7z::ExtractWithDetails "435880.7z" "Extracting downgrade 435880 %s..."
            Delete "435880.7z"
        ${EndIf}
    SectionEnd

    Section /o "v1.11.169 (anniversary, november patch)" version_1_11_169
        AddSize 28672
        SetOutPath $INSTDIR
        !insertmacro AbortIfUnsupportedVersion
        !insertmacro AbortIfUserRefuses
        !insertmacro DownloadXDelta

        DetailPrint " // Downloading downgrade 377162 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/377162.7z "377162.7z"
        Nsis7z::ExtractWithDetails "377162.7z" "Extracting downgrade 377162 %s..."
        Delete "377162.7z"

        DetailPrint " // Downloading downgrade 377163 (Base game)"
        !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/377163.7z "377163.7z"
        Nsis7z::ExtractWithDetails "377163.7z" "Extracting downgrade 377163 %s..."
        Delete "377163.7z"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Downloading downgrade 404091 (Automatron DLC, Japanese)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/404091.7z "404091.7z"
                Nsis7z::ExtractWithDetails "404091.7z" "Extracting downgrade 404091 %s..."
                Delete "404091.7z"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Downloading downgrade 435871 (Automatron DLC, English)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435871.7z "435871.7z"
                Nsis7z::ExtractWithDetails "435871.7z" "Downgrading depot 435871 %s..."
                Delete "435871.7z"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Downloading downgrade 435872 (Automatron DLC, French)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435872.7z "435872.7z"
                Nsis7z::ExtractWithDetails "435872.7z" "Downgrading depot 435872 %s..."
                Delete "435872.7z"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Downloading downgrade 435873 (Automatron DLC, German)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435873.7z "435873.7z"
                Nsis7z::ExtractWithDetails "435873.7z" "Downgrading depot 435873 %s..."
                Delete "435873.7z"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Downloading downgrade 435874 (Automatron DLC, Italian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435874.7z "435874.7z"
                Nsis7z::ExtractWithDetails "435874.7z" "Downgrading depot 435874 %s..."
                Delete "435874.7z"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Downloading downgrade 435875 (Automatron DLC, Spanish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435875.7z "435875.7z"
                Nsis7z::ExtractWithDetails "435875.7z" "Downgrading depot 435875 %s..."
                Delete "435875.7z"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Downloading downgrade 435876 (Automatron DLC, Polish)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435876.7z "435876.7z"
                Nsis7z::ExtractWithDetails "435876.7z" "Extracting downgrade 435876 %s..."
                Delete "435876.7z"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Downloading downgrade 435877 (Automatron DLC, Russian)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435877.7z "435877.7z"
                Nsis7z::ExtractWithDetails "435877.7z" "Extracting downgrade 435877 %s..."
                Delete "435877.7z"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Downloading downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435878.7z "435878.7z"
                Nsis7z::ExtractWithDetails "435878.7z" "Extracting downgrade 435878 %s..."
                Delete "435878.7z"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Downloading downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435879.7z "435879.7z"
                Nsis7z::ExtractWithDetails "435879.7z" "Extracting downgrade 435879 %s..."
                Delete "435879.7z"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Downloading downgrade 435880 (Wasteland Workshop DLC)"
            !insertmacro Download https://cdn2.mulderload.eu/g/fallout-4/steam_downgrade_1.11.191_to_1.11.169/435880.7z "435880.7z"
            Nsis7z::ExtractWithDetails "435880.7z" "Extracting downgrade 435880 %s..."
            Delete "435880.7z"
        ${EndIf}
    SectionEnd

    Section
        SetOutPath $INSTDIR
        DetailPrint " // Applying xdelta patches"
        !insertmacro XDelta3_ApplyPatches "$INSTDIR"
        DetailPrint " // Remove xdelta3"
        Delete "xdelta3.exe"
    SectionEnd
SectionGroupEnd

Section /o "Block future Steam update"
    SetOutPath $INSTDIR\..\..
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
