!define MUI_WELCOMEPAGE_TEXT "This installer will download and extract the TCULauncher (The Crew Unlimited) in your Steam installation of The Crew.$\r$\n$\r$\nAs TCU uses dll injection, it's recommended to exclude the folder from your antivirus. This installer has a option to do that, if you use Windows Defender.$\r$\n$\r$\nIf you owned the game on UPlay instead of Steam, you can't download it anymore from UPlay (Ubisoft, seriously...), but you can find the full version of the game on my website (mulderland.com)$\r$\n$\r$\nA BIG thanks to the TCU Team who restored this amazing game, and who did more than Ubisoft without the source code. Congratulations!"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-MulderLoad.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
!define MUI_FINISHPAGE_RUN "$INSTDIR\TCULauncher.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Configure TCULauncher"
!include "..\..\templates\select_exe.nsh"
RequestExecutionLevel admin

Name "The Crew [PATCH]"

SectionGroup "The Crew Unlimited (Server Emulator) v1.2.0.1"
    Section
        SetOutPath $INSTDIR
        AddSize 3000 # compressed (temporary)
        AddSize 10000 # decompressed

        !insertmacro Download https://thecrewunlimited.com/TCUNet/TCULauncher/TCULauncher-1.2.0.1.7z "TCULauncher.7z"
        Nsis7z::ExtractWithDetails "TCULauncher.7z" "Installing package %s..."
        Delete "TCULauncher.7z"

        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/the-crew/README-Steam.txt "README-MulderLoad.txt"

        nsExec::ExecToLog /OEM 'icacls "$INSTDIR" /grant *S-1-5-32-545:(OI)(CI)M /T'
    SectionEnd

    Section "Microsoft .NET Desktop Runtime 8.0.22 (x64)"
        SetOutPath $INSTDIR
        AddSize 61000  # compressed (temporary)
        AddSize 100000 # decompressed

        !insertmacro Download https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.22/windowsdesktop-runtime-8.0.22-win-x64.exe "windowsdesktop-runtime-win-x64.exe"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd

    Section "Whitelist game folder in Windows Defender"
        nsExec::Exec "powershell.exe -Command Add-MpPreference -ExclusionPath '$INSTDIR'"
    SectionEnd
SectionGroupEnd

Section "Fix launch time too long"
    SetOutPath "$INSTDIR"
    AddSize 13

    # https://www.nexusmods.com/watchdogs/mods/393?tab=description
    !insertmacro Download https://cdn2.mulderload.eu/g/the-crew/systemdetection64.dll-393-1-1-1748052023.zip "systemdetection64.dll.zip"
    nsisunz::Unzip /noextractpath /file "systemdetection64.dll" "systemdetection64.dll.zip" ".\"
    Delete "systemdetection64.dll.zip"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "TheCrew.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\The Crew"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
