!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Dino Crisis (Steam), with:$\r$\n\
    - Downgrade to GOG version (including GOG's DX Wrapper)$\r$\n\
    - Dino Crisis Classic REbirth$\r$\n\
    - High Quality Voices && Music (Dreamcast)$\r$\n\
    - High Quality Textures (Dreamcast upscaled)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to the Classic REbirth team!"

    !include "..\..\includes\templates\SelectTemplate.nsh"
    !include "..\..\includes\tools\7z.nsh"

    Name "Dino Crisis [Steam Enhancement Pack]"

    Section "Downgrade Steam to GOG v1.0 hotfix 3"
        AddSize 5472
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis/steam_to_gog_1.0hotfix3_full.7z" \
                                "https://www.mediafire.com/file_premium/bn8oxnx1d142dno/steam_to_gog_1.0hotfix3_full.7z/file" \
                                "steam_to_gog_1.0hotfix3_full.7z" "735f2d4f0455c2be3011025520e9e3a91a0b968c"
        !insertmacro NSIS7Z_EXTRACT "steam_to_gog_1.0hotfix3_full.7z" ".\" "AUTO_DELETE"
    SectionEnd
!endif

Var /GLOBAL REBIRTHDIR

SectionGroup /e "Dino Crisis Classic REbirth"
    Section
        !ifdef GOG_ENHANCEMENT_PACK_NSI
            StrCpy $REBIRTHDIR "$INSTDIR"
        !else ; If Steam
            AddSize 385576
            ${IfNot} ${FileExists} "$INSTDIR\rebirth\*.*"
                CopyFiles /SILENT "$INSTDIR\japanese\Data" "$INSTDIR\rebirth\Data"
                CopyFiles /SILENT "$INSTDIR\japanese\Sound" "$INSTDIR\rebirth\Sound"
                CopyFiles /SILENT /FILESONLY "$INSTDIR\japanese\*.*" "$INSTDIR\rebirth"
                Delete "$INSTDIR\rebirth\dxcfg.*"
            ${EndIf}
            StrCpy $REBIRTHDIR "$INSTDIR\rebirth"
        !endif
    SectionEnd

    # Dino Crisis Classic REbirth
    Section
        SetOutPath "$REBIRTHDIR"

        # Copy "Best" INI (with WideMode enabled)
        File resources\config.ini

        # Windows XP Patch
        AddSize 2608
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis/DINO%20xp.7z" \
                                "https://www.mediafire.com/file_premium/6c73u2fjpgpcx1m/DINO_xp.7z/file" \
                                "DINO xp.7z" "08d0a6c5e8a91fa56cb4a13bd46136cfa45748e3"
        !insertmacro NSIS7Z_EXTRACT "DINO xp.7z" ".\" "AUTO_DELETE"

        # High Quality Videos
        AddSize 101581
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis/Movie.rar" \
                                "https://www.mediafire.com/file_premium/wnfkb1a5isy4w6b/Movie.rar/file" \
                                "Movie.rar" "c5575da40f1f32b92668c6ba8fc77c85a57c6110"
        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Movie.rar" "Movie\" "AUTO_DELETE"

        # Classic REbirth DLL
        AddSize 3474
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis/dc1cr-1.0.0-2020-04-24.7z" \
                                "https://www.mediafire.com/file_premium/zdq1avo7p1oahk0/dc1cr-1.0.0-2020-04-24.7z/file" \
                                "dc1cr-1.0.0-2020-04-24.7z" "3a0a62df64fd96807f9ac90cc2485319fbe145d9"
        !insertmacro NSIS7Z_EXTRACT "dc1cr-1.0.0-2020-04-24.7z" ".\" "AUTO_DELETE"

        # Create Save folder if not exist
        SetOutPath "$REBIRTHDIR\Save"
    SectionEnd

    Section "High Quality Audio (Dreamcast)"
        AddSize 232448
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis/DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" \
                                "https://www.mediafire.com/file_premium/phtu0nbwgxwr7a2/DINO_CRISIS_HQ_%2528Voice%2529_and_%2528Background_Music%2529_updated.rar/file" \
                                "DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" "c772a8f17e898769479a1aad709527750204e20d"
        !insertmacro 7Z_EXTRACT "DINO_CRISIS_HQ_(Voice)_and_(Background_Music)_updated.rar" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "Readme.txt" "Readme_HQ_Voice_and_BGM.txt"
    SectionEnd

    Section "High Quality Textures (Dreamcast upscaled)"
        AddSize 2527068
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/dino-crisis/HD_Mod_1.0%20[Repack-MLD].7z.001" "HD_Mod_1.0 [Repack-MLD].7z.001" "149abbde37507d63bef0ad0a673946f756fe599a" 5
        !insertmacro NSIS7Z_EXTRACT "HD_Mod_1.0 [Repack-MLD].7z.001" ".\" ""
        !insertmacro DELETE_RANGE "HD_Mod_1.0 [Repack-MLD].7z.001" 5
        !insertmacro FORCE_RENAME "readme.txt" "Readme_HQ_Textures.txt"
    SectionEnd

    Section
        !insertmacro 7Z_REMOVE
    SectionEnd
SectionGroupEnd

!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    SectionGroup /e "MulderConfig (latest)"
        Section
            SectionIn RO
            AddSize 1024
            SetOutPath "$INSTDIR"
            !insertmacro DOWNLOAD_1 "https://github.com/Mulderland/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
            File resources\MulderConfig.json
            File resources\MulderConfig.save.json
            #ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
            Rename "$INSTDIR\4249130_Launcher.exe" "4249130_Launcher_o.exe"
            CopyFiles "$INSTDIR\MulderConfig.exe" "$INSTDIR\4249130_Launcher.exe"
        SectionEnd

        Section /o ".NET Desktop Runtime 8.0.23 (x64)"
            SetOutPath "$INSTDIR"
            AddSize 100000

            !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.23/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                    "https://cdn2.mulderload.eu/g/_redist/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                    "windowsdesktop-runtime-win-x64.exe" "0ecfc9a9dab72cb968576991ec34921719039d70"
            ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
            Delete "windowsdesktop-runtime-win-x64.exe"
        SectionEnd
    SectionGroupEnd

    SectionGroup /e "Remove Non-REbirth files (preserve saves)"
        Section /o "Remove english files"
            RMDir /r "$INSTDIR\english\Data"
            RMDir /r "$INSTDIR\english\Movie"
            RMDir /r "$INSTDIR\english\Sound"
            Delete "$INSTDIR\english\*.*"
        SectionEnd

        Section /o "Remove french files"
            RMDir /r "$INSTDIR\french\Data"
            RMDir /r "$INSTDIR\french\Movie"
            RMDir /r "$INSTDIR\french\Sound"
            Delete "$INSTDIR\french\*.*"
        SectionEnd

        Section /o "Remove german files"
            RMDir /r "$INSTDIR\german\Data"
            RMDir /r "$INSTDIR\german\Movie"
            RMDir /r "$INSTDIR\german\Sound"
            Delete "$INSTDIR\german\*.*"
        SectionEnd

        Section /o "Remove italian files"
            RMDir /r "$INSTDIR\italian\Data"
            RMDir /r "$INSTDIR\italian\Movie"
            RMDir /r "$INSTDIR\italian\Sound"
            Delete "$INSTDIR\italian\*.*"
        SectionEnd

        Section /o "Remove japanese files"
            RMDir /r "$INSTDIR\japanese\Data"
            RMDir /r "$INSTDIR\japanese\Movie"
            RMDir /r "$INSTDIR\japanese\Sound"
            Delete "$INSTDIR\japanese\*.*"
        SectionEnd

        Section /o "Remove spanish files"
            RMDir /r "$INSTDIR\spanish\Data"
            RMDir /r "$INSTDIR\spanish\Movie"
            RMDir /r "$INSTDIR\spanish\Sound"
            Delete "$INSTDIR\spanish\*.*"
        SectionEnd
    SectionGroupEnd

    Function .onInit
        StrCpy $SELECT_FILENAME "4249130_Launcher.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249130_DinoCrisis"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
    FunctionEnd
!endif
