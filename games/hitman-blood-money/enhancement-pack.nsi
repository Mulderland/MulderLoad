!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Hitman: Blood Money, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- dxWrapper (by elishacloud)$\r$\n\
- Widescreen Fix (by nemesis2000)$\r$\n\
- DXVK (by doitsujin & others)$\r$\n\
- dgVoodoo2 (latest, or v2.81.3 if you're on Linux)$\r$\n\
- XInput controller support (by JerichoRex)$\r$\n\
- Blood Money Premastered v1.5 (by V01DXIX)$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to V01DXIX for his incredible textures pack, Blood Money Premastered!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show README"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"

Name "Hitman: Blood Money [Enhancement Pack]"

Section
    !insertmacro 7Z_GET
SectionEnd

Section "Widescreen fix (by nemesis2000) + Wrappers"
    AddSize 4389

    SetOutPath "$INSTDIR\scripts"

    # Install nemesis2000's Widescreen Fix
    !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/3534-hitman-blood-money-widescreen-fix-by-nemesis2000/" \
                            "h4widescreen.zip" \
                            "9c64eacc2c5f9ea0ec67b5ccedab887a223387f1"

    !insertmacro NSISUNZ_EXTRACT_ONE "h4widescreen.zip" ".\" "h4.ini" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "h4widescreen.zip" ".\" "h4w.dll" "AUTO_DELETE"

    # Configure nemesis2000's Widescreen Fix (default configuration without MulderConfig)
    !insertmacro FILE_STR_REPLACE "Width = 1280" "Width = 1920" 1 1 "$INSTDIR\scripts\h4.ini"
    !insertmacro FILE_STR_REPLACE "Height = 720" "Height = 1080" 1 1 "$INSTDIR\scripts\h4.ini"

    SetOutPath "$INSTDIR"

    # Copy Max Quality INI
    Delete "HitmanBloodMoney.ini"
    File resources\HitmanBloodMoney.ini

    # Install dgVoodoo2
    !insertmacro DOWNLOAD_DGVOODOO2
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodoo.conf" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "dgVoodooCpl.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dgVoodoo2.zip" ".\" "MS\x86\D3D9.dll" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "D3D9.dll" "d3d9_dgVoodoo2.dll"

    # Configure dgVoodoo2
    !insertmacro FILE_STR_REPLACE "FPSLimit                             = 0" "FPSLimit                             = 60" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "VRAM                                = 256" "VRAM                                = 2048" 1 1 "$INSTDIR\dgVoodoo.conf"
    !insertmacro FILE_STR_REPLACE "dgVoodooWatermark                   = true" "dgVoodooWatermark                   = false" 1 1 "$INSTDIR\dgVoodoo.conf"

    # Install DXVK
    !insertmacro DOWNLOAD_2 "https://github.com/doitsujin/dxvk/releases/download/v2.7.1/dxvk-2.7.1.tar.gz" \
                            "https://cdn.mulderload.eu/tools/dxvk/dxvk-2.7.1.tar.gz" \
                            "dxvk-2.7.1.tar.gz" \
                            "16e277f63aca1bb9d6b9ecf823dd0d7aab9b11be"

    !insertmacro 7Z_EXTRACT "dxvk-2.7.1.tar.gz" ".\" "AUTO_DELETE"
    !insertmacro 7Z_EXTRACT_ONE "dxvk-2.7.1.tar" ".\" "dxvk-2.7.1\x32\d3d9.dll" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "d3d9.dll" "d3d9_dxvk.dll"

    # Configure DXVK
    FileOpen $0 "$INSTDIR\dxvk.conf" w
    FileWrite $0 'd3d9.maxFrameRate = 60$\n'
    FileClose $0

    # Install dxWrapper
    !insertmacro DOWNLOAD_1 "https://github.com/elishacloud/dxwrapper/releases/latest/download/dxwrapper.zip" "dxwrapper.zip" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dxwrapper.zip" ".\" "dxwrapper.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dxwrapper.zip" ".\" "dxwrapper.ini" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dxwrapper.zip" ".\" "Stub\d3d9.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "dxwrapper.zip" ".\" "Stub\Stub.ini" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "Stub.ini" "d3d9.ini"

    # Configure dxWrapper
    !insertmacro FILE_STR_REPLACE "RealDllPath       = AUTO" "RealDllPath       = d3d9_dgVoodoo2.dll" 1 1 "$INSTDIR\d3d9.ini"
    !insertmacro FILE_STR_REPLACE "LoadCustomDllPath          = " "LoadCustomDllPath          = scripts\h4w.dll" 1 1 "$INSTDIR\dxwrapper.ini"
    !insertmacro FILE_STR_REPLACE "DisableLogging             = 0" "DisableLogging             = 1" 1 1 "$INSTDIR\dxwrapper.ini"
SectionEnd

Section "Add controller support (by JerichoRex)"
    SetOutPath "$INSTDIR\@mulderload"

    # https://www.nexusmods.com/hitmanbloodmoney/mods/36
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/hitman-blood-money/impr_control/Xinput Xbox controller support for hitmanBM-36-1-0-1711272817.zip" \
                            "Xinput Xbox controller support for hitmanBM-36-1-0-1711272817.zip" \
                            "7c14560e73b8bc231de4e4f354cc065deb2ca057"

    !insertmacro NSISUNZ_EXTRACT "Xinput Xbox controller support for hitmanBM-36-1-0-1711272817.zip" ".\" "AUTO_DELETE"
    Rename "Xinput Xbox controller  support for hitman blood money\Controller Support V10 For Gog release adds prompt buttons\Copy to install folder\Hitman.cfg" "Xinput Xbox controller  support for hitman blood money\Controller Support V10 For Gog release adds prompt buttons\Copy to install folder\Hitman_gamepad.cfg"
    !insertmacro FOLDER_MERGE "Xinput Xbox controller  support for hitman blood money\Controller Support V10 For Gog release adds prompt buttons\Copy to install folder" "$INSTDIR"
    RMDIr /r "$INSTDIR\@mulderload\Xinput Xbox controller  support for hitman blood money"

    # Get V10 exe (with 1.1 update)
    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/hitman-blood-money/impr_control/HitmanBloodMoney_XInput_v1.1.7z" \
                            "HitmanBloodMoney_XInput_v1.1.7z" \
                            "f90cf5e19dc7c8846e360fdd00106e1217a4584d"

    !insertmacro NSIS7Z_EXTRACT "HitmanBloodMoney_XInput_v1.1.7z" ".\" "AUTO_DELETE"
    Rename "HitmanBloodMoney.exe" "$INSTDIR\_HitmanBloodMoney_gamepad.exe.bak"
SectionEnd

Section "MulderConfig (latest)"
    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Section /o "Mission 8 Crash Fix (only for previous installations)" bmpremastered_fix
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/hitman-blood-money/impr_gfx/HBMPremastered - Mission 8 Crash Fix [MLD].7z" \
                            "HBMPremastered - Mission 8 Crash Fix [MLD].7z" \
                            "621dfc27f4d5250d93dae70c8fd766f124b0974c"

    !insertmacro NSIS7Z_EXTRACT "HBMPremastered - Mission 8 Crash Fix [MLD].7z" ".\" "AUTO_DELETE"
SectionEnd

Section /o "Upscaled Textures (HBM Premastered by V01DXIX)"
    AddSize 5038218
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/blood-money-premastered/addons/hbm-premaster-v15" \
                            "HBM_PREMASTER_V1.5.zip" \
                            "f02da72221a6cdec6e950d910423df5b"

    # Prevent M08_main.ZIP to be overwritten by HBM_PREMASTER
    !insertmacro FORCE_RENAME "$INSTDIR\Scenes\M08\M08_main.ZIP" "$INSTDIR\Scenes\M08\M08_main.ZIP.bak"

    !insertmacro 7Z_EXTRACT "HBM_PREMASTER_V1.5.zip" ".\" "AUTO_DELETE"
    !insertmacro FORCE_RENAME "README.txt" "README_PREMASTER.txt"
    Delete "HitmanLaaPatcher.exe"

    # Restore M08_main.ZIP (this fixes the crash on Mission 8: Death on the Mississipi)
    Delete "$INSTDIR\Scenes\M08\M08_main.ZIP"
    Rename "$INSTDIR\Scenes\M08\M08_main.ZIP.bak" "$INSTDIR\Scenes\M08\M08_main.ZIP"

    # NTCore 4GB Patch
    !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/tools/ntcore/4gb_patch.zip" \
                            "https://ntcore.com/files/4gb_patch.zip" \
                            "4gb_patch.zip" \
                            "c8b0d61937cb54fc8215124c0f737a1d29479c97"

    !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"
    ExecWait '4gb_patch.exe HitmanBloodMoney.exe' $0
    ExecWait '4gb_patch.exe _HitmanBloodMoney_gamepad.exe.bak' $0
    Delete "4gb_patch.exe"
SectionEnd

Section
    # Copy readme
    SetOutPath "$INSTDIR\@mulderload"
    File "resources\README.txt"

    # Create empty Hitman.cfg if it doesn't exist
    ${IfNot} ${FileExists} "$INSTDIR\Hitman.cfg"
        FileOpen $0 "$INSTDIR\Hitman.cfg" w
        FileClose $0
    ${EndIf}

    # Copy main executable (required for MulderConfig to allow controller switch)
    CopyFiles "$INSTDIR\HitmanBloodMoney.exe" "$INSTDIR\_HitmanBloodMoney_keyboard.exe.bak"

    !insertmacro 7Z_REMOVE
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "HitmanBloodMoney.exe"
    StrCpy $SELECT_INSTALL_PATH "C:\Program Files (x86)\GOG Galaxy\Games\Hitman Blood Money"
    StrCpy $SELECT_STEAM_FOLDER "Hitman Blood Money"
FunctionEnd

Function OnSelectedFile
    !insertmacro STACKFRAME_BEGIN 0 1
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Scenes\M08\M08_main.ZIP" "6a362d126608660481e4f33ad78be0ad1856b97f" $R0
    ${If} $R0 = "0"
        SectionSetFlags ${bmpremastered_fix} ${SF_RO}
    ${Else}
        SectionSetFlags ${bmpremastered_fix} ${SF_SELECTED}|${SF_RO}
    ${EndIf}
    !insertmacro STACKFRAME_RETURN 0 1 1
    !insertmacro STACKFRAME_END 0 1
FunctionEnd
