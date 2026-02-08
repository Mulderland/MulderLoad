!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download VCNE v1.1 from Archive.org servers$\r$\n- run the setup$\r$\n- (optionally) download and extract v1.2 update$\r$\n- (optionally) download patches$\r$\n- (optionally) download redistribuables$\r$\n$\r$\nA big thanks RevTeam, the group behind this beauty!$\r$\n$\r$\nWARNING: if you already have a save on v1.1, don't install v1.2 because saves are incompatible."
!include "..\..\templates\standard.nsh"
RequestExecutionLevel admin

Name "GTA Vice City - Next Gen Edition"
InstallDir "C:\MulderLoad\GTA Vice City - Next Gen Edition"

SectionGroup /e "GTA Vice City - Next Gen Edition v1.1"
    Section
        SetOutPath $INSTDIR

        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup.exe "vcNE_setup.exe"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-1.bin "vcNE_setup-1.bin"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-2.bin "vcNE_setup-2.bin"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-3.bin "vcNE_setup-3.bin"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-4.bin "vcNE_setup-4.bin"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-5.bin "vcNE_setup-5.bin"
        !insertmacro Download https://archive.org/download/vice_city_nextgen_edition/vcNE_setup-6.bin "vcNE_setup-6.bin"
        ExecWait '"vcNE_setup.exe" /DIR="$INSTDIR" /SILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $0
        Delete "vcNE_setup.exe"
        Delete "vcNE_setup-1.bin"
        Delete "vcNE_setup-2.bin"
        Delete "vcNE_setup-3.bin"
        Delete "vcNE_setup-4.bin"
        Delete "vcNE_setup-5.bin"
        Delete "vcNE_setup-6.bin"
    SectionEnd

    Section "v1.2 Update"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/5ruoansgdqly6xp/vcNE_Patch_v1.2.7z/file "vcNE_Patch_v1.2.7z"
        Nsis7z::ExtractWithDetails "vcNE_Patch_v1.2.7z" "Installing package %s..."
        Delete "vcNE_Patch_v1.2.7z"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Patches"
    Section "Fix loading screen + slow textures"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/xsynqmgk6or2r7u/commandline.txt/file "commandline.txt"
    SectionEnd

    Section "Vehicles Patch"
        SetOutPath $INSTDIR

        !insertmacro Download https://nextgen.limited/download/VC_NE_Vehicles_Patch.7z "VC_NE_Vehicles_Patch.7z"
        Nsis7z::ExtractWithDetails "VC_NE_Vehicles_Patch.7z" "Installing package %s..."
        Delete "VC_NE_Vehicles_Patch.7z"

        Rename "VC NE Vehicles Patch\vehicles.img" "pc\models\cdimages\vehicles.img"
        Rename "VC NE Vehicles Patch\handling.dat" "common\data\handling.dat"
        Rename "VC NE Vehicles Patch\vehicles.ide" "common\data\vehicles.ide"
        Rename "VC NE Vehicles Patch\WeaponInfo.xml" "common\data\WeaponInfo.xml"
        RMDir "VC NE Vehicles Patch"
    SectionEnd
SectionGroupEnd

SectionGroup /e "Redistribuables"
    Section "Direct-X Web Installer"
        !insertmacro Download https://download.microsoft.com/download/1/7/1/1718ccc4-6315-4d8e-9543-8e28a4e18c4c/dxwebsetup.exe "dxwebsetup.exe"
        ExecWait '"dxwebsetup.exe" /Q' $0
        Delete "dxwebsetup.exe"
    SectionEnd

    Section "Microsoft Visual C++ 2005 SP1 x86"
        !insertmacro Download https://download.microsoft.com/download/6/b/b/6bb661d6-a8ae-4819-b79f-236472f6070c/vcredist_x86.exe "vcredist_x86.exe"
        ExecWait '"vcredist_x86.exe" /Q' $0
        Delete "vcredist_x86.exe"
    SectionEnd
SectionGroupEnd
