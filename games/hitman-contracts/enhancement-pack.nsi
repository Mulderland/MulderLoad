!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Hitman: Contracts, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Ultimate ASI Loader (by ThirteenAG)$\r$\n\
- Widescreen Fix (by nemesis2000)$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- Missing Direct3D effects (by burntshrimp)$\r$\n\
- Controller support (by mutantx20)$\r$\n\
- MulderConfig (to configure HUD Scaling && more)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show infos about HUD Scaling && known issues"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Hitman: Contracts [Enhancement Pack]"

Section
    # Copy Max Quality INI
    SetOutPath "$INSTDIR"
    File "resources\HitmanContracts.ini"
SectionEnd

Section "Widescreen fix (by nemesis2000) + dgVoodoo2"
    AddSize 3282
    SetOutPath "$INSTDIR"

    # Install dgVoodoo
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D8.dll" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "D3D8.dll" "d3d8Hooked.dll"

    # Install ThirteenAG's Ultimate ASI Loader
    !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/d3d8-Win32.zip" "d3d8.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "d3d8.zip" ".\" "d3d8.dll" "AUTO_DELETE"

    # Install nemesis2000's Widescreen Fix
    SetOutPath "$INSTDIR\scripts"
    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-contracts/Hitman%20Contracts%20Widescreen%20Fix.zip" \
                            "https://www.mediafire.com/file_premium/urcjckifsujp3zy/Hitman_Contracts_Widescreen_Fix.zip/file" \
                            "Hitman Contracts Widescreen Fix.zip" "ac56b015d4422e43305bc1139327905eab3a24f1"
    !insertmacro NSISUNZ_EXTRACT_ONE "Hitman Contracts Widescreen Fix.zip" ".\" "scripts\h3.ini" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "Hitman Contracts Widescreen Fix.zip" ".\" "scripts\h3w.asi" "AUTO_DELETE"

    # Configure dgVoodoo
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 2048" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
SectionEnd

Section "Add missing Direct3D effects (by burntshrimp)"
    AddSize 12
    # Install ThirteenAG's Ultimate ASI Loader (if not already installed by the previous section)
    ${IfNot} ${FileExists} "$INSTDIR\d3d8.dll"
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/d3d8-Win32.zip" "d3d8.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "d3d8.zip" ".\" "d3d8.dll" "AUTO_DELETE"
    ${EndIf}

    SetOutPath "$INSTDIR\scripts"

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-contracts/HitmanContractsFix-ASI.7z" \
                            "https://www.mediafire.com/file_premium/6gbzjy7f1lyzfix/HitmanContractsFix-ASI.7z/file" \
                            "HitmanContractsFix-ASI.7z" "0d3a8bd43c5bbabf5977a67b130796d3ed605423"
    !insertmacro NSIS7Z_EXTRACT "HitmanContractsFix-ASI.7z" ".\" "AUTO_DELETE"
    Delete "HitmanContractsFix.cpp"
    Delete "HitmanContractsFix.sln"
    Delete "HitmanContractsFix.vcxproj.user"
SectionEnd

Section "Add Xinput Controller support (by mutantx20)"
    AddSize 861
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://cdn2.mulderload.eu/g/hitman-contracts/Hitman%20-%20Contracts%20controller%20fix.7z" \
                            "https://www.mediafire.com/file_premium/gu1not4kr6aab4a/Hitman_-_Contracts_controller_fix.7z/file" \
                            "Hitman - Contracts controller fix.7z" "e5998180058614e925be8fd6e4e28091436274ac"
    !insertmacro NSIS7Z_EXTRACT "Hitman - Contracts controller fix.7z" ".\" "AUTO_DELETE"
    Delete "alec 360.txt"
SectionEnd

SectionGroup /e "MulderConfig (latest)"
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

Section
    # Copy readme
    SetOutPath "$INSTDIR\@mulderload"
    File "resources\README.txt"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "HitmanContracts.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Hitman Contracts"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
