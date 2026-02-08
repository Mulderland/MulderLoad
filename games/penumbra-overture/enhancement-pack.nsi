!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nIt includes:$\r$\n- Better default resolution$\r$\n- Upscaled Textures$\r$\n- (optionally) a french patch$\r$\n$\r$\nA big thanks to the Penumbra: Quality Of Life Project for their textures !"
!include "..\..\templates\select_exe.nsh"

Name "Penumbra: Overture [PATCHS]"

SectionGroup /e "Graphical improvements"
    Section "Set default res to 1920x1080 instead of 800x600"
        SectionIn RO
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/pbaakxzy5tm0cdl/default_settings_1080p_us.cfg/file "config\default_settings.cfg"
        Delete "$PROFILE\Documents\Penumbra Overture\Episode1\settings.cfg"
    SectionEnd

    Section "Texture Upscale Mod v1.1.1"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/bgsor1jqxtpcwhh/Overture-Mod-1.1.1.7z/file "Overture-Mod-1.1.1.7z"
        Nsis7z::ExtractWithDetails "Overture-Mod-1.1.1.7z" "Installing package %s..."
        Delete "Overture-Mod-1.1.1.7z"
    SectionEnd
SectionGroupEnd

Section /o "Patch FR (French Subtitles)"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/dbi3hgrbyubsn0v/Francais.lang/file "config\Francais.lang"
    !insertmacro Download https://www.mediafire.com/file_premium/i9nwzs04iam1muk/default_settings_1080p_fr.cfg/file "config\default_settings.cfg"
    Delete "$PROFILE\Documents\Penumbra Overture\Episode1\settings.cfg"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Penumbra.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Penumbra Overture\redist"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
