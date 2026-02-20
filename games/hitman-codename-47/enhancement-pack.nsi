; https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v9.5.0/Ultimate-ASI-Loader.zip => dsound.dll


!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Hitman: Codename 47, aiming to provide a better experience today. It includes:$\r$\n\
- Ultimate ASI Loader (by ThirteenAG)$\r$\n\
- Widescreen & FOV Fix (by alphayellow)$\r$\n\
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
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show informations about HUD Scaling && more"
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
    !insertmacro FORCE_RENAME "DDraw.dll" "ddrawHooked.dll"

    # Install ThirteenAG's Ultimate ASI Loader (stick to 9.5, higher doesnt seem to work at least on GOG release)
    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/v9.5.0/Ultimate-ASI-Loader.zip" \
                            "https://cdn2.mulderload.eu/g/hitman-codename-47/Ultimate-ASI-Loader-9.5.zip" \
                            "Ultimate-ASI-Loader.zip" "418b117c22ff2a798cf9173ba20f8cdfde3c456e"
    !insertmacro NSISUNZ_EXTRACT "Ultimate-ASI-Loader.zip" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "dinput8.dll" "ddraw.dll"

    # Install Alphayellow's Widescreen Fix
    SetOutPath "$INSTDIR\scripts"
    !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/3919-hitman-codename-47-widescreen-fov-fix/" \
                            "https://cdn2.mulderload.eu/g/hitman-codename-47/Hitman%20Codename%2047%20-%20Widescreen%20&%20FOV%20Fix%20v1.1.rar" \
                            "Hitman Codename 47 - Widescreen & FOV Fix v1.1.rar" "7f1422aecec733fd56baf30f3652cb2e09d2d60f"
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "Hitman Codename 47 - Widescreen & FOV Fix v1.1.rar" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE

    # Configure dgVoodoo
    !insertmacro FILE_STR_REPLACE "WindowedAttributes                   = " "WindowedAttributes                   = FullscreenSize" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Resolution                          = unforced" "Resolution                          = desktop" 2 1 "$INSTDIR\dgVoodoo.conf"
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

SectionGroup /e "MulderConfig (latest)"
    Section
        AddSize 1946
        # Copy max quality INI to allow recovery
        SetOutPath "$INSTDIR\@mulderload\backup"
        File resources\hitman.ini

        # Copy Intro.zip to allow toggling the intro video in MulderConfig UI
        ${IfNot} ${FileExists} "$INSTDIR\@mulderload\backup\Intro.zip"
            CopyFiles "$INSTDIR\Cutscenes\Intro\Intro.zip" "$INSTDIR\@mulderload\backup\Intro.zip"
        ${EndIf}
    SectionEnd

    Section
        SectionIn RO
        AddSize 1024
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/Mulderland/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
        File resources\MulderConfig.json
        File resources\MulderConfig.save.json
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.23 (x64)"
        SetOutPath "$INSTDIR"
        AddSize 100000

        !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.23/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/windowsdesktop-runtime-8.0.23-win-x64.exe" \
                                "windowsdesktop-runtime-win-x64.exe" "0ecfc9a9dab72cb968576991ec34921719039d70"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

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
