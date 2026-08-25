!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Fallout: New Vegas, aiming to provide a modern vanilla experience. It includes performances && bug fixes:$\r$\n\
- 4GB Patch (by RoyBatterian)$\r$\n\
- YUP (by Yukichigai)$\r$\n\
- DXVK || NVHR (by iranrmrf)$\r$\n\
- NVSE + NVTF (by carxt)$\r$\n\
$\r$\n\
And also graphical enhancements:$\r$\n\
- Improved Lighting Shaders (by emoose)$\r$\n\
- NVTUP Texture Upscale Project (by WestAard)$\r$\n\
- MulderConfig for widescreen/ultrawide and some options.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Fallout: New Vegas [Enhancement Pack]"

Var /GLOBAL YUP_Language
Var /GLOBAL YUP_Edition
Var /GLOBAL YUP_URL1
Var /GLOBAL YUP_URL2
Var /GLOBAL YUP_Hash

SectionGroup /e "Non-NVSE"
    Section "FNV 4GB Patcher v1.5"
        AddSize 225
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/newvegas/mods/62552?tab=files&file_id=1000075100" \
                                "4GB_Patcher.7z" \
                                "d39df38f2077e7fe5d2c24c6912a72821e17b540"

        !insertmacro NSIS7Z_EXTRACT "4GB_Patcher.7z" ".\" "AUTO_DELETE"

        ExecWait 'FNVpatch.exe' $0
        Delete "FNVpatch.exe"
    SectionEnd

    Section "DXVK v2.7.1"
        AddSize 4389
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://github.com/doitsujin/dxvk/releases/download/v2.7.1/dxvk-2.7.1.tar.gz" \
                                "https://cdn.mulderload.eu/tools/dxvk/dxvk-2.7.1.tar.gz" \
                                "dxvk-2.7.1.tar.gz" \
                                "16e277f63aca1bb9d6b9ecf823dd0d7aab9b11be"

        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "dxvk-2.7.1.tar.gz" ".\" "AUTO_DELETE"
        !insertmacro 7Z_EXTRACT_ONE "dxvk-2.7.1.tar" ".\" "dxvk-2.7.1\x32\d3d9.dll" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
    SectionEnd

    Section "NVHR (New Vegas Heap Replacer) v4.3"
        AddSize 3963
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/newvegas/mods/69779?tab=files&file_id=1000166751" \
                                "NVHR.7z" \
                                "6892646b5505165783c63a3cdf2c897846eae238"

        !insertmacro NSIS7Z_EXTRACT "NVHR.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "YUP (Yukichigai Unofficial Patch) v13.8"
        AddSize 138240

        # Detect Game Language
        NScurl::sha1 "$INSTDIR\Data\Video\FNVIntro.bik"
        Pop $0
        ${If} $0 == "9134209ea4e3633f4eb5c538309765229a8d8532"
            StrCpy $YUP_Language "en"
        ${ElseIf} $0 == "b9b454601aa06c12496df34a0b50ae1d5d8d8363"
            StrCpy $YUP_Language "fr"
        ${ElseIf} $0 == "1fb007769e64655ca8f84935c0fba3208c520325"
            StrCpy $YUP_Language "it"
        ${ElseIf} $0 == "f9716765ca20b3769a91b55d26b2ba02d4194d87"
            StrCpy $YUP_Language "de"
        ${ElseIf} $0 == "62f4fa2bc7"
            StrCpy $YUP_Language "es"
        ${Else}
            MessageBox MB_OK "YUP installation skipped, game language must be en/fr/it/de/es."
            Goto end_yup
        ${EndIf}

        # Detect Game DLCs
        StrCpy $YUP_Edition "individual"
        IfFileExists "$INSTDIR\Data\DeadMoney - Sounds.bsa" 0 end_yup_detection
            IfFileExists "$INSTDIR\Data\HonestHearts - Sounds.bsa" 0 end_yup_detection
                IfFileExists "$INSTDIR\Data\OldWorldBlues - Sounds.bsa" 0 end_yup_detection
                    IfFileExists "$INSTDIR\Data\LonesomeRoad - Sounds.bsa" 0 end_yup_detection
                        IfFileExists "$INSTDIR\Data\GunRunnersArsenal - Sounds.bsa" 0 end_yup_detection
                            StrCpy $YUP_Edition "complete"
        end_yup_detection:

        DetailPrint " // YUP selected distribution: $YUP_Language - $YUP_Edition"

        # Determine YUP Download URL
        ${If} $YUP_Language == "en"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP - Base Game and All DLC-51664-13-8-1771599868.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169928"
                StrCpy $YUP_Hash "22e40b4d67eb54e69b0ae2d8a39bb277559561d8"
            ${Else}
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP - Individual ESMs-51664-13-8-1771600215.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169936"
                StrCpy $YUP_Hash "04baf856b878bdd4af174b672d57c53c7506202c"
            ${EndIf}
        ${ElseIf} $YUP_Language == "fr"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP FRA - Jeu de base et Tous les DLC-51664-13-8-1771600036.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169933"
                StrCpy $YUP_Hash "5f58385fa83fc090d308e28c40bf8aea53b9b958"
            ${Else}
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP FRA - ESM individuels-51664-13-8-1771600364.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169939"
                StrCpy $YUP_Hash "463309fa7deef9118442968db6b8cf85607f8ee5"
            ${EndIf}
        ${ElseIf} $YUP_Language == "it"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP ITA - Gioco base e Tutti i DLC-51664-13-8-1771600097.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169934"
                StrCpy $YUP_Hash "971e178574d5c5c127502a101e8b82b3585b760e"
            ${Else}
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP ITA - Singoli ESM-51664-13-8-1771600414.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169940"
                StrCpy $YUP_Hash "2b8d567b88450c5c6656dd91b47a499286270630"
            ${EndIf}
        ${ElseIf} $YUP_Language == "de"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP DEU - Basisspiel und Alle DLCs-51664-13-8-1771599926.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169929"
                StrCpy $YUP_Hash "f13c122c1dea49021c0dcc6c674d14a2c3a52934"
            ${Else}
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP DEU - Individuelle ESMs-51664-13-8-1771600268.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169937"
                StrCpy $YUP_Hash "6d5ce61f292948a35c5a0fd85893137e6ca2619c"
            ${EndIf}
        ${ElseIf} $YUP_Language == "es"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP ESP - Juego Original y Todos Los DLCs-51664-13-8-1771599987.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169931"
                StrCpy $YUP_Hash "04c86445a644eee1a46ff7a73605ec54d6c6fce5"
            ${Else}
                StrCpy $YUP_URL1 "https://cdn.mulderload.eu/games/fallout-new-vegas/fix/yup-v13.8/YUP ESP - ESM individuales-51664-13-8-1771600313.7z"
                StrCpy $YUP_URL2 "https://www.nexusmods.com/newvegas/mods/51664?tab=files&file_id=1000169938"
                StrCpy $YUP_Hash "2c56538cb4305b0da410a0f91206dca2b0771445"
            ${EndIf}
        ${EndIf}

        # Install YUP
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 $YUP_URL1 $YUP_URL2 "YUP.7z" "$YUP_Hash"
        !insertmacro NSIS7Z_EXTRACT "YUP.7z" ".\" "AUTO_DELETE"
        end_yup:
    SectionEnd
SectionGroupEnd

SectionGroup /e "NVSE v6.4.4"
    Section
        AddSize 33178
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://github.com/xNVSE/NVSE/releases/download/6.4.4/nvse_6_4_4.7z" \
                                "https://cdn.mulderload.eu/games/fallout-new-vegas/impr_misc/nvse_6_4_4.7z" \
                                "NVSE.7z" \
                                "2091cef3b62081612cd7c9dd3fc8cca493fc2164"

        !insertmacro NSIS7Z_EXTRACT "NVSE.7z" ".\" "AUTO_DELETE"

        # Create Plugins directory
        CreateDirectory "$INSTDIR\Data\NVSE\Plugins"
    SectionEnd

    Section "NVTF (New Vegas Tick Fix) v10.61"
        AddSize 1352
        SetOutPath "$INSTDIR\Data"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/newvegas/mods/66537?tab=files&file_id=1000156835" \
                                "NVTF.7z" \
                                "bc1cd4d51eb4d964aa7773ad45f2fce6e058baed"

        !insertmacro NSIS7Z_EXTRACT "NVTF.7z" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/newvegas/mods/66537?tab=files&file_id=1000154098" \
                                "NVTF - INI.7z" \
                                "ffb5c9db46e5748decb0952936070d640b92eed8"

        !insertmacro NSIS7Z_EXTRACT "NVTF - INI.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Improved Lighting Shaders v1.6a"
        AddSize 21709
        SetOutPath "$INSTDIR\Data"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/newvegas/mods/69833?tab=files&file_id=1000146363" \
                                "Improved_Lighting_Shaders.zip" \
                                "a6fc30adaf7f4cbcd1359e2ef622c7eacaf63589"

        !insertmacro NSISUNZ_EXTRACT "Improved_Lighting_Shaders.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section /o "NVTUP (FNV Texture Upscale Project) v2.0"
    AddSize 28626125
    SetOutPath "$INSTDIR\Data"

    !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/fallout-new-vegas/impr_gfx/nvtup-v2.0/FNV Texture Upscale Project (NVTUP) 2.0-93775-2-0-1765930818.7z.001" \
                                "NVTUP.7z.001" \
                                "b11a479853b39beb99a8e97b3c29324cac61bd5f" \
                                16

    !insertmacro NSIS7Z_EXTRACT "NVTUP.7z.001" ".\" ""
    !insertmacro DELETE_RANGE "NVTUP.7z.001" 16
SectionEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "FalloutNV.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Fallout New Vegas"
    StrCpy $SELECT_STEAM_FOLDER "Fallout New Vegas"
FunctionEnd
