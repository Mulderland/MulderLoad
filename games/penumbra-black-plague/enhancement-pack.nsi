!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Penumbra: Black Plague, aiming to provide a modern vanilla experience. It includes:$\r$\n\
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
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Penumbra: Black Plague [Enhancement Pack]"

Section "Max Quality CFG"
    SetOutPath "$INSTDIR\redist\config"
    File resources\default_settings.cfg

    SetOutPath "$INSTDIR\redist\expansion01\config"
    File resources\requiem_default_settings.cfg

    MessageBox MB_YESNO|MB_DEFBUTTON1 "Delete existing settings?$\r$\n$\r$\nIt is recommended to ensure max quality settings are applied." IDYES settings_delete IDNO settings_keep
    settings_delete:
        Delete "$PROFILE\Documents\Penumbra\Black Plague\settings.cfg"
        Delete "$PROFILE\Documents\Penumbra\Requiem\settings.cfg"
    settings_keep:
SectionEnd

SectionGroup /e "Quality of Life Project (by sk8er_boi6000)"
    Section "Black Plague Upscaled Textures (and more) v1.3.1"
        SetOutPath "$INSTDIR\redist"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/penumbra-qol-project/downloads/penumbra-black-plague-texture-upscale-mod" \
                                "BlackPlague-QOL-1.3.1.7z" \
                                "7acb3721d40e8479e516168d61c1835d"

        !insertmacro NSIS7Z_EXTRACT "BlackPlague-QOL-1.3.1.7z" ".\" "AUTO_DELETE"
        AddSize 2548040
    SectionEnd

    Section "Requiem Upscaled Textures (and more) v1.1" requiem_textures
        SetOutPath "$INSTDIR\redist\expansion01"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/penumbra-requiem-texture-upscale-mod/downloads/penumbra-requiem-texture-upscale-mod" \
                                "Requiem-US-1.1.7z" \
                                "48da476c1275e993c34a084444908ed6"

        !insertmacro NSIS7Z_EXTRACT "Requiem-US-1.1.7z" ".\" "AUTO_DELETE"
        AddSize 1193861
    SectionEnd
SectionGroupEnd

Section "MulderConfig (latest)"
    SetOutPath "$INSTDIR\@mulderland"
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/penumbra-black-plague/base/Penumbra_GOG_LAA.7z" \
                            "Penumbra_GOG_LAA.7z" \
                            "3b1f52d883e7e7148aabe078c60ee53f836bc46d"

    !insertmacro NSIS7Z_EXTRACT "Penumbra_GOG_LAA.7z" ".\" "AUTO_DELETE"
    AddSize 5844

    SetOutPath "$INSTDIR\redist\config"
    !insertmacro FORCE_RENAME "Francais.lang" "Francais.lang.bak"
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/penumbra-black-plague/translation/Francais.lang" \
                            "Francais.lang" \
                            "37a1a45bec751e53acf34367112e046d4ce61fff"
    AddSize 192

    SetOutPath "$INSTDIR\redist\expansion01\config"
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/penumbra-black-plague/translation/Francais_exp.lang" \
                            "Francais_exp.lang" \
                            "51518d9d1b1cb6434b2b64a19247f2cf909651a2"
    AddSize 61

    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "Penumbra.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Penumbra - Black Plague"
    StrCpy $SELECT_RELATIVE_PATH "redist"
    StrCpy $SELECT_STEAM_FOLDER "Penumbra Black Plague"
FunctionEnd

Function OnSelectedFile
    ${IfNot} ${FileExists} "$INSTDIR\redist\expansion01\maps\requiem_global_script.hps"
        SectionSetFlags ${requiem_textures} ${SF_RO}
        MessageBox MB_ICONINFORMATION "The Requiem expansion is not installed.$\r$\n$\r$\nThe Requiem texture pack will not be downloadable.$\r$\n$\r$\nIf you own it on GOG, download it and retry."
    ${Else}
        SectionSetFlags ${requiem_textures} ${SF_SELECTED}
    ${EndIf}
FunctionEnd
