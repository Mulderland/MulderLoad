!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer can$\r$\n- install Prey, downloaded from Archive.org$\r$\n- install official update v1.4$\r$\n- allow to switch language$\r$\n- allow high resolution and 21/9 support$\r$\n- download HUD Widescreen mod (by hexaae)$\r$\n- download ultrawide patch (by fgsfds)$\r$\n- force high quality graphics$\r$\n$\r$\nIf you already have Prey installed and updated to v1.4 (with Steam for example), you can use this installer as a Patcher only. Simply choose your installation follder, then unselect the first line on the components page."
!include "..\..\templates\standard.nsh"

Name "Prey (2006)"
InstallDir "C:\MulderLoad\Prey 2006"

Section "Prey (Limited Collectors Edition) + Patch v1.4"
    SetOutPath $INSTDIR\@tmp
    !insertmacro Get7z

    # Download and extract iso
    !insertmacro Download https://archive.org/download/PreyUSAEnFrDeEsIt/Prey%20(USA)%20(En%2CFr%2CDe%2CEs%2CIt).iso "Prey (USA) (En,Fr,De,Es,It).iso"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" "Prey (USA) (En,Fr,De,Es,It).iso"'
    Delete "Prey (USA) (En,Fr,De,Es,It).iso"

    # Run Game Setup
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/prey-2006/setup-mulderload.iss "setup-mulderload.iss"
    !insertmacro ReplaceInFile "___TARGETDIR___" "$INSTDIR" 1 1 "setup-mulderload.iss"
    ExecWait '"setup.exe" /s /SMS /f1".\setup-mulderload.iss"' $0

    # Write CD-Key from RELOADED
    FileOpen $0 "$INSTDIR\base\preykey" w
    FileWrite $0 'D23BDPBABCRPTABP$\r$\n'
    FileClose $0

    # Download Patch 1.4
    !insertmacro Download https://www.mediafire.com/file_premium/4mbewp42mr6pjfd/prey_14.zip/file "prey_14.zip"
    nsisunz::Unzip "prey_14.zip" ".\"
    Delete "prey_14.zip"

    # Run Patch Setup
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/prey-2006/update14-mulderload.iss "update14-mulderload.iss"
    !insertmacro ReplaceInFile "___TARGETDIR___" "$INSTDIR" 1 1 "update14-mulderload.iss"
    ExecWait '"SetupPreyPt1.4.exe" /s /SMS /f1".\update14-mulderload.iss"' $0

    # Delete @tmp
    SetOutPath $INSTDIR
    RMDir /r "$INSTDIR\@tmp"

    # Remove shortcuts
    RMDir /r "$SMPROGRAMS\Prey"
    Delete "$USERDESKTOP\Prey.lnk"
SectionEnd

Section
    IfFileExists "$INSTDIR\base\autoexec.cfg" 0
        Delete "$INSTDIR\base\autoexec.bak"
        Rename "$INSTDIR\base\autoexec.cfg" "$INSTDIR\base\autoexec.bak"
SectionEnd

SectionGroup "Configure language" lang
    Section "English" lang_en
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta sys_lang "english"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "French" lang_fr
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta sys_lang "french"$\r$\n'
        FileWrite $0 'seta g_subtitles "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "German" lang_ge
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta sys_lang "german"$\r$\n'
        FileWrite $0 'seta g_subtitles "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "Italian" lang_it
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta sys_lang "italian"$\r$\n'
        FileWrite $0 'seta g_subtitles "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "Spanish" lang_sp
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta sys_lang "spanish"$\r$\n'
        FileWrite $0 'seta g_subtitles "1"$\r$\n'
        FileClose $0
    SectionEnd
SectionGroupEnd

SectionGroup "Configure resolution" res
    Section "1920x1080 (16/9)" res_1920_1080
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_customWidth "1920"$\r$\n'
        FileWrite $0 'seta r_customHeight "1080"$\r$\n'
        FileWrite $0 'seta r_mode "-1"$\r$\n'
        FileWrite $0 'seta r_aspectRatio "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "2560x1080 (21/9)" res_2560_1080
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_customWidth "2560"$\r$\n'
        FileWrite $0 'seta r_customHeight "1080"$\r$\n'
        FileWrite $0 'seta r_mode "-1"$\r$\n'
        FileWrite $0 'seta r_aspectRatio "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "2560x1440 (16/9)" res_2560_1440
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_customWidth "2560"$\r$\n'
        FileWrite $0 'seta r_customHeight "1440"$\r$\n'
        FileWrite $0 'seta r_mode "-1"$\r$\n'
        FileWrite $0 'seta r_aspectRatio "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "3440x1440 (21/9)" res_3440_1440
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_customWidth "3440"$\r$\n'
        FileWrite $0 'seta r_customHeight "1440"$\r$\n'
        FileWrite $0 'seta r_mode "-1"$\r$\n'
        FileWrite $0 'seta r_aspectRatio "1"$\r$\n'
        FileClose $0
    SectionEnd

    Section /o "3840x2160 (16/9)" res_3840_2160
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_customWidth "3840"$\r$\n'
        FileWrite $0 'seta r_customHeight "2160"$\r$\n'
        FileWrite $0 'seta r_mode "-1"$\r$\n'
        FileWrite $0 'seta r_aspectRatio "1"$\r$\n'
        FileClose $0
    SectionEnd
SectionGroupEnd

SectionGroup "Widescreen Fixes"
    Section "Widescreen HUD (for 16/9 and wider)"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/ce62xi2qxvezzqy/pak070_ws_hud.3.zip.zip/file "pak070_ws_hud.3.zip"
        nsisunz::Unzip "prey_14.zip" "base\"
        Delete "pak070_ws_hud.3.zip"
    SectionEnd

    Section /o "Ultrawide (21/9) Aspect Ratio Patch"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/ewpqtk11ldnl3nj/prey_ultrawide.zip/file "prey_ultrawide.zip"
        nsisunz::Unzip /file "game00.pk4" "prey_ultrawide.zip" "base\"
        nsisunz::Unzip /file "game03.pk4" "prey_ultrawide.zip" "base\"
        nsisunz::Unzip /file "gamex86.dll" "prey_ultrawide.zip" "base\"
        Delete "prey_ultrawide.zip"
    SectionEnd
SectionGroupEnd

SectionGroup "Graphical improvements"
    Section "Use 16x MSAA (Anti-Aliasing)"
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta r_multiSamples "16"$\r$\n'
        FileClose $0
    SectionEnd

    Section "Force high image quality"
        FileOpen $0 "$INSTDIR\base\autoexec.cfg" a
        FileSeek $0 0 END
        FileWrite $0 'seta com_machineSpec "3"$\r$\n'
        FileWrite $0 'seta com_videoRam "2048"$\r$\n'
        FileWrite $0 'seta r_shaderLevel "3"$\r$\n'
        FileWrite $0 'seta r_shadows "1"$\r$\n'
        FileWrite $0 'seta r_skipSky "0"$\r$\n'
        FileWrite $0 'seta r_skipBump "0"$\r$\n'
        FileWrite $0 'seta r_skipSpecular "0"$\r$\n'
        FileWrite $0 'seta r_skipNewAmbient "0"$\r$\n'
        FileWrite $0 'seta image_anisotropy "16"$\r$\n'
        FileWrite $0 'seta image_ignoreHighQuality "0"$\r$\n'
        FileWrite $0 'seta image_downSize "0"$\r$\n'
        FileWrite $0 'seta image_downSizeBump "0"$\r$\n'
        FileWrite $0 'seta image_downSizeSpecular "0"$\r$\n'
        FileWrite $0 'seta image_useCache "0"$\r$\n'
        FileWrite $0 'seta image_useCompression "0"$\r$\n'
        FileWrite $0 'seta image_useNormalCompression "0"$\r$\n'
        FileWrite $0 'seta image_usePrecompressedTextures "0"$\r$\n'
        FileWrite $0 'seta image_lodbias "-1"$\r$\n'
        FileWrite $0 'seta image_filter "GL_LINEAR_MIPMAP_LINEAR"$\r$\n'
        FileWrite $0 'seta g_brassTime "2"$\r$\n'
        FileClose $0
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $1 ${lang_en} ; Radio Button
    StrCpy $2 ${res_1920_1080} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro UnSelectSection ${lang}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_en}
            !insertmacro RadioButton ${lang_fr}
            !insertmacro RadioButton ${lang_ge}
            !insertmacro RadioButton ${lang_it}
            !insertmacro RadioButton ${lang_sp}
        !insertmacro EndRadioButtons
    ${EndIf}

    ${If} ${SectionIsSelected} ${res}
        !insertmacro UnSelectSection ${res}
    ${Else}
        !insertmacro StartRadioButtons $2
            !insertmacro RadioButton ${res_1920_1080}
            !insertmacro RadioButton ${res_2560_1080}
            !insertmacro RadioButton ${res_2560_1440}
            !insertmacro RadioButton ${res_3440_1440}
            !insertmacro RadioButton ${res_3840_2160}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
