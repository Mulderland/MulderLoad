Var /GLOBAL F4_Language
Var /GLOBAL DLC_Automatron
Var /GLOBAL DLC_Workshop

!macro ABORT_IF_UNSUPPORTED_VERSION
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Fallout4.exe" "b4d944af1d97cde4786ad5bbeddc9c40f25e634c" $0
    ${If} "$0" == "1"
        DetailPrint " // Supported version detected: v1.11.191 (december 2025)"
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4 version detected (sha1: $0).$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.191 (december 2025).$\r$\n$\r$\nAborting."
        Abort
    ${EndIf}
!macroend

!macro ABORT_IF_USER_REFUSES
    MessageBox MB_YESNO|MB_ICONQUESTION "Please check auto-detection before continue.$\r$\n$\r$\nDetected language : $F4_Language$\r$\nAutomatron DLC: $DLC_Automatron$\r$\nWasteland Workshop DLC: $DLC_Workshop$\r$\n$\r$\nIs this correct?$\r$\n$\r$\n(other DLCs don't need downgrade so I don't look for them)" IDYES +2
    Abort
!macroend

SectionGroup "Language Detection (automatic, except for chinese)" lang
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
