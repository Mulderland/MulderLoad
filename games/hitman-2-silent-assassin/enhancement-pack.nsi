!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Hitman 2: Silent Assassin, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Downgrade to GOG v1.01 (uncensored) if v1.02 detected$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- Widescreen Fix (by nemesis2000)$\r$\n\
- Controller Support (by mutantx20)$\r$\n\
- (optionally) Language patches$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Specila thanks to the dgVoodoo2 project!"

!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Hitman 2: Silent Assassin [Enhancement Pack]"

Section "Downgrade Steam v1.02 to GOG v1.01 (uncensored)"
    AddSize 10240
    SetOutPath "$INSTDIR"

    DetailPrint " // Comparing binary with GOG checksum..."
    !insertmacro FILE_HASH_EQUALS "hitman2.exe" "8eda1825c31521adb91c838b668a4c09ed51ac6d" $0
    ${If} $0 == "1"
        MessageBox MB_ICONEXCLAMATION "Binary is already the GOG v1.01 (uncensored). Skipping."
        DetailPrint " // Skipping downgrade."
        goto skip_section
    ${EndIf}

    DetailPrint " // Comparing binary with Steam checksum..."
    !insertmacro FILE_HASH_EQUALS "hitman2.exe" "6610bde53b3e96f313f7a4f530a53660e8f02e49" $0
    ${If} $0 != "1"
        MessageBox MB_ICONEXCLAMATION "Only Steam release can apply this downgrade. Aborting."
        DetailPrint " // Aborting downgrade."
        goto skip_section
    ${EndIf}

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/Steam_v1.02_to_GOG_v1.01.7z" \
                            "https://www.mediafire.com/file_premium/kmtlx5kesjpq3gr/Steam_v1.02_to_GOG_v1.01.7z/file" \
                            "Steam_v1.02_to_GOG_v1.01.7z" "51f3f6f74b621ef08762720aaf446d72edb3d418"
    !insertmacro NSIS7Z_EXTRACT "Steam_v1.02_to_GOG_v1.01.7z" ".\" "AUTO_DELETE"
    skip_section:
SectionEnd

Section "Widescreen fix (by nemesis2000) + dgVoodoo"
    AddSize 8704
    SetOutPath "$INSTDIR"

    # Max Settings INI (except DXT still on, because it can causes crashes without it)
    Delete "hitman2.ini"
    File resources\hitman2.ini

    # nemesis2000 Widescreen Fix
    !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/2787-hitman-2-silent-assassin-widescreen-fix/#13816" \
                            "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/Hitman%202%20Silent%20Assassin%20Widescreen%20Fix.zip" \
                            "Hitman 2 Silent Assassin Widescreen Fix.zip" "9a2c7e17e4a303e2dec640b3ce23f90192bc2398"
    !insertmacro NSISUNZ_EXTRACT "Hitman 2 Silent Assassin Widescreen Fix.zip" ".\" "AUTO_DELETE"

    # dgVoodoo
    SetOutPath "$INSTDIR\dgVoodoo"
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D8.dll" "AUTO_DELETE"

    # config
    !insertmacro FILE_STR_REPLACE "RealDllPath       = AUTO" "RealDllPath       = dgVoodoo\d3d8.dll" 1 1 "$INSTDIR\d3d8.ini"
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Resolution                          = unforced" "Resolution                          = desktop" 2 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo\dgVoodoo.conf"
SectionEnd

SectionGroup /e "Controller Support (by mutantx20)"
    Section
        AddSize 862
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/2820-hitman-2-controller-fix/#13930" \
                                "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/hitman%202%20controller.7z" \
                                "hitman 2 controller.7z" "bbe6e442e121dd968e138f57a14ce1517e7d6de1"
        !insertmacro NSIS7Z_EXTRACT "hitman 2 controller.7z" ".\" "AUTO_DELETE"

        FileOpen $0 "$INSTDIR\hitman2.ini" a
        FileSeek $0 0 END
        FileWrite $0 '$\r$\n; === CONTROLLER SUPPORT (Start) === $\r$\n'
        FileWrite $0 '; UseGameController$\r$\n'
        FileWrite $0 '; ConfigFile=HMCGPAD1.cfg$\r$\n'
        FileWrite $0 '; === CONTROLLER SUPPORT (End) === $\r$\n'
        FileClose $0
    SectionEnd

    Section /o "Enable (will disable keyboard controls)"
        !insertmacro FILE_STR_REPLACE "; UseGameController" "UseGameController" 1 1 "$INSTDIR\hitman2.ini"
        !insertmacro FILE_STR_REPLACE "; ConfigFile=HMCGPAD1.cfg" "ConfigFile=HMCGPAD1.cfg" 1 1 "$INSTDIR\hitman2.ini"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Language Patch" lang
    Section /o "French Patch" lang_fr
        AddSize 9216
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_French.7z" \
                                "https://www.mediafire.com/file_premium/mkouexkozv8wk2e/GOG_v1.01_to_French.7z/file" \
                                "GOG_v1.01_to_French.7z" "eb2d3939dce87824ecd09945aaca8b417379de96"
        !insertmacro NSIS7Z_EXTRACT "GOG_v1.01_to_French.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "German Patch" lang_de
        AddSize 5120
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_German.7z" \
                                "https://www.mediafire.com/file_premium/83pstsv4tqlild9/GOG_v1.01_to_German.7z/file" \
                                "GOG_v1.01_to_German.7z" "47949c437016aff4c4267b93383814bc3e6360a5"
        !insertmacro NSIS7Z_EXTRACT "GOG_v1.01_to_German.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "Italian Patch" lang_it
        AddSize 0 ; actually it reduces the game size by 4MB
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_Italian.7z" \
                                "https://www.mediafire.com/file_premium/lcui99srndupt46/GOG_v1.01_to_Italian.7z/file" \
                                "GOG_v1.01_to_Italian.7z" "47949c437016aff4c4267b93383814bc3e6360a5"
        !insertmacro NSIS7Z_EXTRACT "GOG_v1.01_to_Italian.7z" ".\" "AUTO_DELETE"
    SectionEnd

    Section /o "Spanish Patch" lang_es
        AddSize 14336
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-2-silent-assassin/GOG_v1.01_to_Spanish.7z" \
                                "https://www.mediafire.com/file_premium/ayq17f6mj4j93jp/GOG_v1.01_to_Spanish.7z/file" \
                                "GOG_v1.01_to_Spanish.7z" "38c8bb6a5674910c753b602229192797776abd96"
        !insertmacro NSIS7Z_EXTRACT "GOG_v1.01_to_Spanish.7z" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section
    # Copy readme
    SetOutPath "$INSTDIR\@mulderload"
    File "resources\README.txt"

    # Create save folder if it doesn't exist
    CreateDirectory "$INSTDIR\Save"
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
