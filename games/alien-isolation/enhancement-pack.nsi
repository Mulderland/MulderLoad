!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nA big thanks to$\r$\n- the aliasIsolation project$\r$\n- BUR7N for his 'Enhanced Graphics' mod$\r$\n- ThirteenAG for his SkipSaveConfirmationDialog mod"
!include "..\..\templates\select_exe.nsh"

Name "Alien: Isolation [PATCHS]"

SectionGroup /e "Graphical improvements"
    Section "Better Anti-Aliasing (TAA) - 'Alias Isolation'"
        SetOutPath $INSTDIR

        !insertmacro Download https://github.com/aliasIsolation/aliasIsolation/releases/download/v1.2.0/AliasIsolation-v1.2.0.7z "AliasIsolation.7z"
        Nsis7z::ExtractWithDetails "AliasIsolation.7z" "Installing package %s..."
        Delete "AliasIsolation.7z"

        MessageBox MB_ICONINFORMATION "For TAA mod to work properly, you will need to set this settings ingame :\
                                        $\r$\nAnti-Aliasing = SMAA T1x\
                                        $\r$\nChromatic Aberration = Disabled\
                                        $\r$\nMotion Blur = Enabled"
    SectionEnd

    Section "Enhanced graphics menu options"
        SetOutPath $INSTDIR\DATA

        !insertmacro Download https://www.mediafire.com/file_premium/n9zmcrl6f5fwv32/Enhanced_Graphics_Alternate-34-1-2-1-1670611572.7z/file "Enhanced_Graphics.7z"
        Nsis7z::ExtractWithDetails "Enhanced_Graphics.7z" "Installing package %s..."
        Delete "Enhanced_Graphics.7z"
    SectionEnd

    Section /o "Disable Lens flare"
        SetOutPath $INSTDIR\DATA

        Rename "LENS_FLARE_ATLAS.BIN" "LENS_FLARE_ATLAS.BIN.bak"
        Rename "LENS_FLARE_CONFIG.BIN" "LENS_FLARE_CONFIG.BIN.bak"
    SectionEnd
SectionGroupEnd

Section /o "Skip intro videos"
    SetOutPath $INSTDIR\DATA\UI\MOVIES

    Rename "AMD_IDENT.USM" "AMD_IDENT.USM.bak"
    Rename "CA_IDENT.USM" "CA_IDENT.USM.bak"
    Rename "FOX_IDENT.USM" "FOX_IDENT.USM.bak"
SectionEnd

Section /o "Skip save confirmation dialog"
    SetOutPath $INSTDIR

    !insertmacro Download https://github.com/ThirteenAG/AlienIsolation.SkipSaveConfirmationDialog/releases/latest/download/AlienIsolation.SkipSaveConfirmationDialog.zip "SkipSaveConfirmationDialog.zip"
    nsisunz::Unzip /noextractpath /file "AlienIsolation.SkipSaveConfirmationDialog.asi" "SkipSaveConfirmationDialog.zip" ".\"
    nsisunz::Unzip /noextractpath /file "winmm.dll" "SkipSaveConfirmationDialog.zip" ".\"
    Delete "SkipSaveConfirmationDialog.zip"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "AI.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Alien Isolation"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
