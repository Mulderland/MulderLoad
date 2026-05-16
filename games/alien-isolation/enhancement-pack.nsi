!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Alien Isolation, which can$\r$\n\
- enhance anti-aliasing quality (with $\"Alias Isolation$\")$\r$\n\
- enhance the graphics menu options (by BUR7N)$\r$\n\
- disable lens flare$\r$\n\
- skip intro videos$\r$\n\
- install a mod to skip the save confirmation dialog (by ThirteenAG)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Alien: Isolation [Enhancement Pack]"

SectionGroup /e "Graphical improvements"
    Section "Better Anti-Aliasing (TAA) - 'Alias Isolation'"
        AddSize 2427
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://github.com/aliasIsolation/aliasIsolation/releases/download/v1.2.0/AliasIsolation-v1.2.0.7z" \
                                "https://cdn1.mulderload.eu/games/alien-isolation/AliasIsolation-v1.2.0.7z" \
                                "AliasIsolation.7z" "1ca067b0e60531223746e1bda88fd38e7d2091b4"
        !insertmacro NSIS7Z_EXTRACT "AliasIsolation.7z" ".\" "AUTO_DELETE"

        MessageBox MB_ICONINFORMATION "For TAA mod to work properly, you will need to set this settings ingame :\
                                        $\r$\nAnti-Aliasing = SMAA T1x\
                                        $\r$\nChromatic Aberration = Disabled\
                                        $\r$\nMotion Blur = Enabled"
    SectionEnd

    Section "Enhanced graphics menu options"
        AddSize 24
        SetOutPath "$INSTDIR\DATA"

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alienisolation/mods/34?tab=files&file_id=123" \
                                "Enhanced_Graphics_Alternate.rar" "2ff3a3f45aa1ab780765a30b343427ce22375b21"

        !insertmacro 7Z_GET
        !insertmacro 7Z_EXTRACT "Enhanced_Graphics_Alternate.rar" ".\" "AUTO_DELETE"
        !insertmacro 7Z_REMOVE
    SectionEnd

    Section /o "Disable Lens flare"
        Rename "$INSTDIR\DATA\LENS_FLARE_ATLAS.BIN" "$INSTDIR\DATA\LENS_FLARE_ATLAS.BIN.bak"
        Rename "$INSTDIR\DATA\LENS_FLARE_CONFIG.BIN" "$INSTDIR\DATA\LENS_FLARE_CONFIG.BIN.bak"
    SectionEnd
SectionGroupEnd

Section /o "Skip intro videos"
    Rename "$INSTDIR\DATA\UI\MOVIES\AMD_IDENT.USM" "$INSTDIR\DATA\UI\MOVIES\AMD_IDENT.USM.bak"
    Rename "$INSTDIR\DATA\UI\MOVIES\CA_IDENT.USM" "$INSTDIR\DATA\UI\MOVIES\CA_IDENT.USM.bak"
    Rename "$INSTDIR\DATA\UI\MOVIES\FOX_IDENT.USM" "$INSTDIR\DATA\UI\MOVIES\FOX_IDENT.USM.bak"
SectionEnd

Section /o "[Mod] Skip save confirmation dialog"
    AddSize 2382
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/ThirteenAG/AlienIsolation.SkipSaveConfirmationDialog/releases/latest/download/AlienIsolation.SkipSaveConfirmationDialog.zip" \
                            "https://cdn1.mulderload.eu/games/alien-isolation/AlienIsolation.SkipSaveConfirmationDialog.zip"  \
                            "SkipSaveConfirmationDialog.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "SkipSaveConfirmationDialog.zip" ".\" "AlienIsolation.SkipSaveConfirmationDialog.asi" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "SkipSaveConfirmationDialog.zip" ".\" "winmm.dll" "AUTO_DELETE"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "AI.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Alien Isolation"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
