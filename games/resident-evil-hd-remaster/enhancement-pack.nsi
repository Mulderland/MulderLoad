!define MUI_WELCOMEPAGE_TEXT "\
This Enhancement Pack includes the following:$\r$\n\
- Ultimate ASI Loader && Fusion Fix (by ThirteenAG)$\r$\n\
- Bug Fixes (by NTCore, jayandsilentrage, Kayael, zeikar)$\r$\n\
- Graphical improvements (by Bloodyhunter, Arcturium, SonicB00M, Dege, Kayael, nayef, masterotaku)$\r$\n\
- Gamecube Font Mod (by MrBunny)$\r$\n\
- Remastered Inventory Icons (by AndehX)$\r$\n\
- Weapons Sounds Mod (by TheSorrow55)$\r$\n\
- MulderConfig$\r$\n\
$\r$\n\
WARNING: The Upscaled FMV pack requires at least 1920x1080 resolution. Don't download it if your resolution is lower than that (Steam Deck for example)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Resident Evil HD Remaster [Enhancement Pack]"

Section
    !insertmacro 7Z_GET
SectionEnd

Section "Fusion Fix (by ThirteenAG)"
    SetOutPath "$INSTDIR"

    # Fusion Fix
    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/re1/ResidentEvil.FusionFix.zip" \
                            "https://cdn.mulderload.eu/games/resident-evil-hd-remaster/impr_misc/ResidentEvil.FusionFix.zip" \
                            "ResidentEvil.FusionFix.zip" \
                            "d0073d31f482b1dbae1abdeeb37bf41d745ad316"

    !insertmacro NSISUNZ_EXTRACT "ResidentEvil.FusionFix.zip" ".\" "AUTO_DELETE"
    !insertmacro FILE_STR_REPLACE "BorderlessWindowed = 1" "BorderlessWindowed = 0" 1 1 "$INSTDIR\scripts\ResidentEvil.FusionFix.ini"
    AddSize 1093

    # Update dinput8.dll with latest Ultimate ASI Loader
    !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/dinput8-Win32.zip" "dinput8-Win32.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dinput8-Win32.zip" ".\" "dinput8.dll" "AUTO_DELETE"
    AddSize 5272
SectionEnd

SectionGroup "Bug fixes"
    Section "4GB Patch (by NTCore)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/tools/ntcore/4gb_patch.zip" \
                                "https://ntcore.com/files/4gb_patch.zip" \
                                "4gb_patch.zip" \
                                "c8b0d61937cb54fc8215124c0f737a1d29479c97"

        !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"

        ExecWait '4gb_patch.exe bhd.exe' $0
        AddSize 9872
        Delete "4gb_patch.exe"
    SectionEnd

    Section "ERR09 Crash Fix (by jayandsilentrage)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/180?tab=files&file_id=361" \
                                "d3d9.dll (G-Sync Fix).7z" \
                                "a54e0a605939f370da7b8ea89311a2c2d77df982"

        !insertmacro NSIS7Z_EXTRACT "d3d9.dll (G-Sync Fix).7z" ".\" "AUTO_DELETE"
        AddSize 511
        !insertmacro FORCE_RENAME "$INSTDIR\d3d9.dll" "$INSTDIR\_crashfix.dll"
    SectionEnd

    Section "Lab lift fix (by Kayael)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/98?tab=files&file_id=197" \
                                "Lab lift fix-98-1-0-1714239591.zip" \
                                "ed2b3ba606a510b186116acb263f789f4cea059a"

        !insertmacro NSISUNZ_EXTRACT "Lab lift fix-98-1-0-1714239591.zip" ".\" "AUTO_DELETE"
        AddSize 15269
        Delete "modinfo.ini"
    SectionEnd

    Section "Normalized Soundtrack (by zeikar & MrBunny)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_RANGE_1 "https://cdn.mulderload.eu/games/resident-evil-hd-remaster/fix/Normalized Soundtrack Mod [Repack-MLD].7z.001" \
                                      "Normalized Soundtrack Mod [Repack-MLD].7z.001" \
                                      "8e3632372fb1746839b865d4f5adeecabbecfa03" \
                                      2

        !insertmacro NSIS7Z_EXTRACT "Normalized Soundtrack Mod [Repack-MLD].7z.001" ".\" "AUTO_DELETE"
        AddSize 386423
        !insertmacro DELETE_RANGE "Normalized Soundtrack Mod [Repack-MLD].7z.001" 2
    SectionEnd
SectionGroupEnd

SectionGroup /e "Graphical improvements"
    Section "[Characters] Retcon Pack (by Bloodyhunter)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/20?tab=files&file_id=96" \
                                "Retcon Pack (REmaster)-20-2-2-1640281803.rar" \
                                "c8f160186c902404d07cedd9d1dd6db1e5873147"

        !insertmacro 7Z_EXTRACT "Retcon Pack (REmaster)-20-2-2-1640281803.rar" ".\" "AUTO_DELETE"
        AddSize 806
        Delete "$INSTDIR\Retcon Pack\modinfo.ini"
        Delete "$INSTDIR\Retcon Pack\screenshot.jpeg"
        Rename "$INSTDIR\Retcon Pack\README.txt" "$INSTDIR\Retcon Pack\Retcon Pack.txt"

        !insertmacro FOLDER_MERGE "$INSTDIR\Retcon Pack" "$INSTDIR"
    SectionEnd

    Section /o "[Textures] RESCALE (by Arcturium)"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/102?tab=files&file_id=201" \
                                "RESCALE Version 1.0-102-1-0-1715439796.zip" \
                                "54cce42d12991ac72af60628f99c25726c6d037b"

        !insertmacro 7Z_EXTRACT "RESCALE Version 1.0-102-1-0-1715439796.zip" ".\" "AUTO_DELETE" # NSISUNZ doesn't work with archive bigger than 4GB, so we have to use 7z for this one
        Delete "Installation Instructions.txt"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/102?tab=files&file_id=205" \
                                "RESCALE V1 - Hotfix 2-102-1-0-1715618408.zip" \
                                "a13b02c56abb5b447f9f50fa23670fb2fa5cebc0"

        !insertmacro NSISUNZ_EXTRACT "RESCALE V1 - Hotfix 2-102-1-0-1715618408.zip" ".\" "AUTO_DELETE"
        Delete "Patch Notes.txt"

        #AddSize -230979
    SectionEnd

    Section /o "[Videos] RE-Enhance FMVs (by SonicB00M)"
        SetOutPath "$INSTDIR"
        # Alert, requires to play at 1080p. Don't download if you have a lower resolution (Steam Deck for example)

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/re-enhance-re1r-fmv-pack/downloads/re-enhance-re1r-fmv-pack-v11" \
                                "RE-ENHANCE_RE1R_FMV-Pack_V1.1.zip" \
                                "2988f79371211e3e56cf855a4d75eabf"

        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE1R_FMV-Pack_V1.1.zip" ".\" "AUTO_DELETE"
        #AddSize -1260602
    SectionEnd

    Section "dgVoodoo2 (by Dege)"
        AddSize 931
        SetOutPath "$INSTDIR\@mulderload\dgVoodoo2"

        # Install dgVoodoo2
        !insertmacro DOWNLOAD_DGVOODOO2
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D9.dll" "AUTO_DELETE"
        AddSize 931
        !insertmacro FORCE_RENAME "D3D9.dll" "_dgVoodoo2.dll"

        SetOutPath "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\dgVoodoo2" "$INSTDIR"

        # Configure dgVoodoo2
        !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 2048" 1 1 "$INSTDIR\dgVoodoo.conf"
        !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
    SectionEnd

    Section "East stairs lightning fix (by Kayael or nayef)"
        SetOutPath "$INSTDIR"

        # Check if RESCALE is installed, by looking at a "stable" texture (ie not present in Hotfix 2, not present in a East stairs lighting fix)
        !insertmacro FILE_HASH_EQUALS "nativePC\arc\scr\st01\r100\r10000.arc" "6379ec9118423634284e7ef617bd27d0150af6ec" $R0
        ${If} $R0 == "1"
            DetailPrint " // East stairs lightning fix: RESCALE detected, using nayef's mod"

            !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/158?tab=files&file_id=324" \
                                    "RESCALE fix E stairs lightning-158-1-0-1766106497.zip" \
                                    "3fd487023cef635a0a07bc7975e445949d848fb5"

            !insertmacro NSISUNZ_EXTRACT "RESCALE fix E stairs lightning-158-1-0-1766106497.zip" ".\" "AUTO_DELETE"
        ${Else}
            DetailPrint " // East stairs lightning fix: RESCALE not detected, using kayael's mod"
            !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/99?tab=files&file_id=198" \
                                    "East stairs lightning fix-99-1-0-1714746376.zip" \
                                    "449cb5d97e6d9020224dae0cf9d1e66a1e7e09f9"

            !insertmacro NSISUNZ_EXTRACT "East stairs lightning fix-99-1-0-1714746376.zip" ".\" "AUTO_DELETE"
            Delete "modinfo.ini"
            Delete "screenshot.jpg"
        ${EndIf}
    SectionEnd

    Section "Real time graphics mod (by masterotaku)"
        SetOutPath "$INSTDIR\@mulderload\realtimegraphics"

        !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/games/resident-evil-hd-remaster/impr_gfx/REmake_settings_mod.zip" \
                                "https://s3.amazonaws.com/masterotaku/Resident+Evil+1/REmake_settings_mod.zip" \
                                "REmake_settings_mod.zip" \
                                "288a684f3dc835d0b19c74d705d817fbcd257610"

        !insertmacro 7Z_EXTRACT "REmake_settings_mod.zip" ".\" "AUTO_DELETE" # this zip doesn't extract well with NSISUNZ, so we have to use 7z for this one
        AddSize 676
        !insertmacro FORCE_RENAME "d3d9.dll" "_realtimegraphics.dll"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\realtimegraphics" "$INSTDIR"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Other improvements"
    Section "Gamecube Font Mod (by MrBunny)"
        SetOutPath "$INSTDIR"

        # Check if original file have not been backuped already (ie if the user already installed the enhancement pack before)
        ${IfNot} ${FileExists} "$INSTDIR\nativePC\arc\id\e_rom\_common.ori"
             CopyFiles /SILENT "$INSTDIR\nativePC\arc\id\e_rom\common.arc" "$INSTDIR\nativePC\arc\id\e_rom\_common.ori"
        ${EndIf}

        # https://residentevilmodding.boards.net/thread/5095/remake-font-mod
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-hd-remaster/impr_gfx/FontModUpdate2.zip" \
                                "FontModUpdate2.zip" \
                                "d10a9012866a155a829c925e6b1b0fda7861d5d9"

        !insertmacro NSISUNZ_EXTRACT_ONE "FontModUpdate2.zip" ".\" "Original REmake Font\nativePC\arc\id\e_rom\common.arc" "AUTO_DELETE"
        AddSize 1695
        !insertmacro FORCE_RENAME "$INSTDIR\common.arc" "$INSTDIR\nativePC\arc\id\e_rom\_common.mod"
    SectionEnd

    Section "Remastered Inventory Icons (by AndehX)"
        SetOutPath "$INSTDIR"

        # Check if original file have not been backuped already (ie if the user already installed the enhancement pack before)
        ${IfNot} ${FileExists} "$INSTDIR\nativePC\arc\id\e_rom\subscr\_itemicon.ori"
             CopyFiles /SILENT "$INSTDIR\nativePC\arc\id\e_rom\subscr\itemicon.arc" "$INSTDIR\nativePC\arc\id\e_rom\subscr\_itemicon.ori" 474
        ${EndIf}

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/97?tab=files&file_id=190" \
                                "inventory_icons_v1-97-1-1708634320.zip" \
                                "2807f054efb4cbf27072e69c13960a3aacfaa6e5"

        !insertmacro NSISUNZ_EXTRACT_ONE "inventory_icons_v1-97-1-1708634320.zip" ".\" "nativePC\arc\id\e_rom\subscr\itemicon.arc" "AUTO_DELETE"
        AddSize 468
        !insertmacro FORCE_RENAME "$INSTDIR\itemicon.arc" "$INSTDIR\nativePC\arc\id\e_rom\subscr\_itemicon.mod"
    SectionEnd

    Section "Weapons Sounds Mod (by TheSorrow55)"
        SetOutPath "$INSTDIR"

        # Check if original files have not been backuped already (ie if the user already installed the enhancement pack before)
        ${IfNot} ${FileExists} "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep02.ori"
             CopyFiles /SILENT "$INSTDIR\nativePC\arcPC\sound\se\wep\wep02.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep02.ori" 85
             CopyFiles /SILENT "$INSTDIR\nativePC\arcPC\sound\se\wep\wep03.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep03.ori" 97
             CopyFiles /SILENT "$INSTDIR\nativePC\arcPC\sound\se\wep\wep04.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep04.ori" 95
        ${EndIf}

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevilbiohazardhdremaster/mods/75?tab=files&file_id=180" \
                                "REHD SOUND MOD V2-75-v2-1707853350.rar" \
                                "c01e21b1989065c05b81733d081435dc601b94af"

        !insertmacro 7Z_EXTRACT "REHD SOUND MOD V2-75-v2-1707853350.rar" ".\" "AUTO_DELETE"
        AddSize 295

        # Move files close to their final location
        !insertmacro FORCE_RENAME "$INSTDIR\REHD SOUND MOD\wep02.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep02.mod"
        !insertmacro FORCE_RENAME "$INSTDIR\REHD SOUND MOD\wep03.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep03.mod"
        !insertmacro FORCE_RENAME "$INSTDIR\REHD SOUND MOD\wep04.arc" "$INSTDIR\nativePC\arcPC\sound\se\wep\_wep04.mod"

        # Cleanup
        RMDir /r "$INSTDIR\REHD SOUND MOD"
    SectionEnd
SectionGroupEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Section
    !insertmacro 7Z_REMOVE
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "bhd.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Resident Evil Biohazard HD REMASTER"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
