!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Wolfram. It will install the v1.1 version of the game (without running the Clickteam installer to avoid requiring administrator privileges).$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the developers at Chain Studios!"

!include "..\..\includes\templates\ClassicTemplate.nsh"
!include "..\..\includes\tools\CicDec.nsh"

Name "Wolfram"
InstallDir "C:\MulderLoad\Wolfram"

SectionGroup /e "Wolfram v1.1 (Full installation)" lang
    Section "US Version" lang_us
        AddSize 197632
        SetOutPath "$INSTDIR\@mulderload"

        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/43717" \
                                "https://cdn2.mulderload.eu/tmp/wolfram/wolfram_win32_us.exe" \
                                "wolfram_win32.exe" "7d2d93f4a5968bb70e68c94dcb41be60"

        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/43925" \
                                "https://cdn2.mulderload.eu/tmp/wolfram/wolfram_win32_patch_1_1_en.exe" \
                                "wolfram_win32_patch_1_1.exe" "68a52ce17b7732c4aa7298714c90c13c"
    SectionEnd

    Section /o "Russian Version" lang_ru
        AddSize 197632
        SetOutPath "$INSTDIR\@mulderload"

        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/43718" \
                                "https://cdn2.mulderload.eu/tmp/wolfram/wolfram_win32_ru.exe" \
                                "wolfram_win32.exe" "1896d30fc2b770125beb1c268be1e414"

        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/43924" \
                                "https://cdn2.mulderload.eu/tmp/wolfram/wolfram_win32_patch_1_1_ru.exe" \
                                "wolfram_win32_patch_1_1.exe" "ab49b227a59ba135514c6376f570c64d"
    SectionEnd

    Section
        SetOutPath "$INSTDIR"

        !insertmacro CICDEC_GET
        !insertmacro CICDEC_UNPACK "$INSTDIR\@mulderload\wolfram_win32.exe" "$INSTDIR" "AUTO_DELETE"
        !insertmacro CICDEC_UNPACK "$INSTDIR\@mulderload\wolfram_win32_patch_1_1.exe" "$INSTDIR\@mulderload\patch_files" "AUTO_DELETE"
        !insertmacro CICDEC_REMOVE

        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\patch_files" "$INSTDIR"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $1 ${lang_us} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro UnSelectSection ${lang}
        !insertmacro SelectSection $1
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_us}
            !insertmacro RadioButton ${lang_ru}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
