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

        # https://www.nexusmods.com/newvegas/mods/62552
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/u8uyiy9hcm160ox/4GB_Patcher-62552-1-5-1618787921.7z/file" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/FNV%204GB%20Patcher%20v1.5/4GB%20Patcher-62552-1-5-1618787921.7z" \
                                "4GB_Patcher.7z" "d39df38f2077e7fe5d2c24c6912a72821e17b540"
        !insertmacro NSIS7Z_EXTRACT "4GB_Patcher.7z" ".\" "AUTO_DELETE"

        ExecWait 'FNVpatch.exe' $0
        Delete "FNVpatch.exe"
    SectionEnd

    Section "DXVK v2.7.1"
        AddSize 4389
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://github.com/doitsujin/dxvk/releases/download/v2.7.1/dxvk-2.7.1.tar.gz" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/dxvk-2.7.1.tar.gz" \
                                "dxvk-2.7.1.tar.gz" "16e277f63aca1bb9d6b9ecf823dd0d7aab9b11be"
        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "dxvk-2.7.1.tar.gz" ".\" "AUTO_DELETE"
        !insertmacro 7Z_EXTRACT_ONE "dxvk-2.7.1.tar" ".\" "dxvk-2.7.1\x32\d3d9.dll" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
    SectionEnd

    Section "NVHR (New Vegas Heap Replacer) v4.2"
        AddSize 3963
        SetOutPath "$INSTDIR"

        # https://www.nexusmods.com/newvegas/mods/69779
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/fl1qm6g3hx4criy/NVHR-69779-4-2-1665589730.7z/file" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/New%20Vegas%20Heap%20Replacer%20v4.2/NVHR-69779-4-2-1665589730.7z" \
                                "NVHR.7z" "74ca506548cad6523df6784f5a5c85c3398581b4"
        !insertmacro NSIS7Z_EXTRACT "NVHR.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "YUP (Yukichigai Unofficial Patch) v13.6"
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
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/75yc6b4vw2678p8/YUP_-_Base_Game_and_All_DLC-51664-13-6-1766868693.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20-%20Base%20Game%20and%20All%20DLC-51664-13-6-1766868693.7z"
                StrCpy $YUP_Hash "0b6480a7f42f715b11799593a8abc38fb0afd711"
            ${Else}
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/xlmnbvavlrr22jo/YUP_-_Individual_ESMs-51664-13-6-1766868845.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20-%20Individual%20ESMs-51664-13-6-1766868845.7z"
                StrCpy $YUP_Hash "175a3d95d6dea40d4d50200848073f209f617500"
            ${EndIf}
        ${ElseIf} $YUP_Language == "fr"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/v63yy5b6tpnhobn/YUP_FRA_-_Jeu_de_base_et_Tous_les_DLC-51664-13-6-1766958972.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20FRA%20-%20Jeu%20de%20base%20et%20Tous%20les%20DLC-51664-13-6-1766958972.7z"
                StrCpy $YUP_Hash "d90da9a976603362c1ca0c76a3b9df12f5aa5a01"
            ${Else}
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/ybrzht9hj2wium7/YUP_FRA_-_ESM_individuels-51664-13-6-1766959242.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20FRA%20-%20ESM%20individuels-51664-13-6-1766959242.7z"
                StrCpy $YUP_Hash "237dd6a36b6324d422dd08d438e4dafaa1964605"
            ${EndIf}
        ${ElseIf} $YUP_Language == "it"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/iy3qupfqxygo5y2/YUP_ITA_-_Gioco_base_e_Tutti_i_DLC-51664-13-6-1766959019.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ITA%20-%20Gioco%20base%20e%20Tutti%20i%20DLC-51664-13-6-1766959019.7z"
                StrCpy $YUP_Hash "2e6363ce26e21f903c2d18564576fabca888a5cc"
            ${Else}
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/339grlbk3s6zl7q/YUP_ITA_-_Singoli_ESM-51664-13-6-1766959292.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ITA%20-%20Singoli%20ESM-51664-13-6-1766959292.7z"
                StrCpy $YUP_Hash "d4d4b1277bd6e306591cf7538e0e8b4ffdc126b9"
            ${EndIf}
        ${ElseIf} $YUP_Language == "de"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/476ef2czhf6wmfx/YUP_DEU_-_Basisspiel_und_Alle_DLCs-51664-13-6-1766958874.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20DEU%20-%20Basisspiel%20und%20Alle%20DLCs-51664-13-6-1766958874.7z"
                StrCpy $YUP_Hash "d95e8fe08dacc06e785df48b26175ab43e7fd569"
            ${Else}
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/unka29qcdtei7g8/YUP_DEU_-_Individuelle_ESMs-51664-13-6-1766959150.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20DEU%20-%20Individuelle%20ESMs-51664-13-6-1766959150.7z"
                StrCpy $YUP_Hash "8a9f487cdb75d73b1ca700f09fb5ac071d283374"
            ${EndIf}
        ${ElseIf} $YUP_Language == "es"
            ${If} $YUP_Edition == "complete"
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/8if69zja7plu729/YUP_ESP_-_Juego_Original_y_Todos_Los_DLCs-51664-13-6-1766958925.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ESP%20-%20Juego%20Original%20y%20Todos%20Los%20DLCs-51664-13-6-1766958925.7z"
                StrCpy $YUP_Hash "f9615e514307fc1336871dc721851a9cd0ee26d8"
            ${Else}
                StrCpy $YUP_URL1 "https://www.mediafire.com/file_premium/s4ob6isr81652m0/YUP_ESP_-_ESM_individuales-51664-13-6-1766959189.7z/file"
                StrCpy $YUP_URL2 "https://cdn2.mulderload.eu/g/fallout-new-vegas/YUP%20v13.6/YUP%20ESP%20-%20ESM%20individuales-51664-13-6-1766959189.7z"
                StrCpy $YUP_Hash "882e8a38f7b47db47edba1963ceba1b13add9e89"
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
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/nvse_6_4_4.7z" \
                                "NVSE.7z" "2091cef3b62081612cd7c9dd3fc8cca493fc2164"
        !insertmacro NSIS7Z_EXTRACT "NVSE.7z" ".\" "AUTO_DELETE"

        # Create Plugins directory
        CreateDirectory "$INSTDIR\Data\NVSE\Plugins"
    SectionEnd

    Section "NVTF (New Vegas Tick Fix) v10.61"
        AddSize 1352
        SetOutPath "$INSTDIR\Data"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/k2uvhw1f673xacs/NVTF-66537-10-61-1756195258.7z/file" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTF%20v10.61/NVTF-66537-10-61-1756195258.7z" \
                                "NVTF.7z" "bc1cd4d51eb4d964aa7773ad45f2fce6e058baed"
        !insertmacro NSIS7Z_EXTRACT "NVTF.7z" ".\" "AUTO_DELETE"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/ogj9awawm033w8b/NVTF_-_INI-66537-1-06-1751295478.7z/file" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTF%20v10.61/NVTF%20-%20INI-66537-1-06-1751295478.7z" \
                                "NVTF - INI.7z" "ffb5c9db46e5748decb0952936070d640b92eed8"
        !insertmacro NSIS7Z_EXTRACT "NVTF - INI.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section "Improved Lighting Shaders v1.6a"
        AddSize 21709
        SetOutPath "$INSTDIR\Data"

        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/94v5sz0gab5s69f/Improved_Lighting_Shaders-69833-1-6a-1738800319.zip/file" \
                                "https://cdn2.mulderload.eu/g/fallout-new-vegas/Improved%20Lightning%20Shaders%20v1.6a/Improved%20Lighting%20Shaders-69833-1-6a-1738800319.zip" \
                                "Improved_Lighting_Shaders.zip" "a6fc30adaf7f4cbcd1359e2ef622c7eacaf63589"
        !insertmacro NSISUNZ_EXTRACT "Improved_Lighting_Shaders.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section /o "NVTUP (FNV Texture Upscale Project) v2.0"
    AddSize 28626125
    SetOutPath "$INSTDIR\Data"

    !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/fallout-new-vegas/NVTUP%20v2.0/FNV%20Texture%20Upscale%20Project%20(NVTUP)%202.0-93775-2-0-1765930818.7z.001" "NVTUP.7z.001" "b11a479853b39beb99a8e97b3c29324cac61bd5f" 16
    !insertmacro NSIS7Z_EXTRACT "NVTUP.7z.001" ".\" ""
    !insertmacro DELETE_RANGE "NVTUP.7z.001" 16
SectionEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/mulderload/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
        File resources\MulderConfig.json
        File resources\MulderConfig.save.json
        ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.23 (x64)"
        SetOutPath "$INSTDIR"
        AddSize 100000

        !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.23/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "windowsdesktop-runtime-win-x64.exe" "0ecfc9a9dab72cb968576991ec34921719039d70"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "FalloutNV.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Fallout New Vegas"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
