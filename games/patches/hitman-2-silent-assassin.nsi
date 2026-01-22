!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer can$\r$\n- apply GOG v1.01 patch (uncensored and optimized)$\r$\n- apply widescreen fix (by nemesis2000) well configured$\r$\n- add controller support (by mutantx20)$\r$\n- change language to French, German, Italian, Spanish"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-MulderLoad.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!include "..\..\templates\select_exe.nsh"

Name "Hitman 2: Silent Assassin [PATCHS]"

Section "Force version to GOG v1.01 (if required)"
    SetOutPath $INSTDIR

    !insertmacro DownloadIfDifferent "hitman2.exe" "8eda1825c31521adb91c838b668a4c09ed51ac6d" https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/Steam_v1.02_to_GOG_v1.01.7z "Steam_v1.02_to_GOG_v1.01.7z"
    IfFileExists "Steam_v1.02_to_GOG_v1.01.7z" yes no
    yes:
        Nsis7z::ExtractWithDetails "Steam_v1.02_to_GOG_v1.01.7z" "Installing package %s..."
        Delete "Steam_v1.02_to_GOG_v1.01.7z"
    no:
SectionEnd

Section "Widescreen fix (by nemesis2000) + dgVoodoo"
    SetOutPath $INSTDIR
    # Max Settings INI (except DXT still on, because it can causes crashes without it)
    Delete "hitman2.ini"
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/hitman-2-silent-assassin/hitman2.ini "hitman2.ini"

    # nemesis2000 Widescreen Fix
    !insertmacro DownloadRedirect https://redirect.mulderload.eu/pcgw/2787-hitman-2-silent-assassin-widescreen-fix/13816 "WidescreenFix.zip"
    nsisunz::Unzip "WidescreenFix.zip" ".\"
    Delete "WidescreenFix.zip"

    # dgVoodoo
    SetOutPath $INSTDIR\dgVoodoo
    !insertmacro Download https://github.com/dege-diosg/dgVoodoo2/releases/download/v2.86.1/dgVoodoo2_86_1.zip "dgVoodoo.zip"
    nsisunz::Unzip /noextractpath /file "dgVoodoo.conf" "dgVoodoo.zip" ".\"
    nsisunz::Unzip /noextractpath /file "dgVoodooCpl.exe" "dgVoodoo.zip" ".\"
    nsisunz::Unzip /noextractpath /file "MS\x86\D3D8.dll" "dgVoodoo.zip" ".\"
    Delete "dgVoodoo.zip"

    # config
    !insertmacro ReplaceInFile "RealDllPath       = AUTO" "RealDllPath       = dgVoodoo\d3d8.dll" 1 1 "$INSTDIR\d3d8.ini"
    !insertmacro ReplaceInFile "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro ReplaceInFile "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro ReplaceInFile "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro ReplaceInFile "Resolution                          = unforced" "Resolution                          = desktop" 2 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro ReplaceInFile "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
SectionEnd

SectionGroup /e "Controller Support (by mutantx20)"
    Section
        SetOutPath $INSTDIR
        !insertmacro DownloadRedirect https://redirect.mulderload.eu/pcgw/2820-hitman-2-controller-fix/13930 "hitman_2_controller.7z"
        Nsis7z::ExtractWithDetails "hitman_2_controller.7z" "Installing package %s..."
        Delete "hitman_2_controller.7z"

        FileOpen $0 "$INSTDIR\hitman2.ini" a
        FileSeek $0 0 END
        FileWrite $0 '$\r$\n; === CONTROLLER SUPPORT (Start) === $\r$\n'
        FileWrite $0 '; UseGameController$\r$\n'
        FileWrite $0 '; ConfigFile=HMCGPAD1.cfg$\r$\n'
        FileWrite $0 '; === CONTROLLER SUPPORT (End) === $\r$\n'
        FileClose $0
    SectionEnd

    Section /o "Enable (will disable keyboard controls)"
        !insertmacro ReplaceInFile "; UseGameController" "UseGameController" 1 1 "$INSTDIR\hitman2.ini"
        !insertmacro ReplaceInFile "; ConfigFile=HMCGPAD1.cfg" "ConfigFile=HMCGPAD1.cfg" 1 1 "$INSTDIR\hitman2.ini"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Language Patch" lang
    Section /o "French Patch" lang_fr
        SetOutPath $INSTDIR
        !insertmacro Download https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_French.7z "GOG_v1.01_to_French.7z"
        Nsis7z::ExtractWithDetails "GOG_v1.01_to_French.7z" "Installing package %s..."
        Delete "GOG_v1.01_to_French.7z"
    SectionEnd
    Section /o "German Patch" lang_de
        SetOutPath $INSTDIR
        !insertmacro Download https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_German.7z "GOG_v1.01_to_German.7z"
        Nsis7z::ExtractWithDetails "GOG_v1.01_to_German.7z" "Installing package %s..."
        Delete "GOG_v1.01_to_German.7z"
    SectionEnd
    Section /o "Italian Patch" lang_it
        SetOutPath $INSTDIR
        !insertmacro Download https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_Italian.7z "GOG_v1.01_to_Italian.7z"
        Nsis7z::ExtractWithDetails "GOG_v1.01_to_Italian.7z" "Installing package %s..."
        Delete "GOG_v1.01_to_Italian.7z"
    SectionEnd
    Section /o "Spanish Patch" lang_es
        SetOutPath $INSTDIR
        !insertmacro Download https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_Spanish.7z "GOG_v1.01_to_Spanish.7z"
        Nsis7z::ExtractWithDetails "GOG_v1.01_to_Spanish.7z" "Installing package %s..."
        Delete "GOG_v1.01_to_Spanish.7z"
    SectionEnd
SectionGroupEnd

Section
    # Download readme
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/hitman-2-silent-assassin/README.txt "$INSTDIR\README-MulderLoad.txt"

    # Create save folder if it doesn't exist
    SetOutPath $INSTDIR\Save
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "hitman2.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Hitman 2 Silent Assassin"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
    StrCpy $1 ${lang_fr} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro UnSelectSection ${lang}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_fr}
            !insertmacro RadioButton ${lang_de}
            !insertmacro RadioButton ${lang_it}
            !insertmacro RadioButton ${lang_es}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
