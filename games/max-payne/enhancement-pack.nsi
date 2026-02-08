!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nIt includes:$\r$\n- Corrupted levels Fix (with auto-detection)$\r$\n- Widescreen Fix$\r$\n- Modern CPUs Fix$\r$\n- Difficulty fixes$\r$\n- Sound fix (via DSOAL)$\r$\n$\r$\nA big thanks to ThirteenAG and the DSOAL project!"
!include "..\..\templates\select_exe.nsh"

Name "Max Payne [PATCHS]"

Section "Fix corrupted levels (if required)"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro DownloadIfDifferent "x_level1.ras" "d7dc20d91930b67c84dad0fb18a5c712bd324330" https://www.mediafire.com/file_premium/9v212c2kmot7bes/x_levels_fix.7z/file "x_levels_fix.7z"
    IfFileExists "x_levels_fix.7z" yes no
    yes: Nsis7z::ExtractWithDetails "x_levels_fix.7z" "Replacing file %s..."
        Delete "x_levels_fix.7z"
    no:
SectionEnd

Section "ThirteenAG's Widescreen Fix (+ use D3D9)"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/mp1/MaxPayne.WidescreenFix.zip "MaxPayne.WidescreenFix.zip"
    nsisunz::Unzip "MaxPayne.WidescreenFix.zip" ".\"
    Delete "MaxPayne.WidescreenFix.zip"

    !insertmacro Download https://www.mediafire.com/file_premium/1nh7p29tstyp2th/global.ini/file "scripts\global.ini"
SectionEnd

Section "Fix JPEG errors on modern CPUs"
    SetOutPath $INSTDIR

    !insertmacro download https://www.mediafire.com/file_premium/vpotbzh2qt9o89c/rlmfc.dll/file "rlmfc.dll"
SectionEnd

SectionGroup "Difficulty fixes"
    Section "Remove broken Adaptive Difficulty"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/m5k5vstel0pbo71/payne_difficulty.7z/file "payne_difficulty.7z"
        Nsis7z::ExtractWithDetails "payne_difficulty.7z" "Installing package %s..."
        Delete "payne_difficulty.7z"
    SectionEnd

    Section "Unlock all difficulties"
        WriteRegStr HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "" "1"
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "hell" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "nightmare" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "timedmode" 1
        WriteRegDWORD HKCU "Software\Remedy Entertainment\Max Payne\Game Level" "normal" 1
    SectionEnd
SectionGroupEnd

SectionGroup /e "Sound fix" sound
    Section "DSOAL r647 Standard (recommended)" sound_std
        !insertmacro Download https://github.com/kcat/dsoal/releases/download/r647/DSOAL.zip "$INSTDIR\DSOAL.zip"
    SectionEnd

    Section /o "DSOAL r647 HRTF (for surround headphones)" sound_hrtf
        !insertmacro Download https://github.com/kcat/dsoal/releases/download/r647/DSOAL+HRTF.zip "$INSTDIR\DSOAL.zip"
    SectionEnd

    Section # hidden section
        SetOutPath $INSTDIR
        nsisunz::Unzip /noextractpath /file "Win32\alsoft.ini" "DSOAL.zip" ".\"
        nsisunz::Unzip /noextractpath /file "Win32\dsoal-aldrv.dll" "DSOAL.zip" ".\"
        nsisunz::Unzip /noextractpath /file "Win32\dsound.dll" "DSOAL.zip" ".\"
        Delete "DSOAL.zip"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "maxpayne.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Max Payne"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${sound_std} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${sound}
        !insertmacro UnSelectSection ${sound}
        !insertmacro SelectSection $1
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${sound_std}
            !insertmacro RadioButton ${sound_hrtf}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
