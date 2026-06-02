!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Penumbra: Overture, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Max Quality CFG$\r$\n\
- Upscaled Textures from the Penumbra: Quality Of Life project (by sk8er_boi6000)$\r$\n\
- 4GB Patched GOG Executable (by NTCore)$\r$\n\
- MulderConfig to allow resolution and FOV modifications, optional french patch and other tweaks.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to sk8er_boi6000 for his Quality of Life project!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Penumbra: Overture [Enhancement Pack]"

Section "Max Quality CFG"
    SetOutPath "$INSTDIR\redist\config"
    File resources\default_settings.cfg

    MessageBox MB_YESNO|MB_DEFBUTTON1 "Delete existing settings?$\r$\n$\r$\nIt is recommended to ensure max quality settings are applied." IDYES settings_delete IDNO settings_keep
    settings_delete:
        Delete "$PROFILE\Documents\Penumbra Overture\Episode1\settings.cfg"
    settings_keep:
SectionEnd

Section "Upscaled Textures v1.1.1 (QoL Project by sk8er_boi6000)"
    SetOutPath "$INSTDIR\redist"

    # https://www.moddb.com/mods/penumbra-qol-project/downloads/penumbra-overture-texture-upscale-mod
    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/190144" \
                            "https://cdn1.mulderload.eu/games/penumbra-overture/Overture-Mod-1.1.1.7z" \
                            "Overture-Mod-1.1.1.7z" "77f89f7dd02e55aaab122d5c6155831a"
    !insertmacro NSIS7Z_EXTRACT "Overture-Mod-1.1.1.7z" ".\" "AUTO_DELETE"
    AddSize 1825014
SectionEnd

Section "MulderConfig (latest)"
    SetOutPath "$INSTDIR\@mulderland"
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/penumbra-overture/Penumbra_GOG_LAA.7z" \
                            "https://www.mediafire.com/file_premium/z5qzhp4sr14q1ha/Penumbra_GOG_LAA.7z/file" \
                            "Penumbra_GOG_LAA.7z" "845b3f4d3631b81691b85d8494cf6acfc718c883"
    !insertmacro NSIS7Z_EXTRACT "Penumbra_GOG_LAA.7z" ".\" "AUTO_DELETE"
    AddSize 2680

    SetOutPath "$INSTDIR\redist\config"
    !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/penumbra-overture/Francais.lang" \
                            "https://www.mediafire.com/file_premium/dbi3hgrbyubsn0v/Francais.lang/file" \
                            "Francais.lang" "56d3d67fc4ce2fe556bae585aa37bef2fe7925c0"
    AddSize 179

    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Penumbra.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Penumbra Overture\redist"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
