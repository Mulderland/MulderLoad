!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download an (opinionated) compilation of patches for the game, while keeping a 'vanilla experience'.$\r$\n$\r$\nIt includes:$\r$\n- Kentie's Launcher$\r$\n- Kentie's D3D renderer$\r$\n- HD Textures from New Vision v1.5$\r$\n- (optionally) French Patch from DXM$\r$\n$\r$\nA big thanks to Kentie, DXM, and the New Vision project!"
!include "..\..\templates\select_exe.nsh"
RequestExecutionLevel admin

Name "Deus Ex [PATCHS]"

Section "Kentie's Launcher (Deus Exe) v8.1"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://kentie.net/article/dxguide/files/DeusExe-v8.1.zip "DeusExe.zip"
    nsisunz::Unzip "DeusExe.zip" "System\"
    Delete "DeusExe.zip"

    # Latest Visual C++ 2015-2022 Redistribuable
    !insertmacro Download https://aka.ms/vs/17/release/vc_redist.x86.exe "vc_redist.x86.exe"
    ExecWait '"vc_redist.x86.exe" /install /quiet /norestart' $0
    Delete "vc_redist.x86.exe"
SectionEnd

Section "Kentie's D3D10 renderer v29"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://kentie.net/article/d3d10drv/files/d3d10drv-v29.zip "d3d10drv.zip"
    nsisunz::Unzip "d3d10drv.zip" "d3d10drv.tmp"
    Delete "d3d10drv.zip"
    Rename "d3d10drv.tmp\DeusEx\d3d10drv" "System\d3d10drv"
    Rename "d3d10drv.tmp\DeusEx\d3d10drv.dll" "System\d3d10drv.dll"
    Rename "d3d10drv.tmp\DeusEx\D3D10Drv.int" "System\D3D10Drv.int"
    RMDir /r "$INSTDIR\d3d10drv.tmp"

    # Latest Visual C++ 2010 Redistribuable
    !insertmacro Download https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe "vcredist_x86.exe"
    ExecWait '"vcredist_x86.exe" /install /quiet /norestart' $0
    Delete "vcredist_x86.exe"

    # DirectX End-User Runtime Web Installer
    !insertmacro Download https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe "dxwebsetup.exe"
    ExecWait '"dxwebsetup.exe" /Q' $0
    Delete "dxwebsetup.exe"
SectionEnd

Section "Textures - New Vision v1.5"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/xlu2enxf0twqzb9/New_Vision_v1-5_Textures_Only.7z/file "New_Vision_v1-5_Textures_Only.7z"
    Nsis7z::ExtractWithDetails "New_Vision_v1-5_Textures_Only.7z" "Installing package %s..."
    Delete "New_Vision_v1-5_Textures_Only.7z"
SectionEnd

Section /o "DXM's Patch FR v1.8b7 (French Subtitles)"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.dxm.be/host/files/DeusEx_FrenchPatch18b7.exe "DeusEx_FrenchPatch.exe"
    ExecWait '"DeusEx_FrenchPatch.exe"' $0
    Delete "DeusEx_FrenchPatch.exe"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DeusEx.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Deus Ex\System"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
