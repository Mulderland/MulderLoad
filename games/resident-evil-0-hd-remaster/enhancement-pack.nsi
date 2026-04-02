!define MUI_WELCOMEPAGE_TEXT "\
Enhancement Pack for Resident Evil 0 HD Remaster, with:$\r$\n\
- Ultimate ASI Loader && Fusion Fix (by ThirteenAG)$\r$\n\
- Upscaled FMV (by SonicB00M)$\r$\n\
- Remastered Weapons Sounds v2 (by TheSorrow55)$\r$\n\
- Item Box MOD (by descawed)$\r$\n\
- Restored GameCube Fonts (by MrBunny && Mulder)$\r$\n\
- dgVoodoo2 (by Dege, to allow MSAA)$\r$\n\
- FPS Fix (by megatenfreak)$\r$\n\
- MulderConfig$\r$\n\
$\r$\n\
WARNING: The Upscaled FMV pack requires at least 1920x1080 resolution. Don't download it if your resolution is lower than that (Steam Deck for example)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Resident Evil 0 HD Remaster [Enhancement Pack]"

SectionGroup /e "Ultimate ASI Loader (by ThirteenAG)"
    Section
        AddSize 2321
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/dinput8-Win32.zip" "dinput8-Win32.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dinput8-Win32.zip" ".\" "dinput8.dll" "AUTO_DELETE"
    SectionEnd

    Section "Fusion Fix (by ThirteenAG)"
        AddSize 1170
        SetOutPath "$INSTDIR\scripts"

        !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/re0/ResidentEvil0.FusionFix.zip" \
                                "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/ResidentEvil0.FusionFix.zip" \
                                "ResidentEvil0.FusionFix.zip" "2a8767c284c5d921b81cad31a3eed531aee92488"
        !insertmacro NSISUNZ_EXTRACT_ONE "ResidentEvil0.FusionFix.zip" ".\" "scripts\ResidentEvil0.FusionFix.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "ResidentEvil0.FusionFix.zip" ".\" "scripts\ResidentEvil0.FusionFix.ini" "AUTO_DELETE"
        !insertmacro FILE_STR_REPLACE "BorderlessWindowed = 1" "BorderlessWindowed = 0" 1 1 "$INSTDIR\scripts\ResidentEvil0.FusionFix.ini"
    SectionEnd

    Section "Item Box MOD v0.5.2 (by descawed)"
        AddSize 2980
        SetOutPath "$INSTDIR\@itembox"

        # https://www.nexusmods.com/residentevil0biohazard0hdremaster/mods/39
        !insertmacro DOWNLOAD_2 "https://www.nexusmods.com/residentevil0biohazard0hdremaster/mods/39?tab=files&file_id=152" \
                                "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/Item%20Box%20v0.5.2-39-0-5-2-1771919806.zip" \
                                "Item Box.zip" "cbdaa855ef84889d574d23270c38e65205668ec9"
        !insertmacro NSISUNZ_EXTRACT "Item Box.zip" ".\" "AUTO_DELETE"

        Delete "dinput8.dll"
        Delete "re0box_uninstall.bat"
        !insertmacro FOLDER_MERGE "$INSTDIR\@itembox" "$INSTDIR"
        SetOutPath "$INSTDIR"
        RMDir "$INSTDIR\@itembox"

        !insertmacro FILE_STR_REPLACE "Mod=1" "Mod=0" 1 1 "$INSTDIR\re0box.ini"
    SectionEnd
SectionGroupEnd

Section
    !insertmacro 7Z_GET
SectionEnd

Section /o "Upscaled FMV (by SonicB00M)"
    AddSize 1321206
    SetOutPath "$INSTDIR"

    # https://www.moddb.com/mods/reenhance-re0-fmv-pack
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/292446" \
                            "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/RE-ENHANCE_RE0_FMV-Pack_V1.0.zip" \
                            "RE-ENHANCE_RE0_FMV-Pack_V1.0.zip" "990188fe24561d7264687f161aa17781"
    !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE0_FMV-Pack_V1.0.zip" ".\" "AUTO_DELETE"
SectionEnd

Section "Remastered Weapons Sounds (by TheSorrow55)"
    AddSize 21
    SetOutPath "$INSTDIR"

    # https://www.nexusmods.com/residentevil0biohazard0hdremaster/mods/48
    !insertmacro DOWNLOAD_2 "https://www.nexusmods.com/residentevil0biohazard0hdremaster/mods/48?tab=files&file_id=97" \
                            "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/Resident%20Evil%200%20hd%20remastered%20weapons%20sounds%20MOD-48-V2-1722805841.rar" \
                            "Resident Evil 0 hd remastered weapons sounds MOD.rar" "a560f1f91910e062f16927c31c4f5f9f36f7421a"
    !insertmacro 7Z_EXTRACT "Resident Evil 0 hd remastered weapons sounds MOD.rar" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\RE0 WEAPONS SOUNDS MOD" "$INSTDIR\nativePC\arc\sound\se\weapon"
SectionEnd

Section "Restored GameCube Fonts (by MrBunny)"
    SetOutPath "$INSTDIR"

    # https://residentevilmodding.boards.net/thread/5800/original-re0-font-mod
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/Original%20RE0%20Font%20Update%201.zip" \
                            "https://www.mediafire.com/file_premium/i7u9te4ofeuasod/Original_RE0_Font_Update_1.zip/file" \
                            "Original RE0 Font Update 1.zip" "ea9ad0686f570cfe22cf7bf52c6e91687df84a0a"
    !insertmacro NSISUNZ_EXTRACT "Original RE0 Font Update 1.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\Original RE0 Font\nativepc" "$INSTDIR\nativepc"
    RMDir /r "$INSTDIR\Original RE0 Font"

    # Mulder Repack for Item Box
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/Original%20RE0%20Font%20Update%201%20(Item%20Box).zip" \
                            "https://www.mediafire.com/file_premium/5p0qz550vsrhzuc/Original_RE0_Font_Update_1_%2528Item_Box%2529.zip/file" \
                            "Original RE0 Font Update 1 (Item Box).zip" "0a36f7016acd2c00637cf4ab6fe3bb1b4b27dee8"
    !insertmacro NSISUNZ_EXTRACT "Original RE0 Font Update 1 (Item Box).zip" ".\" "AUTO_DELETE"
SectionEnd

Section "dgVoodoo2 (by Dege)"
    AddSize 931
    SetOutPath "$INSTDIR"

    # Install dgVoodoo2
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D9.dll" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "$INSTDIR\D3D9.dll" "$INSTDIR\_dgVoodoo.dll.bak"

    # Configure dgVoodoo2
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 2048" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
SectionEnd

Section "FPS Fix (by megatenfreak)"
    AddSize 555
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/resident-evil-0-hd-remaster/RE0FixV2.rar" \
                            "https://www.mediafire.com/file_premium/y4q8g8tlraut3y9/RE0FixV2.rar/file" \
                            "RE0FixV2.rar" "92f4070f04b4742f8098d4786db95dbb1a13c5ab"
    !insertmacro 7Z_EXTRACT "RE0FixV2.rar" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "$INSTDIR\d3d9.dll" "$INSTDIR\_half.dll.bak"
SectionEnd

Section
    !insertmacro 7Z_REMOVE
SectionEnd

SectionGroup "MulderConfig (latest)"
    !insertmacro MULDERCONFIG_SECTIONS "$INSTDIR" "resources"
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "re0hd.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Resident Evil 0"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    !insertmacro MULDERCONFIG_ONINIT
FunctionEnd
