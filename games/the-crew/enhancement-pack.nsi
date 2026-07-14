!ifndef NSI_INCLUDE
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for The Crew, which can$\r$\n\
    - fix NTFS permissions in the game folder$\r$\n\
    - install The Crew Unlimited (the server emulator)$\r$\n\
    - (optionally) whitelist the game folder in Windows Defender*$\r$\n\
    - install a fix for too long launch times$\r$\n\
    $\r$\n\
    *NOTE: if you use another antivirus, you'll probably have to manually exclude the game folder, as TCU uses dll injection.$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
    $\r$\n\
    Congratulations to the TCU Team who did an amazing work to bring back this great game to life!"

    !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
    !define MUI_FINISHPAGE_SHOWREADME_TEXT "Show manual instructions (important)"
    !define MUI_FINISHPAGE_RUN "$INSTDIR\TCULauncher.exe"
    !define MUI_FINISHPAGE_RUN_TEXT "Configure TCULauncher"
    !include "..\..\includes\templates\SelectTemplate.nsh"
    RequestExecutionLevel admin

    Name "The Crew [Enhancement Pack]"

    !define README_FILE "ENHA_README.txt"
!endif

SectionGroup /e "The Crew Unlimited (Server Emulator) v1.2.0.1"
    Section
        SetOutPath "$INSTDIR"
        AddSize 10000

        !insertmacro DOWNLOAD_2 "https://thecrewunlimited.com/TCUNet/TCULauncher/TCULauncher-1.2.0.1.7z" \
                                "https://cdn.mulderload.eu/games/the-crew/impr_misc/TCULauncher-1.2.0.1.7z" \
                                "TCULauncher.7z" \
                                "0db2211ac432ee5740423aaba10c40f835b6aa1e"

        !insertmacro NSIS7Z_EXTRACT "TCULauncher.7z" ".\" "AUTO_DELETE"

        CreateDirectory "$INSTDIR\@mulderload"
        File /oname=@mulderload\README.txt resources\${README_FILE}
        nsExec::ExecToLog /OEM 'icacls "$INSTDIR" /grant *S-1-5-32-545:(OI)(CI)M /T'
    SectionEnd

    Section "Microsoft .NET Desktop Runtime 8.0.28 (x64)"
        SetOutPath "$INSTDIR"
        AddSize 100000

        !insertmacro DOWNLOAD_2 "https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.28/windowsdesktop-runtime-8.0.28-win-x64.exe" \
                                "https://cdn.mulderload.eu/redistributables/microsoft/dotnet/windowsdesktop-runtime-8.0.28-win-x64.exe" \
                                "windowsdesktop-runtime-win-x64.exe" \
                                "bd9fe2fe81c6a74f01e2abfcb79921c226e2827b"

        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd

    Section /o "Whitelist game folder in Windows Defender"
        nsExec::Exec "powershell.exe -Command Add-MpPreference -ExclusionPath '$INSTDIR'"
    SectionEnd
SectionGroupEnd

Section "Fix launch time too long"
    SetOutPath "$INSTDIR"
    AddSize 13

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/watchdogs/mods/393?tab=files&file_id=1268" \
                            "systemdetection64.dll.zip" \
                            "718fc899835316ceca1719191a72d7d47f579d50"

    !insertmacro NSISUNZ_EXTRACT_ONE "systemdetection64.dll.zip" ".\" "systemdetection64.dll" "AUTO_DELETE"
SectionEnd

!ifndef NSI_INCLUDE
    Function .onInit
        StrCpy $SELECT_FILENAME "TheCrew.exe"
        StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\The Crew"
        StrCpy $SELECT_RELATIVE_INSTDIR ""
    FunctionEnd
!endif
