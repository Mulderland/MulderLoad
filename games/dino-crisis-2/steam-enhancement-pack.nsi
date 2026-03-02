!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Dino Crisis 2 (Steam), with:$\r$\n\
    - Corrupted / Missing files fix$\r$\n\
    - Dino Crisis 2 Classic REbirth$\r$\n\
    - High Quality Videos$\r$\n\
    - High Quality SFX$\r$\n\
    - High Quality Textures (Rex-HD Project Preview)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Special thanks to the Classic REbirth && the Rex-HD projects!"

    !define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
    !define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
    !include "..\..\includes\templates\SelectTemplate.nsh"

    Name "Dino Crisis 2 [Steam Enhancement Pack]"

    Section "Downgrade Steam to GOG v1.0 hotfix 3"
        AddSize 1824
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/steam_to_gog_1.0hotfix3_full.7z" \
                                "https://www.mediafire.com/file_premium/1neorsjywl8zp6s/steam_to_gog_1.0hotfix3_full.7z/file" \
                                "steam_to_gog_1.0hotfix3_full.7z" "577108ba1bd00eaf1952e417177a6875ea802f8b"
        !insertmacro NSIS7Z_EXTRACT "steam_to_gog_1.0hotfix3_full.7z" ".\" "AUTO_DELETE"
    SectionEnd
!endif

Section "Fix GOG/Steam corrupted files with Retail files"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/Data%20Retail%20[MLD].7z" \
                            "https://www.mediafire.com/file_premium/kp9hfi5ezdtrvrm/Data_Retail_%255BMLD%255D.7z/file" \
                            "Data Retail [MLD].7z" "a19474b1846eed0fe9564bb6516740ba6b26d268"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        !insertmacro NSIS7Z_EXTRACT "Data Retail [MLD].7z" ".\" "AUTO_DELETE"
    !else ; If Steam
        !insertmacro NSIS7Z_EXTRACT "Data Retail [MLD].7z" "english\" ""
        !insertmacro NSIS7Z_EXTRACT "Data Retail [MLD].7z" "japanese\" "AUTO_DELETE"
    !endif
SectionEnd

Var /GLOBAL REBIRTHDIR

SectionGroup /e "Dino Crisis 2 Classic REbirth"
    Section "" rebirth1
        !ifdef GOG_ENHANCEMENT_PACK_NSI
            StrCpy $REBIRTHDIR "$INSTDIR"
        !else ; If Steam
            AddSize 603136
            ${IfNot} ${FileExists} "$INSTDIR\rebirth\*.*"
                CopyFiles /SILENT "$INSTDIR\japanese\Data" "$INSTDIR\rebirth\Data"
                CopyFiles /SILENT "$INSTDIR\japanese\Movie" "$INSTDIR\rebirth\Movie"
                CopyFiles /SILENT "$INSTDIR\japanese\Speech" "$INSTDIR\rebirth\Speech"
                CopyFiles /SILENT /FILESONLY "$INSTDIR\japanese\*.*" "$INSTDIR\rebirth"
                Delete "$INSTDIR\rebirth\dxcfg.*"
            ${EndIf}
            StrCpy $REBIRTHDIR "$INSTDIR\rebirth"
        !endif
    SectionEnd

    # Dino Crisis Classic REbirth
    Section "" rebirth2
        SetOutPath "$REBIRTHDIR"

        # Copy INI with SMAA
        File resources\config.ini

        # Windows XP Patch
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/Dino2-xp.7z" \
                                "https://www.mediafire.com/file_premium/fjni41t9im4kqli/Dino2-xp.7z/file" \
                                "Dino2-xp.7z" "47107fbdaaec9ad62114e071c478545beac97b7f"
        !insertmacro NSIS7Z_EXTRACT "Dino2-xp.7z" ".\" "AUTO_DELETE"

        # Classic REbirth DLL
        AddSize 3545
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr-2024-05-05.7z" \
                                "https://www.mediafire.com/file_premium/69dozi4wa1dfwlm/dc2cr-2024-05-05.7z/file" \
                                "dc2cr-2024-05-05.7z" "2d84b2e9b3ebac15ede3fd4beee8bb5a5eaf90e0"
        !insertmacro NSIS7Z_EXTRACT "dc2cr-2024-05-05.7z" ".\" "AUTO_DELETE"

        #
        Delete "dinput.dll"
    SectionEnd

    Section "High Quality Movies" rebirth3
        AddSize 293888
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr_hq_movie_2024-04-29.7z" \
                                "https://www.mediafire.com/file_premium/5gbygmau33k9bfe/dc2cr_hq_movie_2024-04-29.7z/file" \
                                "dc2cr_hq_movie_2024-04-29.7z" "2a8720c19ced0d6f40f598475bfc188aef038edc"
        !insertmacro NSIS7Z_EXTRACT "dc2cr_hq_movie_2024-04-29.7z" ".\" "AUTO_DELETE"

        !ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
            Delete "$REBIRTHDIR\Movie\EISEI15.DAT"
            Delete "$REBIRTHDIR\Movie\END30.DAT"
            Delete "$REBIRTHDIR\Movie\OPEN_30.DAT"
            Delete "$REBIRTHDIR\Movie\ST*.DAT"
            Delete "$REBIRTHDIR\Movie\TITLE15.DAT"
        !endif
    SectionEnd

    Section "High Quality SFX" rebirth4
        AddSize 13619
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/dc2cr_hq_sfx_2024-04-29.7z" \
                                "https://www.mediafire.com/file_premium/dla43867fkmlq31/dc2cr_hq_sfx_2024-04-29.7z/file" \
                                "dc2cr_hq_sfx_2024-04-29.7z" "87693f542928bffb4614e647f9856e7ef11f8085"
        !insertmacro NSIS7Z_EXTRACT "dc2cr_hq_sfx_2024-04-29.7z" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section "High Quality Textures (Rex-HD Project Preview)" rexhd
    AddSize 437248
    SetOutPath "$INSTDIR"
    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/dino-crisis-2/DC2_RexHD_Preview1.zip" \
                            "https://www.mediafire.com/file_premium/1pwow7ayyor8h9c/DC2_RexHD_Preview1.zip/file" \
                            "DC2_RexHD_Preview1.zip" "aee5544e2ef6d10dc7d1692158771dd21bc85294"

    !ifdef GOG_ENHANCEMENT_PACK_NSI
        !insertmacro NSISUNZ_EXTRACT "DC2_RexHD_Preview1.zip" ".\" "AUTO_DELETE"
    !else ; If Steam
        !insertmacro NSISUNZ_EXTRACT "DC2_RexHD_Preview1.zip" "english\" "AUTO_DELETE"
    !endif
SectionEnd

!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    SectionGroup /e "MulderConfig (latest)"
        Section
            SectionIn RO
            AddSize 1024
            SetOutPath "$INSTDIR"
            !insertmacro DOWNLOAD_1 "https://github.com/Mulderland/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
            File resources\steam\MulderConfig.json
            File resources\steam\MulderConfig.save.json
            #ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
            Rename "$INSTDIR\4249140_Launcher.exe" "4249140_Launcher_o.exe"
            CopyFiles "$INSTDIR\MulderConfig.exe" "$INSTDIR\4249140_Launcher.exe"
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
        Section /o "Remove english files" remove_original_english
            ; AddSize -634880
            RMDir /r "$INSTDIR\english\Data"
            RMDir /r "$INSTDIR\english\Movie"
            RMDir /r "$INSTDIR\english\Speech"
            Delete "$INSTDIR\english\*.*"
        SectionEnd

        Section /o "Remove japanese files"
            ; AddSize -604160
            RMDir /r "$INSTDIR\japanese\Data"
            RMDir /r "$INSTDIR\japanese\Movie"
            RMDir /r "$INSTDIR\japanese\Sound"
            Delete "$INSTDIR\japanese\*.*"
        SectionEnd
    SectionGroupEnd

    Function .onInit
        StrCpy $SELECT_FILENAME "4249140_Launcher.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\4249140_DinoCrisis2"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
    FunctionEnd

    Function .onSelChange
        ${If} ${SectionIsSelected} ${remove_original_english}
            ${If} ${SectionIsSelected} ${rexhd}
                !insertmacro UnSelectSection ${remove_original_english}
                MessageBox MB_ICONSTOP "Sorry, Rex-HD project is not yet compatible with REbirth.$\r$\n$\r$\nRex-HD project requires Non-REbirth english files to work."
            ${EndIf}
        ${EndIf}
    FunctionEnd
!endif
