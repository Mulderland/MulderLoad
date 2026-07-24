!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Max Payne 2, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Bug fixes / Sound fixes$\r$\n\
- Surround sound support$\r$\n\
- Enhanced Anti-Aliasing (via DxWrapper)$\r$\n\
- Widescreen fix (by ThirteenAG)$\r$\n\
- Xbox Rain Droplets (by ThirteenAG)$\r$\n\
- Bonus Chapters$\r$\n\
- Language Pack$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to ThirteenAG for his passionate work on this game."

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\I6Comp.nsh"

Name "Max Payne 2 [Enhancement Pack]"

SectionGroup "Bug fixes"
    Section "Sound fixes"
        # DSOAL
        SetOutPath "$INSTDIR\.MulderConfig\sound_dsoal"

        !insertmacro DOWNLOAD_2 "https://github.com/kcat/dsoal/releases/download/archive/DSOAL_r693.zip" \
                                "https://cdn.mulderload.eu/tools/dsoal/DSOAL_r693.zip" \
                                "DSOAL.zip" \
                                "8cf38acb9ccd8a405b316bf4e7fd9fb05565234d9867f7ee4932e6ee0839ccbc"

        !insertmacro NSISUNZ_EXTRACT "DSOAL.zip" ".\" "AUTO_DELETE"
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\alsoft.ini" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\dsoal-aldrv.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r693.zip" ".\" "DSOAL\Win32\dsound.dll" "AUTO_DELETE"

        # IndirectSound
        SetOutPath "$INSTDIR\.MulderConfig\sound_indirectsound"

        !insertmacro DOWNLOAD_2 "https://www.indirectsound.com/downloads/IndirectSound_0_20.zip" \
                                "https://cdn.mulderload.eu/tools/indirectsound/IndirectSound_0_20.zip" \
                                "IndirectSound.zip" \
                                "f8f8a3b8b5879ec0438e7324435a8ac29969fcbd"

        !insertmacro NSISUNZ_EXTRACT "IndirectSound.zip" ".\" "AUTO_DELETE"

        # Audio Mix Tweaks - https://www.moddb.com/games/max-payne-2/downloads/mp2-manual-audio-mix-tweaks - Repacked in .ras
        SetOutPath "$INSTDIR\.MulderConfig\fix_audio_mix_tweaks"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/max-payne-2-the-fall-of-max-payne/fix/MP2_manual_audio_mix_tweaks [Repack-MLD].7z" \
                                "MP2_manual_audio_mix_tweaks [Repack-MLD].7z" \
                                "6bf77c721b52b2364ffef35fb583c8f0b6ad9a41"

        !insertmacro NSIS7Z_EXTRACT "MP2_manual_audio_mix_tweaks [Repack-MLD].7z" ".\" "AUTO_DELETE"

        # Make dsound.dll override works
        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{47D4D946-62E8-11CF-93BC-444553540000}\InprocServer32" "" "dsound.dll"
        WriteRegStr HKCU "Software\Classes\WOW6432Node\CLSID\{3901CC3F-84B5-4FA4-BA35-AA8172B8A09B}\InprocServer32" "" "dsound.dll"
    SectionEnd

    Section "Startup Hang Patch"
        SetOutPath "$INSTDIR\@mulderload\startup"

        !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/838-max-payne-series-startup-hang-patch/" \
                                "MaxPayneStartupHangPatchv1.01.zip" \
                                "ab5b0e667768714ad66f8056fade6b70202a9a4c"

        !insertmacro NSISUNZ_EXTRACT "MaxPayneStartupHangPatchv1.01.zip" ".\" "AUTO_DELETE"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\startup\Max Payne 2" "$INSTDIR"

        # Clean
        SetOutPath "$INSTDIR"
        RMDir /r "$INSTDIR\@mulderload\startup"
    SectionEnd
SectionGroupEnd

Section "DxWrapper + Widescreen Fix + Xbox Rain Droplets (by ThirteenAG)"
    # Widescreen Fix
    SetOutPath "$INSTDIR\scripts"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/mp2/MaxPayne2.WidescreenFix.zip" \
                            "https://cdn.mulderload.eu/games/max-payne-2-the-fall-of-max-payne/impr_gfx/MaxPayne2.WidescreenFix.zip" \
                            "MaxPayne2.WidescreenFix.zip" \
                            "30f7e37ad4a695dd8d14f192572eb5992dca209f"

    !insertmacro NSISUNZ_EXTRACT_ONE "MaxPayne2.WidescreenFix.zip" ".\" "scripts\MaxPayne2.WidescreenFix.asi" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "MaxPayne2.WidescreenFix.zip" ".\" "scripts\MaxPayne2.WidescreenFix.ini" "AUTO_DELETE"
    AddSize 310

    !insertmacro FILE_STR_REPLACE "GraphicNovelMode = 0" "GraphicNovelMode = 1" 1 1 "$INSTDIR\scripts\MaxPayne2.WidescreenFix.ini"

    # DxWrapper
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/elishacloud/dxwrapper/releases/download/v1.1.6900.22/dx8.binaries.zip" \
                            "https://cdn.mulderload.eu/tools/dxwrapper/v1.1.69/dx8.binaries.zip" \
                            "dxwrapper.zip" \
                            "133907ab4c93add5296a481ab892489807b0af76"

    !insertmacro NSISUNZ_EXTRACT "dxwrapper.zip"  ".\" "AUTO_DELETE"
    AddSize 8110

    !insertmacro FILE_STR_REPLACE "DisableLogging             = 0" "DisableLogging             = 1" 1 1 "$INSTDIR\dxwrapper.ini"
    !insertmacro FILE_STR_REPLACE "LoadPlugins                = 0" "LoadPlugins                = 1" 1 1 "$INSTDIR\dxwrapper.ini"
    !insertmacro FILE_STR_REPLACE "LoadFromScriptsOnly        = 0" "LoadFromScriptsOnly        = 1" 1 1 "$INSTDIR\dxwrapper.ini"
    !insertmacro FILE_STR_REPLACE "SingleProcAffinity         = 0" "SingleProcAffinity         = 1" 1 1 "$INSTDIR\dxwrapper.ini"
    !insertmacro FILE_STR_REPLACE "LimitPerFrameFPS           = 0" "LimitPerFrameFPS           = 60" 1 1 "$INSTDIR\dxwrapper.ini"

    # Xbox Rain Droplets
    SetOutPath "$INSTDIR\.MulderConfig\xbox_rain_droplets\scripts"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/XboxRainDroplets/releases/download/maxpayne2/MaxPayne2.XboxRainDroplets.zip" \
                            "https://cdn.mulderload.eu/games/max-payne-2-the-fall-of-max-payne/impr_gfx/MaxPayne2.XboxRainDroplets.zip" \
                            "MaxPayne2.XboxRainDroplets.zip" \
                            "192fefbc98bad97be60363fcb1101c0262c2ae0554beae48da4b3de92bff345b"

    !insertmacro NSISUNZ_EXTRACT "MaxPayne2.XboxRainDroplets.zip" ".\" "AUTO_DELETE"
    AddSize 1045
SectionEnd

SectionGroup "Other Improvements"
    Section "Bonus chapters for 'Dead Man Walking'"
        SetOutPath "$INSTDIR\@mulderload\bonus"

        !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/885-max-payne-2-bonus-chapters/" \
                                "MaxPayne2BonusChapters.zip" \
                                "bb27a993b6ac53069f42ff6a36282248205d528b"

        !insertmacro NSISUNZ_EXTRACT "MaxPayne2BonusChapters.zip" ".\" "AUTO_DELETE"

        # Extract InstallShield Setup Launcher
        ExecWait '"MaxPayne2BonusChapters.exe" /s /extract_all:."' $0
        Delete "MaxPayne2BonusChapters.exe"

        # Unpack CAB
        !insertmacro I6COMP_GET
        !insertmacro I6COMP_UNPACK "$INSTDIR\@mulderload\bonus\Disk1\data1.cab" "$INSTDIR\@mulderload\bonus\unpacked"
        !insertmacro I6COMP_REMOVE

        # Move and clean
        SetOutPath "$INSTDIR"
        Rename "$INSTDIR\@mulderload\bonus\unpacked\Bonus Dead Man Walking Chapters.mp2m" "$INSTDIR\Bonus Dead Man Walking Chapters.ras"
        RMDir /r "$INSTDIR\@mulderload\bonus"
        AddSize 17514
    SectionEnd

    Section "Unlock all difficulties"
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne 2\Game Level" "hell" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne 2\Game Level" "nightmare" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne 2\Game Level" "timedmode" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne 2\Game Level" "normal" 1
    SectionEnd

    Section "Unlock level selector"
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne 2\Game Level" "LevelSelector" 1
    SectionEnd

    Section "Weapon Accuracy Patch (by onehundredpercentass)"
        SetOutPath "$INSTDIR\.MulderConfig\weapon_accuracy_patch"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/max-payne-2-weapon-accuracy-patch1/downloads/max-payne-2-weapon-accuracy-patch1" \
                                "Max_Payne_2_Weapon_Accuracy_Patch.rar" \
                                "07ce34106445977d1d101b925271dce5"

        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Max_Payne_2_Weapon_Accuracy_Patch.rar" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
    SectionEnd
SectionGroupEnd

Section /o "Language Pack (EN, FR, DE, IT, PL, RU, ES)"
    SetOutPath "$INSTDIR\.MulderConfig"

    !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/max-payne-2-the-fall-of-max-payne/translation/Max Payne 2 Language Pack [MLD].7z.001" \
                                "Max Payne 2 Language Pack [MLD].7z.001" \
                                "86c6ca8c026d101f501b12b0d5dbe2145a07056d" \
                                3

    !insertmacro NSIS7Z_EXTRACT "Max Payne 2 Language Pack [MLD].7z.001" ".\" ""
    !insertmacro DELETE_RANGE "Max Payne 2 Language Pack [MLD].7z.001" 3
    AddSize 2234460

    SetOutPath "$INSTDIR"
    Delete "MP2_English.ras"
    Delete "MP2_French.ras"
    Delete "MP2_German.ras"
    Delete "MP2_Polish.ras"
    Delete "MP2_Russian.ras"
    Delete "MP2_Spanish.ras"
    AddSize -346662
SectionEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Section
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "maxpayne2.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Max Payne 2 The Fall of Max Payne"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
