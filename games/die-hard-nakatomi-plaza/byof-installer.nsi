!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game files. You must provide your own disc image. It has been tested with US release; compatibility with other versions is not guaranteed.$\r$\n\
$\r$\n\
It installs the game (without running Installshield) and adds:$\r$\n\
- Mouse fix / Crash fix$\r$\n\
- FOV fix$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- (optionally) French patch$\r$\n\
- (optionally) Die Hard Improved Edition (mod)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
Die Hard is a trademark of 20th Century Fox. This project is not affiliated with or endorsed by 20th Century Fox or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\WiseUnpacker.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

!insertmacro BYOF_DEFINE "CD" "Images files|*.bin;*.iso" "11765655d34a7999bff73f3294744661fcc2921b"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Name "Die Hard: Nakatomi Plaza"
InstallDir "C:\MulderLoad\Die Hard Nakatomi Plaza"

Section
    !insertmacro 7Z_GET
    !insertmacro WISEUNPACKER_GET
    !insertmacro XDELTA3_GET
SectionEnd

SectionGroup "Die Hard: Nakatomi Plaza (Full Installation)"
    Section
        AddSize 847872

        # Game
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_CD" "$INSTDIR\@mulderload\iso" ""
        !insertmacro WISEUNPACKER_UNPACK "$INSTDIR\@mulderload\iso\SETUP.EXE" "$INSTDIR"
        RMDir /r "$INSTDIR\@mulderload\iso"

        ## Clean temp files and unneeded files
        Delete "$INSTDIR\Unwise.exe"
        Delete "$INSTDIR\Register Die Hard Nakatomi Plaza Online.url"

        ## Create Save directory to fix saves issue
        CreateDirectory "$INSTDIR\Save"
    SectionEnd

    Section "Official Patch v1.04"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/381-die-hard-nakatomi-plaza-patch-104/#776" \
                                "https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/si_dhnp_en_update_10_1041.rar" \
                                "si_dhnp_en_update_10_1041.rar" "c3e0f4a1345678759a581023d46f4597757d6967"
        !insertmacro 7Z_EXTRACT "si_dhnp_en_update_10_1041.rar" ".\" "AUTO_DELETE"
        !insertmacro FOLDER_MERGE "$INSTDIR\si_dhnp_en_update_10_1041" "$INSTDIR\"
    SectionEnd

    Section "Remove legacy disc check"
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/m4og74rtjsyvv6n/clsdh04c.rar/file" \
                                "https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/clsdh04c.rar" \
                                "clsdh04c.rar" "cdd544e6bf1c7227c9ba7c21cb6b0012509e286b"
        !insertmacro FORCE_RENAME "Nakatomi.exe" "Nakatomi.exe.bak"
        !insertmacro 7Z_EXTRACT "clsdh04c.rar" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section "Mouse Fix / Crash Fix (by demon27248)"
    AddSize 147
    SetOutPath "$INSTDIR"
    !insertmacro DOWNLOAD_2 "https://community.pcgamingwiki.com/files/file/2528-no-one-lives-forever-mouse-input-fix-dinputdll/#12670" \
                            "https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/dinput.dll" \
                            "dinput.dll" "1f0636f8821c8a862cef94bf83f68edbc35f372d"
SectionEnd

Section "FOV Fix v1.4.1 (by alphayellow)"
    AddSize 3584
    SetOutPath "$INSTDIR"

    # ThirteenAG's Ultimate ASI Loader
    !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/winmm-Win32.zip" "winmm.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "winmm.zip" ".\" "winmm.dll" "AUTO_DELETE"

    # alphayellow's FOV Fix
    SetOutPath "$INSTDIR\scripts"
    !insertmacro DOWNLOAD_1 "https://github.com/alphayellow1/AlphaYellowWidescreenFixes/releases/download/diehardnakatomiplaza/Die.Hard.Nakatomi.Plaza.-.FOV.Fix.v1.4.1.rar" "Die.Hard.Nakatomi.Plaza.-.FOV.Fix.rar" ""
    !insertmacro 7Z_EXTRACT "Die.Hard.Nakatomi.Plaza.-.FOV.Fix.rar" ".\" "AUTO_DELETE"
SectionEnd

Section "dgVoodoo2 (fix multiple other issues)"
    AddSize 1311
    # dgVoodoo
    SetOutPath "$INSTDIR"
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D8.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3DImm.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\DDraw.dll" "AUTO_DELETE"

    # config
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 512" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Antialiasing                        = appdriven" "Antialiasing                        = 4x" 2 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "Resolution                          = unforced" "Resolution                          = desktop" 2 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "DisableAltEnterToToggleScreenMode   = true" "DisableAltEnterToToggleScreenMode   = false" 1 1 "$INSTDIR\dgVoodoo.conf"
SectionEnd

Section "Skip intro videos"
    !insertmacro FILE_STR_REPLACE "$\"nomovies$\" $\"0$\"" "$\"nomovies$\" $\"1$\"" 1 1 "$INSTDIR\autoexec.cfg"
SectionEnd

Section "[MOD] Die Hard Improved Edition v2 beta (by ReiKaz316)" mod
    AddSize 614400
    SetOutPath "$INSTDIR"

    DetailPrint " // Backup original files (non-mod)"
    CreateDirectory "$INSTDIR\backup"
    CopyFiles "$INSTDIR\Engine.rez" "$INSTDIR\backup\Engine.rez"
    CopyFiles "$INSTDIR\Nakatomi.rez" "$INSTDIR\backup\Nakatomi.rez"

    DetailPrint " // Downloading mod"
    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/4zrmpgfl5j8a6gm/DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z/file" \
                            "https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z" \
                            "DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z" "28ffcac1db43d7e7b1df6ff2cc5697a9fb7a95ca"
    !insertmacro NSIS7Z_EXTRACT "DIE_HARD_Improved_Edition_v2.0.0beta_REPACK.7z" ".\" "AUTO_DELETE"

    DetailPrint " // Applying xdelta patch"
    !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
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
        CreateDirectory "$INSTDIR\backup"
        CopyFiles "$INSTDIR\Nakatomi.rez" "$INSTDIR\backup\Nakatomi.rez"
        CopyFiles "$INSTDIR\Nakatomi2.rez" "$INSTDIR\backup\Nakatomi2.rez"

        DetailPrint " // Download french audio xdelta"
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/qee1r6m9urs88ej/french_audio_xdelta.7z/file" \
                                "https://cdn2.mulderload.eu/g/die-hard-nakatomi-plaza/french_audio_xdelta.7z" \
                                "french_audio_xdelta.7z" "50474270dc911a1b37ec974e259787cbe6b5297c"
        !insertmacro NSIS7Z_EXTRACT "french_audio_xdelta.7z" ".\" "AUTO_DELETE"

        DetailPrint " // Applying xdelta patches"
        !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
    SectionEnd
SectionGroupEnd

Section
    !insertmacro 7Z_REMOVE
    !insertmacro WISEUNPACKER_REMOVE
    !insertmacro XDELTA3_REMOVE
    RMDir "$INSTDIR\@mulderload"
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
