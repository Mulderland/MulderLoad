!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Hitman: Codename 47, aiming to provide a better experience today. It includes:$\r$\n\
- Ultimate ASI Loader (by ThirteenAG)$\r$\n\
- Widescreen && FOV Fix (by alphayellow)$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- MulderConfig (to configure HUD Scaling && more)$\r$\n\
- Modern keyboard mapping$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to alphayellow for his new widescreen fix, and for adding OpenGL support!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show infos about HUD Scaling && known issues (important)"
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Hitman: Codename 47 [Enhancement Pack]"

Section "Widescreen fix (by alphayellow) + dgVoodoo2"
    # Copy max quality INI
    SetOutPath "$INSTDIR"
    File resources\hitman.ini

    # Install dgVoodoo
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\DDraw.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3DImm.dll" "AUTO_DELETE"

    # Install ThirteenAG's Ultimate ASI Loader (stick to 9.5, higher doesnt seem to work on GOG release)
    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v9.5.0/Ultimate-ASI-Loader.zip" \
                            "https://cdn.mulderload.eu/tools/ultimate-asi-loader/Ultimate-ASI-Loader-v9.5.0.zip" \
                            "Ultimate-ASI-Loader.zip" \
                            "418b117c22ff2a798cf9173ba20f8cdfde3c456e"

    !insertmacro NSISUNZ_EXTRACT "Ultimate-ASI-Loader.zip" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "dinput8.dll" "dsound.dll"

    # Install Alphayellow's Widescreen Fix
    SetOutPath "$INSTDIR\scripts"
    !insertmacro DOWNLOAD_2 "https://github.com/alphayellow1/AlphaYellowWidescreenFixes/releases/download/hitmancodename47/Hitman.Codename.47.-.Widescreen.FOV.Fix.v1.1.1.rar" \
                            "https://cdn.mulderload.eu/games/hitman-codename-47/impr_gfx/Hitman.Codename.47.-.Widescreen.FOV.Fix.v1.1.1.rar" \
                            "Hitman.Codename.47.-.Widescreen.FOV.Fix.v1.1.1.rar" \
                            "7ea364ba1c5f7b7454d2c97c3533f62b2a8fdc6f"

    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "Hitman.Codename.47.-.Widescreen.FOV.Fix.v1.1.1.rar" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE

    # Configure dgVoodoo
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"

    # Remove nGlide to avoid conflict with dgVoodoo (only useful on GOG release)
    Delete "$INSTDIR\3DfxSpl.dll"
    Delete "$INSTDIR\3DfxSpl2.dll"
    Delete "$INSTDIR\3DfxSpl3.dll"
    Delete "$INSTDIR\glide.dll"
    Delete "$INSTDIR\glide2x.dll"
    Delete "$INSTDIR\glide3x.dll"
    Delete "$INSTDIR\nglide_config.exe"
    Delete "$INSTDIR\nglide_readme.txt"
    Delete "$INSTDIR\nGlideEULA.txt"
SectionEnd

Section "MulderConfig (latest)"
    # Copy Intro.zip to allow toggling the intro video in MulderConfig UI
    AddSize 1945
    ${IfNot} ${FileExists} "$INSTDIR\@mulderload\backup\Intro.zip"
        CopyFiles "$INSTDIR\Cutscenes\Intro\Intro.zip" "$INSTDIR\@mulderload\backup\Intro.zip"
    ${EndIf}

    # MulderConfig
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Section "Modern keyboard mapping"
    SetOutPath "$INSTDIR"
    File resources\Hitman.cfg
SectionEnd

Section
    # Copy readme
    SetOutPath "$INSTDIR\@mulderload"
    File "resources\README.txt"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Hitman.Exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Hitman Codename 47"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
