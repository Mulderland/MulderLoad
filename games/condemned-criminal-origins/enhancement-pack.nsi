!define MUI_WELCOMEPAGE_TEXT "\
Enhancement Pack for Condemned: Criminal Origins, to:$\r$\n\
- install the missing sound effects from Steam effects (by ThirteenAG) for all languages (not just English)$\r$\n\
- install Widescreen && FPS Fix (by ThirteenAG)$\r$\n\
- change the FOV$\r$\n\
- install AI Upscaled Textures (Neural Origins mod)$\r$\n\
- skip intro videos$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to ThirteenAG and the Neural Origins modders!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Condemned: Criminal Origins [Enhancement Pack]"

Section "[Steam] Missing sound effects (ThirteenAG)"
    AddSize 632832
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/condemned/Condemned.MissingSteamFilesFix.zip" \
                            "https://cdn2.mulderload.eu/g/condemned-criminal-origins/Condemned.MissingSteamFilesFix.zip" \
                            "Condemned.MissingSteamFilesFix.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "Condemned.MissingSteamFilesFix.zip" "Game\" "Condemned.MissingSteamFilesFix\Game\CondemnedX.Arch00" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "Condemned.MissingSteamFilesFix.zip" ".\" "Condemned.MissingSteamFilesFix\default.archcfg" "AUTO_DELETE"
    Rename "Game\CondemnedX.Arch00" "Game\CondemnedB.Arch00"
SectionEnd

Section "Widescreen & Framerate Fix (ThirteenAG)"
    AddSize 10547
    SectionIn RO
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/condemned/Condemned.WidescreenFix.zip" \
                            "https://cdn2.mulderload.eu/g/condemned-criminal-origins/Condemned.WidescreenFix.zip" \
                            "Condemned.WidescreenFix.zip" ""
    !insertmacro NSISUNZ_EXTRACT "Condemned.WidescreenFix.zip" ".\" "AUTO_DELETE"
SectionEnd

SectionGroup /e "FOV increase" fov
    Section /o "Small increase (Vert- 70)" fov1
        FileOpen $0 "$INSTDIR\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 '"FovY" "70.0"$\r$\n'
        FileClose $0
    SectionEnd

    Section "Medium increase (Vert- 75)" fov2
        FileOpen $0 "$INSTDIR\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 '"FovY" "75.0"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "Big increase (Vert- 80)" fov3
        FileOpen $0 "$INSTDIR\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 '"FovY" "80.0"$\r$\n'
        FileClose $0
    SectionEnd
SectionGroupEnd

SectionGroup /e "AI Upscaled Textures (Neural Origins 0.9)"
    Section # 4GB Patch
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://ntcore.com/files/4gb_patch.zip" \
                                "https://cdn2.mulderload.eu/g/condemned-criminal-origins/4gb_patch.zip" \
                                "4gb_patch.zip" "c8b0d61937cb54fc8215124c0f737a1d29479c97"
        !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"

        ExecWait '4gb_patch.exe Condemned.exe' $0
        Delete "4gb_patch.exe"
    SectionEnd

    Section # Neural Origins
        AddSize 9785344
        SetOutPath "$INSTDIR\Game\CondemnedC.Arch00"

        # https://www.moddb.com/mods/neural-origins/downloads/09
        !insertmacro DOWNLOAD_3 "https://www.moddb.com/downloads/start/185281" \
                                "https://www.mediafire.com/file_premium/psh39fggqk9li8y/Data.zip/file" \
                                "https://cdn2.mulderload.eu/g/condemned-criminal-origins/Data.zip" \
                                "Data.zip" "7c80e43f9f252bf55fba7b9b37df5a5e"

        # Extract with 7z (NSIS built-in unzip can't handle files > 4Gb)
        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Data.zip" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
        !insertmacro FOLDER_MERGE "$INSTDIR\Game\CondemnedC.Arch00\Data" "$INSTDIR\Game\CondemnedC.Arch00"
    SectionEnd

    Section /o "Green HUD for OLED screens"
        AddSize 768
        SetOutPath "$INSTDIR\Game\CondemnedC.Arch00"

        # https://www.moddb.com/mods/neural-origins/addons/green-hud-for-oled
        !insertmacro DOWNLOAD_3 "https://www.moddb.com/addons/start/185307" \
                                "https://cdn2.mulderload.eu/g/condemned-criminal-origins/global.1.zip" \
                                "https://www.mediafire.com/file_premium/b8cj2zfjy0vdpab/global.1.zip/file" \
                                "global.1.zip" "4fffb4b00087115d21d7dc1ff8255c3b"
        !insertmacro NSISUNZ_EXTRACT "global.1.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section /o "Skip intro videos"
    FileOpen $0 "$INSTDIR\autoexec.cfg" a
    FileSeek $0 0 END
    FileWrite $0 '"DisableMovies" "1"$\r$\n'
    FileClose $0
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Condemned.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Condemned Criminal Origins"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${fov2} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${fov}
        !insertmacro UnSelectSection ${fov}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${fov1}
            !insertmacro RadioButton ${fov2}
            !insertmacro RadioButton ${fov3}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
