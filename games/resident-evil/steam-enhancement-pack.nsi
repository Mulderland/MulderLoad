!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Resident Evil (Steam), with:$\r$\n\
    - Downgrade to GOG version (including GOG's DX Wrapper)$\r$\n\
    - Resident Evil Classic REbirth$\r$\n\
    - Translation patches$\r$\n\
    - Resident Evil HD Mod (by TeamX)$\r$\n\
    - Seamless HD Project v1.1 (by RESHDP)$\r$\n\
    - RE-Enhance v2.0 (by SonicB00M)$\r$\n\
    - High Quality FMVs$\r$\n\
    - High Quality Audio (by lexas87)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to the Classic REbirth team!"

    !include "..\..\includes\templates\SelectTemplate.nsh"

    Name "Resident Evil [Steam Enhancement Pack]"
!endif

Var /GLOBAL REBIRTHDIR

Section
    !ifdef GOG_ENHANCEMENT_PACK_NSI
        StrCpy $REBIRTHDIR "$INSTDIR"
    !else
        StrCpy $REBIRTHDIR "$INSTDIR\rebirth"
    !endif
SectionEnd

!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    Section "Downgrade Steam to GOG v1.0 hotfix 4" gog_downgrade
        AddSize 1
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/steam_to_gog_1.0hotfix4.7z" \
                                "https://www.mediafire.com/file_premium/icjvuvpl5598q70/steam_to_gog_1.0hotfix4.7z/file" \
                                "steam_to_gog_1.0hotfix4.7z" "9bd48a912e467bfbce5441ed3e570d828f79c7fd"
        !insertmacro NSIS7Z_EXTRACT "steam_to_gog_1.0hotfix4.7z" ".\" "AUTO_DELETE"
    SectionEnd
!endif

Section "Remove admin permissions requirement"
    SetOutPath "$INSTDIR"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        File "resources\gog\bh1_japanese.reg"
        ExecWait 'regedit.exe /s "$INSTDIR\bh1_japanese.reg"'
        WriteRegStr HKCU "SOFTWARE\CAPCOM\BIO HAZARD" "Install Path" "$INSTDIR\"
    !else
        # If Steam, check if GOG downgrade is selected.
        SectionGetFlags ${gog_downgrade} $0
        IntOp $0 $0 & ${SF_SELECTED}
        StrCmp $0 ${SF_SELECTED} reg_steam_downgraded reg_steam_original

        reg_steam_downgraded:
            File "resources\gog\bh1_japanese.reg"
            File "resources\steam\re1_english.reg"
            ExecWait 'regedit.exe /s "$INSTDIR\bh1_japanese.reg"'
            ExecWait 'regedit.exe /s "$INSTDIR\re1_english.reg"'
            WriteRegStr HKCU "SOFTWARE\CAPCOM\BIO HAZARD" "Install Path" "$INSTDIR\japanese\"
            WriteRegStr HKCU "SOFTWARE\CAPCOM\RESIDENT EVIL" "Install Path" "$INSTDIR\english\"
            Goto reg_end

        reg_steam_original:
            ExecWait 'regedit.exe /s "$INSTDIR\bh1_japanese.reg"'
            ExecWait 'regedit.exe /s "$INSTDIR\re1_english.reg"'
            WriteRegStr HKCU "SOFTWARE\CAPCOM\STEAM_BIO1" "Install Path" "$INSTDIR\japanese\"
            WriteRegStr HKCU "SOFTWARE\CAPCOM\STEAM_R EVIL1" "Install Path" "$INSTDIR\english\"

        reg_end:
    !endif
SectionEnd

Section "Resident Evil Classic REbirth"
    SetOutPath "$INSTDIR"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        # If GOG: disable unwanted files
        !insertmacro FORCE_RENAME "$INSTDIR\ddraw.dll" "$INSTDIR\ddraw.dll.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dinput.dll" "$INSTDIR\dinput.dll.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.exe" "$INSTDIR\dxcfg.exe.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.ini" "$INSTDIR\dxcfg.ini.bak"
    !else
        # If Steam: copy files to a new "rebirth" folder and delete unwanted files
        AddSize 603136
        ${IfNot} ${FileExists} "$INSTDIR\rebirth\*.*"
            CopyFiles /SILENT "$INSTDIR\japanese\JPN" "$INSTDIR\rebirth\JPN"
            CopyFiles /SILENT /FILESONLY "$INSTDIR\japanese\*.*" "$INSTDIR\rebirth"
        ${EndIf}
        Delete "$INSTDIR\rebirth\ddraw.dll"
        Delete "$INSTDIR\rebirth\dinput.dll"
        Delete "$INSTDIR\rebirth\dxcfg.*"
    !endif

    SetOutPath "$REBIRTHDIR"

    # Patch 1.01 (MediaKite)
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/mediakite%201.01.7z" \
                            "https://www.mediafire.com/file_premium/reo1sd8svembozn/mediakite_1.01.7z/file" \
                            "mediakite 1.01.7z" "de61e404e2cd54466bc2ac3cc5d4e628cad32f3d"
    !insertmacro NSIS7Z_EXTRACT "mediakite 1.01.7z" ".\" "AUTO_DELETE"
    AddSize 940

    # Classic REbirth DLL
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/re1cr-2020-12-06.7z" \
                            "https://www.mediafire.com/file_premium/tg8fas77fql687m/re1cr-2020-12-06.7z/file" \
                            "re1cr-2020-12-06.7z" "e5615c3fb0711e2d692a8eec1725ffde5993a189"
    !insertmacro NSIS7Z_EXTRACT "re1cr-2020-12-06.7z" ".\" "AUTO_DELETE"
    AddSize 3181

    # Create Classic REbirth save folder
    CreateDirectory "$REBIRTHDIR\savedata"

    # Fix squares/lines in background when using Anti-Aliasing
    WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$REBIRTHDIR\Biohazard.exe" "~ HIGHDPIAWARE"

    # Apply 4GB Patch
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/_common/ntcore_4gb_patch_v1.0.0.1.zip" \
                            "https://ntcore.com/files/4gb_patch.zip" \
                            "4gb_patch.zip" "c8b0d61937cb54fc8215124c0f737a1d29479c97"
    !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"
    ExecWait '4gb_patch.exe Biohazard.exe' $0
    Delete "4gb_patch.exe"
    AddSize 940
SectionEnd

SectionGroup "Translation patches"
    Section /o "French patch (by Vonmalvarius)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/translation/mod_fr_V1.3.1.7z" \
                                "https://www.mediafire.com/file_premium/gcz0nmcto6zv1lt/mod_fr_V1.3.1.7z/file" \
                                "$REBIRTHDIR\mod_fr_V1.3.1.7z" "e60b30797a5856e8edee518327efe517bbfdeb75"
        AddSize 483
    SectionEnd

    Section /o "German patch (by Accandon)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/translation/mod_german_1_0_1_crypto.7z" \
                                "https://www.mediafire.com/file_premium/9xqqsj3owxqs7bw/mod_german_1_0_1_crypto.7z/file" \
                                "$REBIRTHDIR\mod_german_1_0_1_crypto.7z" "c6abde7a312c22cb1d87c59c4cf5f5dc5e86c67a"
        AddSize 372
    SectionEnd

    Section /o "Italian patch (by menmacchi)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/translation/Mod_RE_Italian_V1.1_Classic.7z" \
                                "https://www.mediafire.com/file_premium/uel8ssivbpzwz5r/Mod_RE_Italian_V1.1_Classic.7z/file" \
                                "$REBIRTHDIR\Mod_RE_Italian_V1.1_Classic.7z" "a577108600077cbd0f49d1077420d1ac311441b0"
        AddSize 403
    SectionEnd

    Section /o "Russian patch (by CasperPRO)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/translation/mod_russian.7z" \
                                "https://www.mediafire.com/file_premium/b3linupnamnx281/mod_russian.7z/file" \
                                "$REBIRTHDIR\mod_russian.7z" "7f27bb864bf032ac42701e1ecb548e2ae6a35ae1"
        AddSize 344
    SectionEnd

    Section /o "Spanish patch (by LeigiBoy)"
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_2 "https://www.nexusmods.com/residentevil1996/mods/2?tab=files&file_id=6" \
                                "https://cdn1.mulderload.eu/games/resident-evil/translation/Spanish%20translation%20(fixed)-2-1-1-1603507505.zip" \
                                "Spanish translation (fixed)-2-1-1-1603507505.zip" "fe0873b2cd3ac8a6a6c1a035747f4e203c24ad4c"
        !insertmacro NSISUNZ_EXTRACT "Spanish translation (fixed)-2-1-1-1603507505.zip" ".\" "AUTO_DELETE"
        AddSize 405
    SectionEnd
SectionGroupEnd

SectionGroup "Graphical improvements" gfx
    Section "Resident Evil HD Mod v20220831 (by TeamX)" gfx1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-hd-mod (repacked, see README for more information)
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/Resident_Evil_HD_mod_v20220831%20%5BRepack-MLD%5D.7z" \
                                "https://www.mediafire.com/file_premium/q35tg41d1fvhgas/Resident_Evil_HD_mod_v20220831_%255BRepack-MLD%255D.7z/file" \
                                "Resident_Evil_HD_mod_v20220831 [Repack-MLD].7z" "c803ec117013ec0dc43b13bc2768cf119cc2e8af"
        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_HD_mod_v20220831 [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 4495

        # Get latest Ultimate ASI Loader
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/dinput8-Win32.zip" \
                                "dinput8-Win32.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dinput8-Win32.zip" ".\" "dinput8.dll" "AUTO_DELETE"
        AddSize 5264
    SectionEnd

    Section "Seamless HD Project v1.1 (by RESHDP)" gfx2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-seamless-hd-project/downloads/resident-evil-seamless-hd-project-for-pc-mediakite (repacked, see README for more information)
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/RE_SHDP_1.1%20%5BRepack-MLD%5D.7z" \
                                "https://www.mediafire.com/file_premium/8yh2ultux4rnp1i/RE_SHDP_1.1_%255BRepack-MLD%255D.7z/file" \
                                "RE_SHDP_1.1 [Repack-MLD].7z" "61862c4f6afe0b81735e9d6cddc68444d675adea"
        !insertmacro NSIS7Z_EXTRACT "RE_SHDP_1.1 [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 104448
    SectionEnd

    Section "RE-Enhance v2.0 (by SonicB00M)" gfx3
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/reenhance-re1/downloads/re-enhance-re1-v2
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/288416" \
                                "https://cdn1.mulderload.eu/games/resident-evil/RE-ENHANCE_RE1_v2.0.zip" \
                                "RE-ENHANCE_RE1_v2.0.zip" "176d9bc3143b01521a1abca58963cda5"
        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE1_v2.0.zip" ".\" "AUTO_DELETE"
        AddSize 334848
    SectionEnd

    Section "dgVoodoo2 (by Dege)"
        SetOutPath "$REBIRTHDIR"

        # This particular game requires exactly the v2.64 version
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/dgVoodoo2_64_nopassword.zip" \
                                "https://www.mediafire.com/file_premium/dudqbe1p5r0vtge/dgVoodoo2_64_nopassword.zip/file" \
                                "dgVoodoo2.zip" "38815d63c33501dcb732f405b985d7339fc3c328"
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\JPN\" "MS\x86\DDraw.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3DImm.dll" "AUTO_DELETE"
        !insertmacro FORCE_RENAME ".\JPN\DDraw.dll" ".\re_DDraw.dll"
        AddSize 618

        # Configure dgVoodoo
        !insertmacro FILE_STR_REPLACE "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$REBIRTHDIR\dgVoodoo.conf"
        !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 4096" 1 1 "$REBIRTHDIR\dgVoodoo.conf"
        !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$REBIRTHDIR\dgVoodoo.conf"
    SectionEnd
SectionGroupEnd

SectionGroup /e "High Quality FMVs" fmv
    Section "960p - RE-Enhance FMV V1.1 (by SonicB00M)" fmv1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/reenhance-re1/downloads/re-enhance-re1-fmv-pack-v11
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/291051" \
                                "https://cdn1.mulderload.eu/games/resident-evil/RE-ENHANCE_RE1_FMV-Pack_V1.1.zip" \
                                "RE-ENHANCE_RE1_FMV-Pack_V1.1.zip" "a4f3ddfc6a75f038218885beecb6e8d3"
        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE1_FMV-Pack_V1.1.zip" ".\" "AUTO_DELETE"
        AddSize 1583350
    SectionEnd

    Section /o "480p - FMVs from HD Mod (by TeamX)" fmv2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-hd-mod (repacked to keep exclusives hires + remove other things)
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil/Resident_Evil_HD_mod_v20220831%20%5BVideos%20Only%5D.7z" \
                                "https://www.mediafire.com/file_premium/ev5hlatthp3dzhw/Resident_Evil_HD_mod_v20220831_%255BVideos_Only%255D.7z/file" \
                                "Resident_Evil_HD_mod_v20220831 [Videos Only].7z" "8bef4df7d857a831650a6c319e056c7b3cd1c55e"
        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_HD_mod_v20220831 [Videos Only].7z" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section "High Quality Audio v2020 (by lexas87)"
    SetOutPath "$REBIRTHDIR"

    # http://re123.bplaced.net/board/viewtopic.php?f=21&t=296 (repack to keep only sound & voice)
    !insertmacro DOWNLOAD_RANGE_1 "https://cdn1.mulderload.eu/games/resident-evil/Resident%20Evil%201%20HQ%20Sound%20Pack%20v8.5%20%5BRepack-MLD%5D.7z.001" \
                                  "Resident Evil 1 HQ Sound Pack v8.5 [Repack-MLD].7z.001" "f95afa7be268de4394f0a595a4c12207a90c09c6" 2
    !insertmacro NSIS7Z_EXTRACT "Resident Evil 1 HQ Sound Pack v8.5 [Repack-MLD].7z.001" ".\" "AUTO_DELETE"
    Delete "Resident Evil 1 HQ Sound Pack v8.5 [Repack-MLD].7z.002"
    AddSize 1020355
SectionEnd

!ifdef GOG_ENHANCEMENT_PACK_NSI
    Section
        # Copy readme
        SetOutPath "$INSTDIR\@mulderload"
        File "resources\gog\README.txt"
    SectionEnd
!else
    Section
        # Copy readme
        SetOutPath "$INSTDIR\@mulderload"
        File "resources\steam\README.txt"
    SectionEnd

    SectionGroup "MulderConfig (latest)"
        !insertmacro MULDERCONFIG_SECTIONS "$INSTDIR" "resources\steam"
        Section
            #ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
            Rename "$INSTDIR\4249100_Launcher.exe" "$INSTDIR\4249100_Launcher_o.exe"
            CopyFiles "$INSTDIR\MulderConfig.exe" "$INSTDIR\4249100_Launcher.exe"
        SectionEnd
    SectionGroupEnd

    SectionGroup "Free space by removing Non-REbirth files"
        Section /o "Remove english files (keep saves)"
            RMDir /r "$INSTDIR\english\USA"
            Delete "$INSTDIR\english\*.*"
        SectionEnd

        Section /o "Remove french files (keep saves)"
            RMDir /r "$INSTDIR\french\FRA"
            Delete "$INSTDIR\french\*.*"
        SectionEnd

        Section /o "Remove german files (keep saves)"
            RMDir /r "$INSTDIR\german\GER"
            Delete "$INSTDIR\german\*.*"
        SectionEnd

        Section /o "Remove japanese files (keep saves)"
            RMDir /r "$INSTDIR\japanese\JPN"
            Delete "$INSTDIR\japanese\*.*"
        SectionEnd
    SectionGroupEnd

    Function .onInit
        StrCpy $9 ${fmv1} ; Radio Button
        StrCpy $SELECT_FILENAME "4249100_Launcher.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249100_Biohazard"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
    FunctionEnd
!endif

Function .onSelChange
    # Some graphics options are grouped together
    ${If} ${SectionIsSelected} ${gfx1}
    ${OrIf} ${SectionIsSelected} ${gfx2}
    ${OrIf} ${SectionIsSelected} ${gfx3}
        !insertmacro SelectSection ${gfx1}
        !insertmacro SelectSection ${gfx2}
        !insertmacro SelectSection ${gfx3}
    ${Else}
        !insertmacro UnselectSection ${gfx1}
        !insertmacro UnselectSection ${gfx2}
        !insertmacro UnselectSection ${gfx3}
    ${EndIf}

    # FMV options are lax radio buttons (0 or 1 choice)
    ${If} ${SectionIsSelected} ${fmv}
        !insertmacro UnSelectSection ${fmv}
    ${Else}
        ${If} ${SectionIsSelected} ${fmv1}
        ${OrIf} ${SectionIsSelected} ${fmv2}
            !insertmacro StartRadioButtons $9
                !insertmacro RadioButton ${fmv1}
                !insertmacro RadioButton ${fmv2}
            !insertmacro EndRadioButtons
        ${EndIf}
    ${EndIf}
FunctionEnd
