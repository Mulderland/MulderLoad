
!ifndef NSI_INCLUDE
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Prey (2006), which can$\r$\n\
    - configure language$\r$\n\
    - configure 16/9 and 21/9 resolutions$\r$\n\
    - install widescreen HUD fix (by hexaae)$\r$\n\
    - install 21/9 support (by fgsfds)$\r$\n\
    - apply ultra-high quality settings$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}"

    !include "..\..\includes\templates\SelectTemplate.nsh"
    !include "..\..\includes\tools\7z.nsh"
    !include "..\..\includes\tools\I6Comp.nsh"

    Name "Prey 2006 [Enhancement Pack]"
!endif

Section
    !insertmacro FORCE_RENAME "$INSTDIR\base\autoexec.cfg" "$INSTDIR\base\autoexec.cfg.bak"
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
        AddSize 47718
        SetOutPath "$INSTDIR\base"

        # https://www.moddb.com/mods/widescreen-hud-for-prey-2006/addons/pak070-ws-hud
        !insertmacro DOWNLOAD_3 "https://www.moddb.com/addons/start/247093" \
                                "https://cdn2.mulderload.eu/g/prey-2006/pak070_ws_hud.3.zip.zip" \
                                "https://www.mediafire.com/file_premium/ce62xi2qxvezzqy/pak070_ws_hud.3.zip.zip/file" \
                                "pak070_ws_hud.3.zip.zip" "d5e5fbfbde34d1b0402a9bc093c402b0"

        !insertmacro NSISUNZ_EXTRACT "pak070_ws_hud.3.zip.zip" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "Ultrawide (21/9) Aspect Ratio Patch"
        AddSize 7117
        SetOutPath "$INSTDIR\base"

        !insertmacro DOWNLOAD_3 "https://community.pcgamingwiki.com/files/file/2758-prey-2006-ultrawide-fix/#13642" \
                                "https://cdn2.mulderload.eu/g/prey-2006/prey_ultrawide.zip" \
                                "https://www.mediafire.com/file_premium/ewpqtk11ldnl3nj/prey_ultrawide.zip/file" \
                                "prey_ultrawide.zip" "3b3c0b5d654bcdef7bbb4f9f6165edd30f843292"

        !insertmacro NSISUNZ_EXTRACT_ONE "prey_ultrawide.zip" ".\" "game00.pk4" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "prey_ultrawide.zip" ".\" "game03.pk4" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "prey_ultrawide.zip" ".\" "gamex86.dll" "AUTO_DELETE"
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

!ifndef NSI_INCLUDE
    Function .onInit
        StrCpy $SELECT_FILENAME "prey.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Prey 2006"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
        StrCpy $1 ${lang_en} ; Radio Button
        StrCpy $2 ${res_1920_1080} ; Radio Button
    FunctionEnd
!endif
