Var /GLOBAL Game_Language
Var /GLOBAL DLC_Automatron
Var /GLOBAL DLC_Workshop

Function OnSelectedFile
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Fallout4.exe" "97a1e7d780a8fd4a86c27cd1e1d42d05bf7eb4b5" $0
     ${If} "$0" == "1"
        MessageBox MB_OK "Correct game version detected!$\r$\nGame version: v1.11.240 (August 2026)$\r$\n$\r$\nYou may proceed."
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported Fallout 4 version detected.$\r$\n$\r$\nThis downgrader only supports the Steam version v1.11.240 (August 2026).$\r$\n$\r$\nAborting."
        Abort
    ${EndIf}

    # DLC Detection
    StrCpy $DLC_Automatron "no"
    StrCpy $DLC_Workshop "no"

    IfFileExists "$INSTDIR\Data\DLCRobot.cdx" 0 +2
        StrCpy $DLC_Automatron "yes"

    IfFileExists "$INSTDIR\Data\DLCworkshop01.cdx" 0 +2
        StrCpy $DLC_Workshop "yes"

    # Language Detection
    StrCpy $Game_Language "English"

    IfFileExists "$INSTDIR\Data\Fallout4 - Voices_fr.ba2" 0 +2
        StrCpy $Game_Language "French"

    IfFileExists "$INSTDIR\Data\Fallout4 - Voices_de.ba2" 0 +2
        StrCpy $Game_Language "German"

    IfFileExists "$INSTDIR\Data\Fallout4 - Voices_it.ba2" 0 +2
        StrCpy $Game_Language "Italian"

    IfFileExists "$INSTDIR\Data\Fallout4 - Voices_es.ba2" 0 +2
        StrCpy $Game_Language "Spanish"

    IfFileExists "$INSTDIR\Data\Video\Intro_pl.bk2" 0 +2
        StrCpy $Game_Language "Polish"

    IfFileExists "$INSTDIR\Data\Video\Intro_ru.bk2" 0 +2
        StrCpy $Game_Language "Russian"

    IfFileExists "$INSTDIR\Data\Video\Intro_ptbr.bk2" 0 +2
        StrCpy $Game_Language "Portuguese (Brazil)"

    IfFileExists "$INSTDIR\Data\Video\Intro_ja.bk2" 0 +2
        StrCpy $Game_Language "Japanese"

    ${If} $Game_Language == "English"
        # We don't have discriminating files between English and Chinese (Traditional), so let's ask the user
        MessageBox MB_YESNO|MB_DEFBUTTON2 "Is your game in Chinese (Traditional)?" IDNO +2
        StrCpy $Game_Language "Chinese (Traditional)"
    ${EndIf}

    # Ask user to confirm the detected informations
    MessageBox MB_YESNO|MB_ICONQUESTION "Please review the detected informations:$\r$\n$\r$\nGame language: $Game_Language$\r$\nAutomatron DLC: $DLC_Automatron$\r$\nWasteland Workshop DLC: $DLC_Workshop$\r$\n$\r$\nIs this correct?$\r$\n$\r$\n(other DLCs don't need downgrade so I don't look for them)" IDYES +2
    Quit
FunctionEnd

Function OpenKofi
    ExecShell "open" "https://www.ko-fi.com/mulderland"
FunctionEnd
