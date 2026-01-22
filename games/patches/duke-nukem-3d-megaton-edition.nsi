!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer includes$\r$\n- eduke32 (x64) for improved rendering$\r$\n- High Resolution Packs (including nwinter/vacation)$\r$\n- AI Upscaled Textures$\r$\n- MulderConfig for game/addons configurations$\r$\n$\r$\nEnjoy and chew bubble gum !"
!define MUI_FINISHPAGE_RUN "$INSTDIR\bin\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!include "..\..\templates\select_exe.nsh"

Name "Duke Nukem 3D: Megaton Edition [PATCHS]"

Section "eDuke32 (x64)"
    SectionIn RO
    SetOutPath $INSTDIR\eduke32
    AddSize 4000  # compressed (temporary)
    AddSize 19000 # decompressed

    !insertmacro Download https://dukeworld.com/eduke32/synthesis/20251111-10652-39967d866/eduke32_win64_20251111-10652-39967d866.7z "eduke32.7z"
    Nsis7z::ExtractWithDetails "eduke32.7z" "Installing package %s..."
    Delete "eduke32.7z"
SectionEnd

SectionGroup /e "HD Textures" fov
    Section "HRPs (High Resolution Packs)"
        AddSize 1111490
        SetOutPath $INSTDIR\gameroot
        !insertmacro Download http://www.duke4.org/files/nightfright/hrp/duke3d_hrp.zip "duke3d_hrp.zip"
        !insertmacro Download https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/duke3d_megaton_hrp_override_custom.zip "duke3d_megaton_hrp_override_custom.zip"
        !insertmacro Download http://www.duke4.org/files/nightfright/related/dukedc_hrp.zip "dukedc_hrp.zip"
        !insertmacro Download https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/nwinter_hrp.zip "nwinter_hrp.zip"
        !insertmacro Download https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/vacation_hrp.zip "vacation_hrp.zip"
        !insertmacro Download https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/classic_monsters.zip "classic_monsters.zip"
        !insertmacro Download https://cdn2.mulderload.eu/g/duke-nukem-3d-megaton-edition/classic_weapons.zip "classic_weapons.zip"
    SectionEnd

    Section "AI Upscale v1.3"
        AddSize 103140
        SetOutPath $INSTDIR\gameroot
        !insertmacro DownloadRedirect https://redirect.mulderload.eu/moddb/204547 "dukeupscale.zip"
    SectionEnd
SectionGroupEnd

SectionGroup /e "MulderConfig (latest)"
    Section
        SectionIn RO
        AddSize 1024
        SetOutPath $INSTDIR\bin
        !insertmacro Download https://github.com/mulderload/MulderConfig/releases/latest/download/MulderConfig.exe "MulderConfig.exe"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/duke-nukem-3d-megaton-edition/MulderConfig.json "MulderConfig.json"
        !insertmacro Download https://raw.githubusercontent.com/mulderload/recipes/refs/heads/main/resources/duke-nukem-3d-megaton-edition/MulderConfig.save.json "MulderConfig.save.json"
        ExecWait '"$INSTDIR\bin\MulderConfig.exe" -apply' $0
    SectionEnd

    Section /o "Microsoft .NET Desktop Runtime 8.0.22 (x64)"
        SetOutPath $INSTDIR
        AddSize 61000  # compressed (temporary)
        AddSize 100000 # decompressed

        !insertmacro Download https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/8.0.22/windowsdesktop-runtime-8.0.22-win-x64.exe "windowsdesktop-runtime-win-x64.exe"
        ExecWait '"windowsdesktop-runtime-win-x64.exe" /Q' $0
        Delete "windowsdesktop-runtime-win-x64.exe"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "duke3d.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Duke Nukem 3D\bin"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
