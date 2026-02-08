!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download The_Simpsons_Hit_And_Run-FLT from Archive.org and extract it$\r$\n- run the original installer, silently$\r$\n- apply the crack$\r$\n- (optionaly) download french files$\r$\n- (optionaly) download Lucas's Launcher or d3d8to9$\r$\n$\r$\nA big thanks to Matt Groening, Radical Entertainment, Fairlight, Archive.org and of course Lucas/Donut Team for their amazing works for the preservation of this game.$\r$\n$\r$\nWARNING: at the end of the setup, it will asks for CD1, just click OK (the folder contains the 3 CDs together)."
!include "..\..\templates\standard.nsh"
RequestExecutionLevel admin

Name "The Simpsons: Hit & Run"
InstallDir "C:\MulderLoad\The Simpsons Hit & Run"

Section "The Simpsons: Hit & Run"
    SetOutPath $INSTDIR\@tmp

    !insertmacro Download https://archive.org/download/the-simpsons-hit-and-run-flt/The%20Simpsons%20Hit%20and%20Run%20%28FLT%29.zip "The_Simpsons_Hit_And_Run-FLT.zip"
    !insertmacro Get7z

    # Extract CD1
    nsisunz::Unzip /noextractpath /file "Simpsons_Hit_and_Run_ISO\CD1\FLT-HAR1.BIN" "The_Simpsons_Hit_And_Run-FLT.zip" ".\"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR1.BIN'
    Delete "FLT-HAR1.BIN"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR1.iso'
    Delete "FLT-HAR1.iso"

    # Extract CD2
    nsisunz::Unzip /noextractpath /file "Simpsons_Hit_and_Run_ISO\CD2\FLT-HAR2.BIN" "The_Simpsons_Hit_And_Run-FLT.zip" ".\"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR2.BIN'
    Delete "FLT-HAR2.BIN"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR2.iso'
    Delete "FLT-HAR2.iso"

    # Extract CD3
    nsisunz::Unzip /noextractpath /file "Simpsons_Hit_and_Run_ISO\CD3\FLT-HAR3.BIN" "The_Simpsons_Hit_And_Run-FLT.zip" ".\"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR3.BIN'
    Delete "FLT-HAR3.BIN"
    nsExec::ExecToLog '".\7z.exe" x -aoa -o".\" FLT-HAR3.iso'
    Delete "FLT-HAR3.iso"

    # Delete zip
    Delete "The_Simpsons_Hit_And_Run-FLT.zip"

    # Delete Launch.exe to avoid it showing at the end of the installshield process
    Delete "Launch.exe"

    # Run Setup
    !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/the-simpsons-hit-and-run/setup-mulderload.iss "setup-mulderload.iss"
    !insertmacro ReplaceInFile "___TARGETDIR___" "$INSTDIR" 1 1 "setup-mulderload.iss"
    ExecWait '"setup.exe" /s /SMS /f1".\setup-mulderload.iss"' $0

    # Remove Start Menu shortcut
    SetShellVarContext all
    RMDir /r "$SMPROGRAMS\Vivendi Universal Games\The Simpsons Hit & Run"
    RMDir "$SMPROGRAMS\Vivendi Universal Games"
    SetShellVarContext current

    # Copy Crack
    SetOutPath $INSTDIR
    Rename "Simpsons.exe" "Simpsons.exe.bak"
    Rename "@tmp\Crack\Simpsons.exe" "Simpsons.exe"

    # Delete @tmp
    RMDir /r "$INSTDIR\@tmp"
SectionEnd

Section /o "Patch FR"
    SetOutPath $INSTDIR

    Delete "dialog.rcf"
    Delete "README.rtf"

    !insertmacro Download https://www.mediafire.com/file_premium/tw3pxs7itrr6g25/fr_delta_patch.7z/file "fr_delta_patch.7z"
    Nsis7z::ExtractWithDetails "fr_delta_patch.7z" "Installing package %s..."
    Delete "fr_delta_patch.7z"

    !insertmacro Download https://www.mediafire.com/file_premium/lmpoyz6y9ujbhs6/fr_crk.7z/file "fr_crack.7z"
    Nsis7z::ExtractWithDetails "fr_crack.7z" "Installing package %s..."
    Delete "fr_crack.7z"
SectionEnd

SectionGroup /e "Improvements" impr
    Section "Lucas' Launcher v1.26.1 (recommended)" impr_lucas
        SetOutPath $INSTDIR

        !insertmacro Download https://modbakery.donutteam.com/release-branch-version-files/download/6/46/75/71 "LucasLauncher.zip"
        nsisunz::Unzip "LucasLauncher.zip" ".\"
        Delete "LucasLauncher.zip"

        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/the-simpsons-hit-and-run/Settings.ini "Settings.ini"
    SectionEnd

    Section /o "d3d8to9" impr_d3d8to9
        SetOutPath $INSTDIR

        !insertmacro Download https://github.com/crosire/d3d8to9/releases/latest/download/d3d8.dll "d3d8.dll"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $1 ${impr_lucas} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${impr}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${impr_lucas}
            !insertmacro RadioButton ${impr_d3d8to9}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
