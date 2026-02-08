!define MUI_WELCOMEPAGE_TEXT "Welcome to the LITE edition of the Mulderland's Universal Downgrader, specially built for Nexusmods.$\r$\n$\r$\nIt can downgrade your Steam installation of Fallout 4 from v1.11.191 to v1.11.169. It is compatible with every editions (base game, GOTY, or in-between) and every languages.$\r$\n$\r$\nIf you wish to downgrade to an EARLIER version (v1.10.163 or v1.10.984), you can find the FULL version on my website for free.$\r$\n$\r$\nWARNING (for chineses): if your Fallout 4 is in chinese, auto language detection will sadly not work for you. So, you will have to check Chinese in the components page."

; !include "..\..\templates\select_exe.nsh"
!include MUI2.nsh
!define MUI_ICON "..\..\templates\icon.ico"
!include "..\..\templates\includes\download.nsh"
!include "..\..\templates\includes\abort_if_folder_not_empty.nsh"
!include "..\..\templates\includes\move_file_folder.nsh"
!include "..\..\templates\includes\replace_in_file.nsh"
!include "..\..\templates\includes\select_exe.nsh"
!define MUI_COMPONENTSPAGE_NODESC
; !include "..\..\templates\includes\wording.nsh"
!define MUI_WELCOMEPAGE_TITLE "Mulderland's Universal Downgrader LITE (special build for NexusMods)"
!define MUI_FINISHPAGE_TITLE "Downgrade complete !"
!define MUI_FINISHPAGE_TEXT "Thank you for using this downgrader. Happy Modding!"
!insertmacro MUI_PAGE_WELCOME
Page Custom CUSTOM_PAGE_SELECT_FILE
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
RequestExecutionLevel none

!include "..\..\templates\includes\xdelta3.nsh"
Name "Fallout 4 [Steam Downgrader LITE]"

Var /GLOBAL F4_Language
Var /GLOBAL DLC_Automatron
Var /GLOBAL DLC_Workshop

!macro AbortIfUnsupportedVersion
    NScurl::sha1 "$INSTDIR\Fallout4.exe"
    Pop $0
    ${If} $0 == "b4d944af1d97cde4786ad5bbeddc9c40f25e634c"
        DetailPrint " // Supported version detected: v1.11.191 (december 2025)"
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4 version detected (sha1: $0).$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.191 (december 2025).$\r$\n$\r$\nAborting."
        Abort
    ${EndIf}
!macroend

!macro AbortIfUserRefuses
    MessageBox MB_YESNO|MB_ICONQUESTION "Please check auto-detection before continue.$\r$\n$\r$\nDetected language : $F4_Language$\r$\nAutomatron DLC: $DLC_Automatron$\r$\nWasteland Workshop DLC: $DLC_Workshop$\r$\n$\r$\nIs this correct?$\r$\n$\r$\n(other DLCs don't need downgrade so I don't look for them)" IDYES +2
    Abort
!macroend

!macro CopyXDelta
    DetailPrint " // Copying xdelta3"
    CopyFiles "$EXEDIR\xdelta3-3.0.11-x86_64.exe" "$INSTDIR\xdelta3.exe"
!macroend

!macro AbortIfInstallDirectory
    ${If} "$INSTDIR" == "$EXEDIR"
        MessageBox MB_ICONEXCLAMATION "You cannot run the downgrader from the game installation folder itself.$\r$\n$\r$\nPlease run the downgrader from another folder, for example a temp folder in your desktop.$\r$\n$\r$\nAborting."
        Abort
    ${EndIf}
!macroend

SectionGroup "Language Detection" lang
    Section "Auto-detect (doesn't work for chinese)" lang_auto
        StrCpy $F4_Language "en"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_fr.ba2" 0 +2
            StrCpy $F4_Language "fr"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_de.ba2" 0 +2
            StrCpy $F4_Language "de"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_it.ba2" 0 +2
            StrCpy $F4_Language "it"

        IfFileExists "$INSTDIR\Data\Fallout4 - Voices_es.ba2" 0 +2
            StrCpy $F4_Language "es"

        IfFileExists "$INSTDIR\Data\Video\Intro_pl.bk2" 0 +2
            StrCpy $F4_Language "pl"

        IfFileExists "$INSTDIR\Data\Video\Intro_ru.bk2" 0 +2
            StrCpy $F4_Language "ru"

        IfFileExists "$INSTDIR\Data\Video\Intro_ptbr.bk2" 0 +2
            StrCpy $F4_Language "ptbr"

        IfFileExists "$INSTDIR\Data\Video\Intro_ja.bk2" 0 +2
            StrCpy $F4_Language "ja"
    SectionEnd

    Section /o "My game is in traditional chinese" lang_cn
        StrCpy $F4_Language "cn"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Downgrade Steam version (v1.11.191) to" version
    Section
        StrCpy $DLC_Automatron "no"
        StrCpy $DLC_Workshop "no"

        IfFileExists "$INSTDIR\Data\DLCRobot.cdx" 0 +2
            StrCpy $DLC_Automatron "yes"

        IfFileExists "$INSTDIR\Data\DLCworkshop01.cdx" 0 +2
            StrCpy $DLC_Workshop "yes"
    SectionEnd

    Section "1.11.169 (anniversary, november patch)" version_1_11_169
        AddSize 28672
        SetOutPath $INSTDIR
        !insertmacro AbortIfInstallDirectory
        !insertmacro AbortIfUnsupportedVersion
        !insertmacro AbortIfUserRefuses
        !insertmacro CopyXDelta

        DetailPrint " // Copying downgrade 377162 (Base game)"
        CopyFiles "$EXEDIR\377162\*" "$INSTDIR\"

        DetailPrint " // Copying downgrade 377163 (Base game)"
        CopyFiles "$EXEDIR\377163\*" "$INSTDIR\"

        ${If} $DLC_Automatron == "yes"
            ${If} $F4_Language == "ja"
                DetailPrint " // Copying downgrade 404091 (Automatron DLC, Japanese)"
                CopyFiles "$EXEDIR\404091\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "en"
                DetailPrint " // Copying downgrade 435871 (Automatron DLC, English)"
                CopyFiles "$EXEDIR\435871\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "fr"
                DetailPrint " // Copying downgrade 435872 (Automatron DLC, French)"
                CopyFiles "$EXEDIR\435872\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "de"
                DetailPrint " // Copying downgrade 435873 (Automatron DLC, German)"
                CopyFiles "$EXEDIR\435873\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "it"
                DetailPrint " // Copying downgrade 435874 (Automatron DLC, Italian)"
                CopyFiles "$EXEDIR\435874\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "es"
                DetailPrint " // Copying downgrade 435875 (Automatron DLC, Spanish)"
                CopyFiles "$EXEDIR\435875\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "pl"
                DetailPrint " // Copying downgrade 435876 (Automatron DLC, Polish)"
                CopyFiles "$EXEDIR\435876\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "ru"
                DetailPrint " // Copying downgrade 435877 (Automatron DLC, Russian)"
                CopyFiles "$EXEDIR\435877\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "ptbr"
                DetailPrint " // Copying downgrade 435878 (Automatron DLC, Portuguese-Brazil)"
                CopyFiles "$EXEDIR\435878\*" "$INSTDIR\"
            ${ElseIf} $F4_Language == "cn"
                DetailPrint " // Copying downgrade 435879 (Automatron DLC, Chinese-Traditional)"
                CopyFiles "$EXEDIR\435879\*" "$INSTDIR\"
            ${EndIf}
        ${EndIf}

        ${If} $DLC_Workshop == "yes"
            DetailPrint " // Copying downgrade 435880 (Wasteland Workshop DLC)"
            CopyFiles "$EXEDIR\435880\*" "$INSTDIR\"
        ${EndIf}
    SectionEnd

    Section
        SetOutPath $INSTDIR
        DetailPrint " // Applying xdelta patches"
        !insertmacro XDelta3_ApplyPatches "$INSTDIR"
        DetailPrint " // Remove xdelta3"
        Delete "xdelta3.exe"
    SectionEnd
SectionGroupEnd

Section /o "Block future Steam update"
    SetOutPath $INSTDIR\..\..
    DetailPrint " // Block future update (appmanifest_377160.acf)"
    SetFileAttributes "appmanifest_377160.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Fallout4.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Fallout 4"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${lang_auto} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_auto}
            !insertmacro RadioButton ${lang_cn}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
