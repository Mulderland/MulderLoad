!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer can$\r$\n- install the missing sound effects from the Steam release (thanks ThirteenAG) for all languages (not just english)$\r$\n- install widescreen (and fps) fix (ThirteenAG again!)$\r$\n- change the FOV, since this game is Vert-$\r$\n- install AI upscaled textures (Neural Origins mod)$\r$\n- skip intro videos$\r$\n$\r$\nEnjoy this updated game !"
!include "..\..\templates\select_exe.nsh"

Name "Condemned: Criminal Origins [PATCHS]"

Section "[Steam] Missing sound effects (ThirteenAG)"
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/condemned/Condemned.MissingSteamFilesFix.zip "Condemned.MissingSteamFilesFix.zip"
    nsisunz::Unzip /noextractpath /file "Condemned.MissingSteamFilesFix\Game\CondemnedX.Arch00" "Condemned.MissingSteamFilesFix.zip" "Game\"
    nsisunz::Unzip /noextractpath /file "Condemned.MissingSteamFilesFix\default.archcfg" "Condemned.MissingSteamFilesFix.zip" ".\"
    Delete "Condemned.MissingSteamFilesFix.zip"
    Rename "Game\CondemnedX.Arch00" "Game\CondemnedB.Arch00"
SectionEnd

Section "Widescreen & Framerate Fix (ThirteenAG)"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/condemned/Condemned.WidescreenFix.zip "Condemned.WidescreenFix.zip"
    nsisunz::Unzip "Condemned.WidescreenFix.zip" ".\"
    Delete "Condemned.WidescreenFix.zip"
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
        SetOutPath $INSTDIR

        !insertmacro Download https://ntcore.com/files/4gb_patch.zip "4gb_patch.zip"
        nsisunz::Unzip "4gb_patch.zip" ".\"
        Delete "4gb_patch.zip"

        ExecWait '4gb_patch.exe Condemned.exe' $0
        Delete "4gb_patch.exe"
    SectionEnd

    Section # Neural Origins v0.9
        SetOutPath $INSTDIR\Game\CondemnedC.Arch00

        !insertmacro DownloadRange https://cdn2.mulderload.eu/g/condemned-criminal-origins/Neural_Origins_0.9/Neural_Origins_0.9.7z "Neural_Origins_0.9.7z" 9
        Nsis7z::ExtractWithDetails "Neural_Origins_0.9.7z.001" "Installing package %s..."
        !insertmacro DeleteRange "Neural_Origins_0.9.7z" 9
    SectionEnd

    Section /o "Green HUD for OLED screens"
        SetOutPath $INSTDIR\Game\CondemnedC.Arch00

        !insertmacro Download https://www.mediafire.com/file_premium/b8cj2zfjy0vdpab/global.1.zip/file "global.1.zip"
        nsisunz::Unzip "global.1.zip" ".\"
        Delete "global.1.zip"
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
