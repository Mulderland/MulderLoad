!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nIt includes:$\r$\n- DSFix, to fix internal resolution, and add 60fps mod$\r$\n- Bonfire Input Fix (to fix bugs introduced by the 60fps)$\r$\n- Morten242s, an UI for DSFix$\r$\n- HD Interface (fonts, controller icons)$\r$\n- A selection of HD Textures that don't change the feeling of the game.$\r$\n$\r$\nEnjoy... and praise the sun !"
!include "..\..\templates\select_exe.nsh"
!include "Sections.nsh"

Name "Dark Souls: Prepare To Die Edition [PATCHS]"

Section "DSFix v2.4 + Bonfire Input Fix + Morten242s UI v1.5.1"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/cw0z4d43fgtvf8m/DSfix24.zip/file "DSfix.zip"
    nsisunz::Unzip "DSfix.zip" ".\"
    Delete "DSFix.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/c293zjk8x8id25m/Bonfire_Input_Fix_Bundle-1343-2017-09-07.zip/file "Bonfire_Input_Fix.zip"
    nsisunz::Unzip /noextractpath /file "d3dx9_43\d3dx9_43.dll" "Bonfire_Input_Fix.zip" ".\"
    nsisunz::Unzip /noextractpath /file "d3dx9_43\FPSFix-Plus-Readme.txt" "Bonfire_Input_Fix.zip" ".\"
    nsisunz::Unzip /noextractpath /file "d3dx9_43\FPSFix.ini" "Bonfire_Input_Fix.zip" ".\"
    Delete "Bonfire_Input_Fix.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/20g9u40b5ny82gl/Morten242s_UI_for_DSfix-45-1-5-1.zip/file "Morten242s_UI.zip"
    nsisunz::Unzip "Morten242s_UI.zip" ".\"
    Delete "Morten242s_UI.zip"
SectionEnd

Section "DSFix preset - rendering @ 1080p60" config_1080
    !insertmacro Download https://www.mediafire.com/file_premium/gmghex7jo8h0olx/DSfix_1080.ini/file "DSfix.ini"
SectionEnd

Section /o "DSFix preset - rendering @ 1440p60" config_1440
    !insertmacro Download https://www.mediafire.com/file_premium/6xfd205l2ouojk8/DSfix_1440.ini/file "DSfix.ini"
SectionEnd

Section /o "DSFix preset - rendering @ 2160p60" config_2160
    !insertmacro Download https://www.mediafire.com/file_premium/b2rg13k5i3z42rv/DSfix_2160.ini/file "DSfix.ini"
SectionEnd

Section "HD Interface (Fonts + Controller Icons)"
    SetOutPath $INSTDIR\dsfix\tex_override

    !insertmacro Download https://www.mediafire.com/file_premium/qlfpx87j4s2ict5/Dark_Souls_-_High-Res_UI_and_Subtitles-21-1-211.7z/file "High-Res_UI_and_Subtitles.7z"
    Nsis7z::ExtractWithDetails "High-Res_UI_and_Subtitles.7z" "Installing package %s..."
    Delete "High-Res_UI_and_Subtitles.7z"

    !insertmacro Download https://www.mediafire.com/file_premium/7rd2k0h26rnifuv/Xbox_360_HD_Interface_Icons-171-1_-_DDS.7z/file "Xbox_360_HD_Interface_Icons.7z"
    Nsis7z::ExtractWithDetails "Xbox_360_HD_Interface_Icons.7z" "Installing package %s..."
    Delete "Xbox_360_HD_Interface_Icons.7z"
SectionEnd

Section "HD Textures (LCD v1.5 + Lava Fix + Random HD Textures + HD Player Messages)"
    SetOutPath $INSTDIR\dsfix\tex_override

    !insertmacro Download https://www.mediafire.com/file_premium/o49rggv59kzzawf/LCD_Textures_1_5-268-1-5.zip/file "LCD_Textures.zip"
    nsisunz::Unzip "LCD_Textures.zip" ".\"
    Delete "LCD_Textures.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/wmvexfxai9un328/Lava_Fix_High_Res-1025-1-0.zip/file "Lava_Fix_High_Res.zip"
    nsisunz::Unzip /noextractpath "Lava_Fix_High_Res.zip" ".\"
    Delete "Lava_Fix_High_Res.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/kun4mgwzfhmux7k/HD_Textures-1670-1-01-1587497499.zip/file "Random_HD_Textures.zip"
    nsisunz::Unzip /noextractpath "Random_HD_Textures.zip" ".\"
    Delete "Random_HD_Textures.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/al0g5ps65dh8x0y/HD_Player_Messages_DDS_Version-389-1-1.7z/file "HD_Player_Messages-1.7z"
    Nsis7z::ExtractWithDetails "HD_Player_Messages-1.7z" "Installing package %s..."
    Delete "HD_Player_Messages-1.7z"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DARKSOULS.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Dark Souls Prepare to Die Edition\DATA"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${config_1080} ; Radio Button - Option 1080 is selected by default
FunctionEnd

Function .onSelChange
    !insertmacro StartRadioButtons $1
        !insertmacro RadioButton ${config_1080}
        !insertmacro RadioButton ${config_1440}
        !insertmacro RadioButton ${config_2160}
    !insertmacro EndRadioButtons
FunctionEnd
