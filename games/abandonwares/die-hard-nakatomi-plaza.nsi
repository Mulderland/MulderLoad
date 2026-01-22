!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download Die Hard Nakatomi Plaza from Archive.org$\r$\n- extract it with 7z and WiseUnpacker$\r$\n- apply the 1.04 and crack$\r$\n- apply mouse fix / crash fix$\r$\n- install fov fix$\r$\n- install dgVoodoo2$\r$\n- install Die Hard Improved Edition mod$\r$\n$\r$\nA big thanks to Piranha Games, CLASS, Archive.org, ThirteenAG, alphayellow DgVoodoo2 authors and of course ReiKaz316 for his mod"
!include "..\..\templates\standard.nsh"
!include "..\..\templates\includes\xdelta3.nsh"

Name "Die Hard: Nakatomi Plaza"
InstallDir "C:\MulderLoad\Die Hard Nakatomi Plaza"

Section
    SetOutPath $INSTDIR
    DetailPrint " // Downloading 7z"
    !insertmacro Get7z

    DetailPrint " // Downloading xdelta3"
    !insertmacro Download https://github.com/jmacd/xdelta-gpl/releases/download/v3.0.11/xdelta3-3.0.11-x86_64.exe.zip "xdelta3.zip"
    nsisunz::Unzip "xdelta3.zip" ".\"
    Delete "xdelta3.zip"
    Rename "xdelta3-3.0.11-x86_64.exe" "xdelta3.exe"
SectionEnd

SectionGroup "Die Hard: Nakatomi Plaza (USA)"
    Section
        AddSize 847872
        # Game
        SetOutPath $INSTDIR\@iso

        ## Download ISO from Archive.org
        !insertmacro Download https://archive.org/download/Die_Hard_Nakatomi_Plaza_USA/Disc%201.rar "Die_Hard_Nakatomi_Plaza_USA.rar"

        ## Extract ISO
        nsExec::ExecToLog '"..\7z.exe" e Die_Hard_Nakatomi_Plaza_USA.rar CD.bin'
        Delete "Die_Hard_Nakatomi_Plaza_USA.rar"
        nsExec::ExecToLog '"..\7z.exe" x -aoa -o".\" CD.bin'
        Delete "CD.bin"
        nsExec::ExecToLog '"..\7z.exe" x -aoa -o".\" CD.iso'
        Delete "CD.iso"

        ## Download WiseUnpacker
        !insertmacro Download https://github.com/mnadareski/WiseUnpacker/releases/download/2.1.0/WiseUnpacker_2.1.0_net10.0_win-x64_release.zip "WiseUnpacker.zip"
        nsisunz::Unzip "WiseUnpacker.zip" ".\"
        Delete "WiseUnpacker.zip"

        ## Extract Setup files
        nsExec::ExecToLog '".\WiseUnpacker.exe" -o=.\ SETUP.exe'

        ## Move MAINDIR contents to $INSTDIR
        !insertmacro MoveFolder "$INSTDIR\@iso\MAINDIR" "$INSTDIR\" "*.*"

        ## Clean temp files and unneeded files
        SetOutPath $INSTDIR
        RMDir /r "$INSTDIR\@iso"
        Delete "Unwise.exe"
        Delete "Register Die Hard Nakatomi Plaza Online.url"

        ## Create Save directory to fix saves issue
        CreateDirectory $INSTDIR\Save
    SectionEnd

    Section "Official patch v1.04"
        SetOutPath $INSTDIR

        !insertmacro DownloadRedirect https://redirect.mulderload.eu/pcgw/381-die-hard-nakatomi-plaza-patch-104/776 "si_dhnp_en_update_10_1041.rar"
        #!insertmacro Download https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/si_dhnp_en_update_10_1041.rar "si_dhnp_en_update_10_1041.rar"
        nsExec::ExecToLog '".\7z.exe" e -aoa si_dhnp_en_update_10_1041.rar'
        RMDir "$INSTDIR\si_dhnp_en_update_10_1041"
        Delete "si_dhnp_en_update_10_1041.rar"
    SectionEnd

    Section "NoCD crack v1.04 (by CLASS)"
        SetOutPath $INSTDIR

        !insertmacro Download https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/clsdh04c.rar "clsdh04c.rar"
        Delete "Nakatomi.exe.bak"
        Rename "Nakatomi.exe" "Nakatomi.exe.bak"
        nsExec::ExecToLog '".\7z.exe" e -aoa clsdh04c.rar'
        Delete "clsdh04c.rar"
    SectionEnd
SectionGroupEnd

Section "Mouse Fix / Crash Fix"
    AddSize 147
    SetOutPath $INSTDIR
    !insertmacro DownloadRedirect https://redirect.mulderload.eu/pcgw/2528-no-one-lives-forever-mouse-input-fix-dinputdll/12670 "dinput.dll"
    #!insertmacro Download https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/dinput.dll "dinput.dll"
SectionEnd

Section "FOV Fix v1.4.1 (by alphayellow)"
    AddSize 3584
    # ThirteenAG's Ultimate ASI Loader
    SetOutPath $INSTDIR
    !insertmacro Download https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/winmm-Win32.zip "winmm.zip"
    nsisunz::Unzip /noextractpath /file "winmm.dll" "winmm.zip" ".\"
    Delete "winmm.zip"

    # alphayellow's FOV Fix
    SetOutPath $INSTDIR\scripts
    !insertmacro Download https://github.com/alphayellow1/AlphaYellowWidescreenFixes/releases/download/diehardnakatomiplaza/Die.Hard.Nakatomi.Plaza.-.FOV.Fix.v1.4.1.rar "FOV_Fix.rar"
    nsExec::ExecToLog '"..\7z.exe" e -aoa FOV_Fix.rar'
    Delete "FOV_Fix.rar"
SectionEnd

Section "dgVoodoo2 (fix multiple other issues)"
    AddSize 1311
    # dgVoodoo
    SetOutPath $INSTDIR
    !insertmacro Download https://github.com/dege-diosg/dgVoodoo2/releases/download/v2.86.4/dgVoodoo2_86_4.zip "dgVoodoo2.zip"
    nsisunz::Unzip /noextractpath /file "dgVoodoo.conf" "dgVoodoo2.zip" ".\"
    nsisunz::Unzip /noextractpath /file "dgVoodooCpl.exe" "dgVoodoo2.zip" ".\"
    nsisunz::Unzip /noextractpath /file "MS\x86\D3D8.dll" "dgVoodoo2.zip" ".\"
    nsisunz::Unzip /noextractpath /file "MS\x86\D3DImm.dll" "dgVoodoo2.zip" ".\"
    nsisunz::Unzip /noextractpath /file "MS\x86\DDraw.dll" "dgVoodoo2.zip" ".\"
    Delete "dgVoodoo2.zip"

    # config
    !insertmacro ReplaceInFile "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro ReplaceInFile "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro ReplaceInFile "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro ReplaceInFile "Resolution                          = unforced" "Resolution                          = desktop" 2 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro ReplaceInFile "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro ReplaceInFile "DisableAltEnterToToggleScreenMode   = true" "DisableAltEnterToToggleScreenMode   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
SectionEnd

Section "Skip intro videos"
    !insertmacro ReplaceInFile "$\"nomovies$\" $\"0$\"" "$\"nomovies$\" $\"1$\"" 1 1 "$INSTDIR\autoexec.cfg"
SectionEnd

Section "[MOD] Die Hard Improved Edition v2 beta (by ReiKaz316)" mod
    AddSize 614400
    SetOutPath $INSTDIR

    DetailPrint " // Backup original files (non-mod)"
    CreateDirectory $INSTDIR\backup
    CopyFiles $INSTDIR\Engine.rez $INSTDIR\backup\Engine.rez
    CopyFiles $INSTDIR\Nakatomi.rez $INSTDIR\backup\Nakatomi.rez

    DetailPrint " // Downloading mod"
    !insertmacro Download https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z "DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z"
    Nsis7z::ExtractWithDetails "DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z" "Installing package %s..."
    Delete "DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z"

    DetailPrint " // Applying xdelta patch"
    !insertmacro XDelta3_ApplyPatches "$INSTDIR"
SectionEnd

SectionGroup "Language" lang
    Section "English (default)" lang_en
        Delete "$INSTDIR\custom.cfg"
    SectionEnd

    Section /o "English with french subtitles (requires mod)" lang_vostfr
        FileOpen $0 "$INSTDIR\custom.cfg" w
        FileWrite $0 'language french'
        FileClose $0
    SectionEnd

    Section /o "English with german subtitles (requires mod)" lang_omu
        FileOpen $0 "$INSTDIR\custom.cfg" w
        FileWrite $0 'language german'
        FileClose $0
    SectionEnd

    Section /o "Full french (incompatible with mod)" lang_fr
        FileOpen $0 "$INSTDIR\custom.cfg" w
        FileWrite $0 'language french'
        FileClose $0

        DetailPrint " // Backup english files"
        CreateDirectory $INSTDIR\backup
        CopyFiles $INSTDIR\Nakatomi.rez $INSTDIR\backup\Nakatomi.rez
        CopyFiles $INSTDIR\Nakatomi2.rez $INSTDIR\backup\Nakatomi2.rez

        DetailPrint " // Download french audio xdelta"
        SetOutPath $INSTDIR
        !insertmacro Download https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/french_audio_xdelta.7z "french_audio_xdelta.7z"
        Nsis7z::ExtractWithDetails "french_audio_xdelta.7z" "Installing package %s..."
        Delete "french_audio_xdelta.7z"

        DetailPrint " // Applying xdelta patches"
        !insertmacro XDelta3_ApplyPatches "$INSTDIR"
    SectionEnd
SectionGroupEnd

Section
    DetailPrint " // Remove 7z"
    Delete $INSTDIR\7z.dll
    Delete $INSTDIR\7z.exe
    RMDir /r $INSTDIR\Formats

    DetailPrint " // Remove xdelta3"
    Delete "xdelta3.exe"
SectionEnd

Function .onInit
    StrCpy $1 ${lang_en} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro UnSelectSection ${lang}
    ${Else}
        !insertmacro StartRadioButtons $1
            !insertmacro RadioButton ${lang_en}
            !insertmacro RadioButton ${lang_vostfr}
            !insertmacro RadioButton ${lang_omu}
            !insertmacro RadioButton ${lang_fr}
        !insertmacro EndRadioButtons
    ${EndIf}

    ${If} ${SectionIsSelected} ${mod}
        ${If} ${SectionIsSelected} ${lang_fr}
            !insertmacro UnSelectSection ${mod}
            MessageBox MB_ICONSTOP "Sorry, the mod is incompatible with the full french version, and has been unselected."
        ${EndIf}
    ${Else}
        ${If} ${SectionIsSelected} ${lang_vostfr}
            !insertmacro SelectSection ${mod}
            MessageBox MB_OK "The mod is required for the selected language and has been automatically selected."
        ${EndIf}
        ${If} ${SectionIsSelected} ${lang_omu}
            !insertmacro SelectSection ${mod}
            MessageBox MB_OK "The mod is required for the selected language and has been automatically selected."
        ${EndIf}
    ${EndIf}
FunctionEnd
