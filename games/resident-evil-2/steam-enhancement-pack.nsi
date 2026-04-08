!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Resident Evil 2 Steam, with:$\r$\n\
    - Downgrade to GOG version (including GOG's DX Wrapper)$\r$\n\
    - Resident Evil 2 Classic REbirth$\r$\n\
    - Translation patches$\r$\n\
    - Resident Evil 2 HD Mod (by TeamX)$\r$\n\
    - Seamless HD Project v2.0 Patch 2 (by RESHDP)$\r$\n\
    - RE-Enhance v2.0.1 (by SonicB00M)$\r$\n\
    - High Quality FMVs$\r$\n\
    - High Quality Audio (by lexas87)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to the Classic REbirth team!"

    !include "..\..\includes\tools\7z.nsh"
    !include "..\..\includes\templates\SelectTemplate.nsh"

    Name "Resident Evil 2 [Steam Enhancement Pack]"
!endif

Var /GLOBAL REBIRTHDIR

Section
    !ifdef GOG_ENHANCEMENT_PACK_NSI
        StrCpy $REBIRTHDIR "$INSTDIR"
    !else
        StrCpy $REBIRTHDIR "$INSTDIR\rebirth"
    !endif
SectionEnd

!ifndef GOG_ENHANCEMENT_PACK_NSI
    Section "Downgrade Steam to GOG v1.0 hotfix 5" gog_downgrade
        AddSize 46080
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/steam_to_gog_1.0hotfix5.7z" \
                                "https://www.mediafire.com/file_premium/ev3o3jckhaovhgt/steam_to_gog_1.0hotfix5.7z/file" \
                                "steam_to_gog_1.0hotfix5.7z" "e54d31a769bbeb69cf397b9b271baaab3a119615"
        !insertmacro NSIS7Z_EXTRACT "steam_to_gog_1.0hotfix5.7z" ".\" "AUTO_DELETE"
    SectionEnd
!endif

Section "Fix crash when saving"
    SetOutPath "$INSTDIR"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        File "resources\gog\bh2_japanese.reg"
        ExecWait 'regedit.exe /s "$INSTDIR\bh2_japanese.reg"'
        WriteRegStr HKCU "SOFTWARE\CAPCOM\BIOHAZARD2" "Save Path" "$INSTDIR\Saves\"
    !else
        # If Steam, check if GOG downgrade is selected.
        SectionGetFlags ${gog_downgrade} $0
        IntOp $0 $0 & ${SF_SELECTED}
        StrCmp $0 ${SF_SELECTED} reg_steam_downgraded reg_steam_original

        reg_steam_downgraded:
            File "resources\gog\bh2_japanese.reg"
            File "resources\steam\re2_english.reg"
            ExecWait 'regedit.exe /s "$INSTDIR\bh2_japanese.reg"'
            ExecWait 'regedit.exe /s "$INSTDIR\re2_english.reg"'
            WriteRegStr HKCU "SOFTWARE\CAPCOM\BIOHAZARD2" "Save Path" "$INSTDIR\japanese\Saves\"
            WriteRegStr HKCU "SOFTWARE\CAPCOM\RESIDENT EVIL2" "Save Path" "$INSTDIR\english\Saves\"
            Goto reg_end

        reg_steam_original:
            ExecWait 'regedit.exe /s "$INSTDIR\bh2_japanese.reg"'
            ExecWait 'regedit.exe /s "$INSTDIR\re2_english.reg"'
            WriteRegStr HKCU "SOFTWARE\CAPCOM\STEAM_BIO2" "Save Path" "$INSTDIR\japanese\Saves\"
            WriteRegStr HKCU "SOFTWARE\CAPCOM\STEAM_R EVIL2" "Save Path" "$INSTDIR\english\Saves\"

        reg_end:
    !endif
SectionEnd

Section "Resident Evil 2 Classic REbirth"
    SetOutPath "$INSTDIR"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        # If GOG: disable unwanted files
        !insertmacro FORCE_RENAME "$INSTDIR\BH2Launcher.exe" "$INSTDIR\BH2Launcher.exe.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\ClaireJ.exe" "$INSTDIR\ClaireJ.exe.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\ddraw.dll" "$INSTDIR\ddraw.dll.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dinput.dll" "$INSTDIR\dinput.dll.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dshow.dll" "$INSTDIR\dshow.dll.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.exe" "$INSTDIR\dxcfg.exe.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.ini" "$INSTDIR\dxcfg.ini.bak"
        !insertmacro FORCE_RENAME "$INSTDIR\LeonJ.exe" "$INSTDIR\LeonJ.exe.bak"
    !else
        # If Steam: copy files to a new "rebirth" folder
        AddSize 888832
        ${IfNot} ${FileExists} "$INSTDIR\rebirth\*.*"
            CopyFiles /SILENT "$INSTDIR\japanese\Common" "$INSTDIR\rebirth\Common"
            CopyFiles /SILENT "$INSTDIR\japanese\Gallery" "$INSTDIR\rebirth\Gallery"
            CopyFiles /SILENT "$INSTDIR\japanese\Pl0" "$INSTDIR\rebirth\Pl0"
            CopyFiles /SILENT "$INSTDIR\japanese\Pl1" "$INSTDIR\rebirth\Pl1"
            CopyFiles /SILENT "$INSTDIR\japanese\Zmovie" "$INSTDIR\rebirth\Zmovie"
        ${EndIf}
    !endif

    SetOutPath "$REBIRTHDIR"

    # Sourcenext DVD Update
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/sourcenext/sourcenext_dvd_update.7z" \
                            "https://www.mediafire.com/file_premium/es5y8hzqcxrknog/sourcenext_dvd_update.7z/file" \
                            "sourcenext_dvd_update.7z" "81029dec85034fe57538ade06c64865501dab113"
    !insertmacro NSIS7Z_EXTRACT "sourcenext_dvd_update.7z" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "Common\Data\Tit_bg.adt" "Common\Data\Title_bg.adt"
    AddSize 266

    # Sourcenext Patch 1.1.0
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/sourcenext/bio2patch1.1.0.7z" \
                            "https://www.mediafire.com/file_premium/hyrr80sjbq6s7jw/bio2patch1.1.0.7z/file" \
                            "bio2patch1.1.0.7z" "e35a99db5a07b26119f08f4402782108b2d6c790"
    !insertmacro NSIS7Z_EXTRACT "bio2patch1.1.0.7z" ".\" "AUTO_DELETE"
    AddSize 5988
    !ifdef GOG_ENHANCEMENT_PACK_NSI
        !insertmacro FORCE_RENAME "bio2.exe" "BH2Launcher.exe"
    !endif

    # Classic REbirth DLL
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/re2cr-2024-09-01.7z" \
                            "https://www.mediafire.com/file_premium/gmyfli4apolmcg9/re2cr-2024-09-01.7z/file" \
                            "re2cr-2024-09-01.7z" "c2f6a2f6ae9f6e8bb4a48f1aeb74b820fb398f46"
    !insertmacro NSIS7Z_EXTRACT "re2cr-2024-09-01.7z" ".\" "AUTO_DELETE"
    AddSize 3364

    # Copy default config.ini (without that, DATA1, DATA2 and DriverMode will have incorrect values)
    File "resources\config.ini"

    # Apply 4GB Patch
    !insertmacro DOWNLOAD_2 "https://ntcore.com/files/4gb_patch.zip" \
                            "https://cdn1.mulderload.eu/games/_common/ntcore_4gb_patch_v1.0.0.1.zip" \
                            "4gb_patch.zip" "c8b0d61937cb54fc8215124c0f737a1d29479c97"
    !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"
    !ifdef GOG_ENHANCEMENT_PACK_NSI
        ExecWait '4gb_patch.exe BH2Launcher.exe' $0
    !else
        ExecWait '4gb_patch.exe bio2.exe' $0
    !endif
    Delete "4gb_patch.exe"
    AddSize 5988
SectionEnd

SectionGroup "Translation patches"
    Section /o "French patch (by Vonmalvarius)"
        # https://www.abandonware-forums.org/forum/autres/les-aventuriers-de-la-traduction-perdue/822373-resident-evil-1-classic-rebirth-en-fran%C3%A7ais/page4#post892442
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/translation/mod_fr_RE2%20V1.0.2.7z" \
                                "https://www.mediafire.com/file_premium/ae29kuklkm8uu38/mod_fr_RE2_V1.0.2.7z/file" \
                                "$REBIRTHDIR\mod_fr_RE2 V1.0.2.7z" "c3a5f54e04d1e2401e8b99ac24d7427e5e1d429f"
        AddSize 1458
    SectionEnd

    Section /o "German patch (by Accandon)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/translation/mod_german_1_0_4_crypto.7z" \
                                "https://www.mediafire.com/file_premium/vyy165qhu08fnxf/mod_german_1_0_4_crypto.7z/file" \
                                "$REBIRTHDIR\mod_german_1_0_4_crypto.7z" "67bbb6fcb6811694f9dcd746adcb4494272f0080"
        AddSize 1468
    SectionEnd

    Section /o "Russian patch (by CasperPRO)"
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/translation/mod_russian_18-04-20.7z" \
                                "https://www.mediafire.com/file_premium/bk1ncoeckhqfu88/mod_russian_18-04-20.7z/file" \
                                "$REBIRTHDIR\mod_russian_18-04-20.7z" "a279a0a40cf99427f56f9d97ce954f3952e838f3"
        AddSize 2397
    SectionEnd

    Section /o "Spanish patch (by CITRU5)"
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_3 "https://www.nexusmods.com/residentevil21998/mods/2?tab=files&file_id=121" \
                                "https://cdn1.mulderload.eu/games/resident-evil-2/translation/BIOHAZARD%202%20SourceNext%20ES%201.1-2-1-1-1764695405.zip" \
                                "https://www.mediafire.com/file_premium/k1tauz2gsuxhkvr/BIOHAZARD_2_SourceNext_ES_1.1-2-1-1-1764695405.zip/file" \
                                "BIOHAZARD 2 SourceNext ES 1.1-2-1-1-1764695405.zip" "8e54e64d9e440c48af8eae1751f12d333c04b52e"
        !insertmacro NSISUNZ_EXTRACT_ONE "BIOHAZARD 2 SourceNext ES 1.1-2-1-1-1764695405.zip" ".\" "Mod_BH2_ES_1.1.7z" "AUTO_DELETE"
        AddSize 11818
    SectionEnd
SectionGroupEnd

SectionGroup "Graphical improvements"
    Section "RE 2 HD Mod v20220716 (by TeamX)" gfx1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-2-hd-mod/downloads/resident-evil-2-hd-mod (repacked, see README for more information)
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/gfx/Resident_Evil_2_HD_mod_v20220716%20%5BRepack-MLD%5D.7z" \
                                "https://www.mediafire.com/file_premium/ufadb70hgerwk83/Resident_Evil_2_HD_mod_v20220716_%255BRepack-MLD%255D.7z/file" \
                                "Resident_Evil_2_HD_mod_v20220716 [Repack-MLD].7z" "9b8f7876152172a438fce46755d1e4443e858074"
        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_2_HD_mod_v20220716 [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 83661

        # Get latest Ultimate ASI Loader
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/dsound-Win32.zip" \
                                "dsound-Win32.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dsound-Win32.zip" ".\" "dsound.dll" "AUTO_DELETE"
        AddSize 5264
    SectionEnd

    Section "Seamless HD Project v2.0 p2 (by RESHDP)" gfx2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-2-seamless-hd-project/downloads/resident-evil-2-seamless-hd-project-for-pc-sourcenext (repacked, see README for more information)
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-2/gfx/RE2_SHDP_2.0_update_for_TeamX_HD_patch.2%20%5BRepack-MLD%5D.7z" \
                                "https://www.mediafire.com/file_premium/433pt7wb2jr1ds7/RE2_SHDP_2.0_update_for_TeamX_HD_patch.2_%255BRepack-MLD%255D.7z/file" \
                                "RE2_SHDP_2.0_update_for_TeamX_HD_patch.2 [Repack-MLD].7z" "cfbc90cfedec5eac0282c9b6f29d9f56792ebed9"
        !insertmacro NSIS7Z_EXTRACT "RE2_SHDP_2.0_update_for_TeamX_HD_patch.2 [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 35840
    SectionEnd

    Section "RE-Enhance v2.0.1 (by SonicB00M)" gfx3
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/reenhance-re2/downloads/re-enhance-re2-v201
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/279069" \
                                "https://cdn1.mulderload.eu/games/resident-evil-2/gfx/RE-ENHANCE_RE2_v2.0.1.zip" \
                                "RE-ENHANCE_RE2_v2.0.1.zip" "b6658149a2ecdf8a1df7674f282e33b2"
        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE2_v2.0.1.zip" ".\" "AUTO_DELETE"
        AddSize 786434
    SectionEnd

    Section "dgVoodoo2 (by Dege)"
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_DGVOODOO2
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\Common\" "MS\x86\DDraw.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3DImm.dll" "AUTO_DELETE"
        !insertmacro FORCE_RENAME ".\Common\DDraw.dll" ".\re2_DDraw.dll"
        AddSize 914

        # Configure dgVoodoo
        !insertmacro FILE_STR_REPLACE "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$REBIRTHDIR\dgVoodoo.conf"
        !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 4096" 1 1 "$REBIRTHDIR\dgVoodoo.conf"
        !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$REBIRTHDIR\dgVoodoo.conf"
    SectionEnd
SectionGroupEnd

SectionGroup "High Quality FMVs" fmv
    Section "960p - RE-Enhance FMV 1.0 (by SonicB00M)" fmv1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/reenhance-re2/downloads/re-enhance-re2-fmv-pack-v10
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/291855" \
                                "https://cdn1.mulderload.eu/games/resident-evil-2/videos/RE-ENHANCE_RE2_FMV-Pack_V1.0.zip" \
                                "RE-ENHANCE_RE2_FMV-Pack_V1.0.zip" "d97ba594eee809fa242c5818f9534105"
        !insertmacro 7Z_GET ; NSISUNZ_EXTRACT doesn't support zip > 4GB
        !insertmacro 7Z_EXTRACT "RE-ENHANCE_RE2_FMV-Pack_V1.0.zip" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
        AddSize 3460301
        AddSize -504934 # original videos

        MessageBox MB_YESNO|MB_DEFBUTTON1 "Replace 'BioHazard 2' with 'Resident Evil 2' in FMV files?" IDYES fmv1_re2 IDNO fmv1_bh2
        fmv1_re2:
            Delete "pl0\Zmovie\r704l_BIOHAZARD.bin"
            Delete "pl0\Zmovie\title_l_BIOHAZARD.bin"
            Delete "pl1\Zmovie\r704c_BIOHAZARD.bin"
            Delete "pl1\Zmovie\titlec_BIOHAZARD.bin"
            Delete "zmovie\staff_BIOHAZARD.bin"
            Goto fmv1_end

        fmv1_bh2:
            !insertmacro FORCE_RENAME "pl0\Zmovie\r704l_BIOHAZARD.bin" "pl0\Zmovie\r704l.bin"
            !insertmacro FORCE_RENAME "pl0\Zmovie\title_l_BIOHAZARD.bin" "pl0\Zmovie\title_l.bin"
            !insertmacro FORCE_RENAME "pl1\Zmovie\r704c_BIOHAZARD.bin" "pl1\Zmovie\r704c.bin"
            !insertmacro FORCE_RENAME "pl1\Zmovie\titlec_BIOHAZARD.bin" "pl1\Zmovie\titlec.bin"
            !insertmacro FORCE_RENAME "zmovie\staff_BIOHAZARD.bin" "zmovie\staff.bin"

        fmv1_end:
    SectionEnd

    Section /o "960p - FMVs from HD Mod (by TeamX)" fmv2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-hd-mod (repacked to keep exclusives hires + remove other things)
        !insertmacro DOWNLOAD_RANGE_1 "https://cdn1.mulderload.eu/games/resident-evil-2/videos/Resident_Evil_2_HD_mod_v20220716%20%5BVideos%20Only%5D.7z.001" \
                                      "Resident_Evil_2_HD_mod_v20220716 [Videos Only].7z.001" "a67eca24c53f27d77c091c602d4a887fedfb72da" 2
        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_2_HD_mod_v20220716 [Videos Only].7z.001" ".\" "AUTO_DELETE"
        Delete "Resident_Evil_2_HD_mod_v20220716 [Videos Only].7z.002"
        AddSize 1000448
        AddSize -504934 # original videos
    SectionEnd

    Section /o "480p - FMVs from Sourcenext release" fmv3
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_RANGE_1 "https://cdn1.mulderload.eu/games/resident-evil-2/videos/sourcenext_dvd_videos.7z.001" \
                                      "sourcenext_dvd_videos.7z.001" "dc52f3154436842d43b45ee4d86acee28d4dbfd4" 3
        !insertmacro NSIS7Z_EXTRACT "sourcenext_dvd_videos.7z.001" ".\" ""
        !insertmacro DELETE_RANGE "sourcenext_dvd_videos.7z.001" 3
        AddSize 1205862
        AddSize -504934 # original videos
    SectionEnd
SectionGroupEnd

Section "High Quality Audio v2023 (by lexas87)"
    SetOutPath "$REBIRTHDIR"

    # http://re123.bplaced.net/board/viewtopic.php?f=22&t=308 (repack to keep only sound & voice)
    !insertmacro DOWNLOAD_RANGE_1 "https://cdn1.mulderload.eu/games/resident-evil-2/audio/Resident%20Evil%202%20-%20Classic%20REbirth%20HQ%20Music%20and%20Sound%2021-01-2023%20%5BRepack-MLD%5D.7z.001" \
                                  "Resident Evil 2 - Classic REbirth HQ Music and Sound 21-01-2023 [Repack-MLD].7z.001" "4ac5b6a80aa68250eaaa0dd100049460ba2ba3ae" 2
    !insertmacro NSIS7Z_EXTRACT "Resident Evil 2 - Classic REbirth HQ Music and Sound 21-01-2023 [Repack-MLD].7z.001" ".\" "AUTO_DELETE"
    Delete "Resident Evil 2 - Classic REbirth HQ Music and Sound 21-01-2023 [Repack-MLD].7z.002"
    AddSize 1279263
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
            Rename "$INSTDIR\4249110_Launcher.exe" "$INSTDIR\4249110_Launcher_o.exe"
            CopyFiles "$INSTDIR\MulderConfig.exe" "$INSTDIR\4249110_Launcher.exe"
        SectionEnd
    SectionGroupEnd

    SectionGroup "Free space by removing Non-REbirth files"
        Section /o "Remove english files (keep saves)"
            RMDir /r "$INSTDIR\english\Common"
            RMDir /r "$INSTDIR\english\Gallery"
            RMDir /r "$INSTDIR\english\Pl0"
            RMDir /r "$INSTDIR\english\Pl1"
            RMDir /r "$INSTDIR\english\Zmovie"
            Delete "$INSTDIR\english\*.*"
        SectionEnd

        Section /o "Remove french files (keep saves)"
            RMDir /r "$INSTDIR\french\Common"
            RMDir /r "$INSTDIR\french\Gallery"
            RMDir /r "$INSTDIR\french\Pl0"
            RMDir /r "$INSTDIR\french\Pl1"
            RMDir /r "$INSTDIR\french\Zmovie"
            Delete "$INSTDIR\french\*.*"
        SectionEnd

        Section /o "Remove german files (keep saves)"
            RMDir /r "$INSTDIR\german\Common"
            RMDir /r "$INSTDIR\german\Gallery"
            RMDir /r "$INSTDIR\german\Pl0"
            RMDir /r "$INSTDIR\german\Pl1"
            RMDir /r "$INSTDIR\german\Zmovie"
            Delete "$INSTDIR\german\*.*"
        SectionEnd

        Section /o "Remove italian files (keep saves)"
            RMDir /r "$INSTDIR\italian\Common"
            RMDir /r "$INSTDIR\italian\Gallery"
            RMDir /r "$INSTDIR\italian\Pl0"
            RMDir /r "$INSTDIR\italian\Pl1"
            RMDir /r "$INSTDIR\italian\Zmovie"
            Delete "$INSTDIR\italian\*.*"
        SectionEnd

        Section /o "Remove japanese files (keep saves)"
            RMDir /r "$INSTDIR\japanese\Common"
            RMDir /r "$INSTDIR\japanese\Gallery"
            RMDir /r "$INSTDIR\japanese\Pl0"
            RMDir /r "$INSTDIR\japanese\Pl1"
            RMDir /r "$INSTDIR\japanese\Zmovie"
            Delete "$INSTDIR\japanese\*.*"
        SectionEnd

        Section /o "Remove spanish files (keep saves)"
            RMDir /r "$INSTDIR\spanish\Common"
            RMDir /r "$INSTDIR\spanish\Gallery"
            RMDir /r "$INSTDIR\spanish\Pl0"
            RMDir /r "$INSTDIR\spanish\Pl1"
            RMDir /r "$INSTDIR\spanish\Zmovie"
            Delete "$INSTDIR\spanish\*.*"
        SectionEnd
    SectionGroupEnd

    Function .onInit
        StrCpy $9 ${fmv1} ; Radio Button
        StrCpy $SELECT_FILENAME "4249110_Launcher.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249110_Biohazard2"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
        !insertmacro MULDERCONFIG_ONINIT
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

    # FMV options are strict radio buttons (1 mandatory choice)
    ${If} ${SectionIsSelected} ${fmv}
        !insertmacro UnSelectSection ${fmv}
        !insertmacro SelectSection $9
    ${Else}
        !insertmacro StartRadioButtons $9
            !insertmacro RadioButton ${fmv1}
            !insertmacro RadioButton ${fmv2}
            !insertmacro RadioButton ${fmv3}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
