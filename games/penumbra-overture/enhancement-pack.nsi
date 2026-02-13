!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Penumbra: Overture, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Better default resolution$\r$\n\
- Upscaled Textures$\r$\n\
- (optionally) a french patch$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the Penumbra: Quality Of Life project for their textures !"

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Penumbra: Overture [Enhancement Pack]"

SectionGroup /e "Graphical improvements"
    Section "Set default res to 1920x1080 instead of 800x600"
        SetOutPath "$INSTDIR"

        File /oname=config\default_settings.cfg resources\default_settings_1080p.cfg
        Delete "$PROFILE\Documents\Penumbra Overture\Episode1\settings.cfg"
    SectionEnd

    Section "Texture Upscale Mod v1.1.1"
        AddSize 1918894
        SetOutPath "$INSTDIR"

        # https://www.moddb.com/mods/penumbra-qol-project/downloads/penumbra-overture-texture-upscale-mod
        !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/190144" \
                                "https://cdn2.mulderload.eu/g/penumbra-overture/Overture-Mod-1.1.1.7z" \
                                "Overture-Mod-1.1.1.7z" "77f89f7dd02e55aaab122d5c6155831a"

        !insertmacro NSIS7Z_EXTRACT "Overture-Mod-1.1.1.7z" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Section /o "Patch FR (French Subtitles)"
    AddSize 179
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/dbi3hgrbyubsn0v/Francais.lang/file" \
                            "https://cdn2.mulderload.eu/g/penumbra-overture/Francais.lang" \
                            "config\Francais.lang" "56d3d67fc4ce2fe556bae585aa37bef2fe7925c0"

    !insertmacro FILE_STR_REPLACE "English.lang" "Francais.lang" 1 1 "config\default_settings.cfg"
    !insertmacro FILE_STR_REPLACE "English.lang" "Francais.lang" 1 1 "$PROFILE\Documents\Penumbra Overture\Episode1\settings.cfg"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Penumbra.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Penumbra Overture\redist"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
