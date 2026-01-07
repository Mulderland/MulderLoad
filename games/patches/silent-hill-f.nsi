!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will install$\r$\n- Ultimate ASI Loader (latest)$\r$\n- SHfFix (v0.0.1)$\r$\n- MulderConfig to configure SHfFix + edit HDR brightness.$\r$\n$\r$\nA big thanks to Lyall for creating this fix, and of course ThirteenAG !"
!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\templates\select_exe.nsh"

Name "Silent Hill f [Enhancement Pack]"

SectionGroup /e "ThirteenAG's Ultimate ASI Loader"
    Section
        SectionIn RO
        AddSize 1151
        SetOutPath $INSTDIR\SHf\Binaries\Win64
        !insertmacro Download https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/x64-latest/dsound-x64.zip "dsound.zip"
        nsisunz::Unzip /noextractpath /file "dsound.dll" "dsound.zip" ".\"
        Delete "dsound.zip"
    SectionEnd

    Section "Lyall's SHfFix v0.0.1"
        SectionIn RO
        AddSize 1138
        SetOutPath $INSTDIR\SHf\Binaries\Win64\scripts
        !insertmacro Download https://codeberg.org/Lyall/SHfFix/releases/download/0.0.1/SHfFix_0.0.1.zip "SHfFix.zip"
        nsisunz::Unzip /noextractpath /file "SHfFix.asi" "SHfFix.zip" ".\"
        nsisunz::Unzip /noextractpath /file "SHfFix.ini" "SHfFix.zip" ".\"
        Delete "SHfFix.zip"
    SectionEnd
SectionGroupEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath $INSTDIR
        !insertmacro Download https://github.com/mulderload/MulderConfig/releases/latest/download/MulderConfig.exe "MulderConfig.exe"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/silent-hill-f/MulderConfig.json "MulderConfig.json"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/silent-hill-f/MulderConfig.save.json "MulderConfig.save.json"
        ExecWait '"$INSTDIR\MulderConfig.exe" -apply' $0
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.22 (x64)"
        SetOutPath $INSTDIR
        AddSize 100000

        !insertmacro Download https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.22/windowsdesktop-runtime-8.0.22-win-x64.exe "windowsdesktop-runtime-win-x64.exe"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "SHf.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\SILENT HILL f"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
