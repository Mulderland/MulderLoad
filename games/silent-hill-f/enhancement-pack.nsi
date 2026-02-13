!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Silent Hill f, which includes:$\r$\n\
- SHfFix (by Lyall) to improve multiple things in the game, updated with the latest version of Ultimate ASI Loader (by ThirteenAG)$\r$\n\
- MulderConfig to configure SHfFix && edit HDR brightness$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
A special thanks to Lyall for releasing this fix so quickly!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Silent Hill f [Enhancement Pack]"

SectionGroup /e "ThirteenAG's Ultimate ASI Loader"
    Section
        SectionIn RO
        AddSize 1151
        SetOutPath "$INSTDIR\SHf\Binaries\Win64"
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/x64-latest/dsound-x64.zip" "dsound.zip" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "dsound.zip" ".\" "dsound.dll" "AUTO_DELETE"
    SectionEnd

    Section "Lyall's SHfFix v0.0.1"
        SectionIn RO
        AddSize 1138
        SetOutPath "$INSTDIR\SHf\Binaries\Win64\scripts"
        !insertmacro DOWNLOAD_2 "https://codeberg.org/Lyall/SHfFix/releases/download/0.0.1/SHfFix_0.0.1.zip" \
                                "https://cdn2.mulderload.eu/g/silent-hill-f/SHfFix_0.0.1.zip" \
                                "SHfFix.zip" "8346265b6afb034d9477a86be79f5251853112d1"
        !insertmacro NSISUNZ_EXTRACT_ONE "SHfFix.zip" ".\" "SHfFix.asi" ""
        !insertmacro NSISUNZ_EXTRACT_ONE "SHfFix.zip" ".\" "SHfFix.ini" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_1 "https://github.com/Mulderland/MulderConfig/releases/latest/download/MulderConfig.exe" "MulderConfig.exe" ""
        File "resources\MulderConfig.json"
        File "resources\MulderConfig.save.json"
        ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
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

Function .onInit
    StrCpy $SELECT_FILENAME "SHf.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\SILENT HILL f"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
