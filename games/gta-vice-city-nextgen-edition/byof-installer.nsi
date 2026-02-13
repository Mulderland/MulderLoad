!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the fan-game setup. You must provide your own backup of $\"vcNE_setup$\" made by REVOLUTION TEAM.$\r$\n\
$\r$\n\
This installer can:$\r$\n\
- verify the integrity of your vcNE_setup.exe$\r$\n\
- extract it (bypassing InnoSetup && the admin requirement)$\r$\n\
- install the unofficial Patch v1.2 (with or without FusionFix)$\r$\n\
- install the vehicles Patch$\r$\n\
- fix the loading screen && slow textures$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
Congrats to REVOLUTION TEAM for this great fan-remake!$\r$\n\
Grand Theft Auto is a trademark of Rockstar Games. This project is not affiliated with or endorsed by Rockstar Games or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\InnoExtract.nsh"

Name "GTA Vice City NextGen Edition"
InstallDir "C:\MulderLoad\GTA Vice City NextGen Edition"

!insertmacro BYOF_DEFINE "SETUP" "vcNE_setup file|vcNE_setup.exe" "60e8e1fb3aeaa5565280fe1a983437292187ecb4"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "GTA Vice City NextGen Edition v1.2 (Full Install)"
    AddSize 8860468
    SetOutPath "$INSTDIR"

    !insertmacro INNOEXTRACT_GET
    !insertmacro INNOEXTRACT_UNPACK "$byofPath_SETUP" "$INSTDIR" ""
    !insertmacro INNOEXTRACT_REMOVE

    !insertmacro DOWNLOAD_2 "https://nextgen.limited/download/Patch_V1.2.7z" \
                            "https://cdn2.mulderload.eu/g/gta-vice-city-nextgen-edition/Patch_V1.2.7z" \
                            "Patch_V1.2.7z" "065e75abca5ce3e7e6c54c85bb2ad62f1b41d36f"

    !insertmacro NSIS7Z_EXTRACT "Patch_V1.2.7z" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\vcNE Patch v1.2" "$INSTDIR"
SectionEnd

SectionGroup /e "Additional Patches"
    Section /o "Enable FusionFix"
        !insertmacro FOLDER_MERGE "$INSTDIR\FusionFix" "$INSTDIR"
    SectionEnd

    Section "Fix loading screen + slow textures"
        AddSize 1
        SetOutPath "$INSTDIR"
        File "resources\commandline.txt"
    SectionEnd

    Section "Vehicles Patch"
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_2 "https://nextgen.limited/download/VC_NE_Vehicles_Patch.7z" \
                                "https://cdn2.mulderload.eu/g/gta-vice-city-nextgen-edition/VC_NE_Vehicles_Patch.7z" \
                                "VC_NE_Vehicles_Patch.7z" "bae6118387184f64723d1616e000f84bc9a7024e"

        !insertmacro NSIS7Z_EXTRACT "VC_NE_Vehicles_Patch.7z" ".\" "AUTO_DELETE"
        !insertmacro FORCE_RENAME "pc\models\cdimages\vehicles.img" "pc\models\cdimages\vehicles.img.bak"
        Rename "VC NE Vehicles Patch\vehicles.img" "pc\models\cdimages\vehicles.img"
        !insertmacro FOLDER_MERGE "$INSTDIR\VC NE Vehicles Patch" "$INSTDIR\common\data"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Redistribuables"
    Section "Direct-X Web Installer"
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/7/1/1718ccc4-6315-4d8e-9543-8e28a4e18c4c/dxwebsetup.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/dxwebsetup.exe" \
                                "dxwebsetup.exe" "7bf35f2afca666078db35ca95130beb2e3782212"
        ExecWait '"dxwebsetup.exe" /Q' $0
        Delete "dxwebsetup.exe"
    SectionEnd

    Section "Microsoft Visual C++ 2005 SP1 x86"
        SetOutPath "$INSTDIR"
        !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/6/b/b/6bb661d6-a8ae-4819-b79f-236472f6070c/vcredist_x86.exe" \
                                "https://cdn2.mulderload.eu/g/_redist/2005sp1/vcredist_x86.exe" \
                                "vcredist_x86.exe" "d5d7cc096308a7366383cdd103854ffe91b84739"
        ExecWait '"vcredist_x86.exe" /Q' $0
        Delete "vcredist_x86.exe"
    SectionEnd
SectionGroupEnd
