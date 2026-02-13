!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Max Payne, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Crash fix because of corrupted levels (if detected)$\r$\n\
- Crash fix for modern CPUs (JPEG error)$\r$\n\
- Sound fix (with DSOAL)$\r$\n\
- Difficulty fixes$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to ThirteenAG and the DSOAL project!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Max Payne [Enhancement Pack]"

Section "Fix corrupted levels (if required)"
    SetOutPath "$INSTDIR"

    DetailPrint " // Comparing level checksum with correct one..."
    !insertmacro FILE_HASH_EQUALS "x_level1.ras" "d7dc20d91930b67c84dad0fb18a5c712bd324330" $0
    ${If} $0 != "1"
        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/max-payne/x_levels_fix.7z" \
                                "https://www.mediafire.com/file_premium/9v212c2kmot7bes/x_levels_fix.7z/file" \
                                "x_levels_fix.7z" "745253dd796e0833ebba0ff91cd40e83c5f76678"
        !insertmacro NSIS7Z_EXTRACT "x_levels_fix.7z" ".\" "AUTO_DELETE"
    ${EndIf}
SectionEnd

Section "ThirteenAG's Widescreen Fix (+ use D3D9)"
    SectionIn RO
    AddSize 2417

    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/mp1/MaxPayne.WidescreenFix.zip" \
                            "https://cdn2.mulderload.eu/g/max-payne/MaxPayne.WidescreenFix.zip" \
                            "MaxPayne.WidescreenFix.zip" ""
    !insertmacro NSISUNZ_EXTRACT "MaxPayne.WidescreenFix.zip" ".\" "AUTO_DELETE"

    File "/oname=scripts\global.ini" "resources\global.ini"
SectionEnd

Section "Fix JPEG errors on modern CPUs"
    AddSize 276
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/ravyaa9mo2536z9/rlmfc_for_ryzen.rar/file" \
                            "https://cdn2.mulderload.eu/g/max-payne/rlmfc_for_ryzen.rar" \
                            "rlmfc_for_ryzen.rar" "39db990749e5dcbbd6a81b59075ad059998563f3"
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "rlmfc_for_ryzen.rar" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE
SectionEnd

SectionGroup "Difficulty fixes"
    Section "Remove broken Adaptive Difficulty"
        AddSize 9

        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/2807-max-payne-flat-difficulty-vanilla-pc-values/#14073" \
                                "https://cdn2.mulderload.eu/g/max-payne/payne_difficulty.7z" \
                                "payne_difficulty.7z" "d450928893efad20708de6ec8ae1d0678a7499cd"
        !insertmacro NSIS7Z_EXTRACT "payne_difficulty.7z" ".\" "AUTO_DELETE"
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
    Section
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://github.com/kcat/dsoal/releases/download/archive/DSOAL_r657.zip" "DSOAL_r657.zip" "0eea221e770addb35ee337c2938010c70c0e1603"
        !insertmacro NSISUNZ_EXTRACT "DSOAL_r657.zip" ".\" "AUTO_DELETE"
    SectionEnd

    Section "DSOAL r657 Standard (recommended)" sound_std
        AddSize 1547

        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL\Win32\alsoft.ini" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL\Win32\dsoal-aldrv.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL\Win32\dsound.dll" "AUTO_DELETE"
    SectionEnd

    Section /o "DSOAL r657 HRTF (for surround headphones)" sound_hrtf
        AddSize 1526
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL+HRTF\Win32\alsoft.ini" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL+HRTF\Win32\dsoal-aldrv.dll" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "DSOAL_r657.zip" ".\" "DSOAL+HRTF\Win32\dsound.dll" "AUTO_DELETE"
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
