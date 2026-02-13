!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Deus Ex 1, aiming to provide a modern vanilla experience. It includes:$\r$\n\
- Kentie's Launcher (Deus Exe) v8.1$\r$\n\
- Kentie's D3D renderer v29$\r$\n\
- HD Textures from New Vision v1.5$\r$\n\
- (optionally) French Patch from DXM$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to Kentie, DXM, and the New Vision project!"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
RequestExecutionLevel admin

Name "Deus Ex [Enhancement Pack]"

Section "Kentie's Launcher (Deus Exe) v8.1"
    SectionIn RO
    AddSize 398 ; not counting redistribuable
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://kentie.net/article/dxguide/files/DeusExe-v8.1.zip" \
                            "https://cdn2.mulderload.eu/g/deus-ex/DeusExe-v8.1.zip" \
                            "DeusExe.zip" "57838689dc9ce652c0da0a75fa3f42867122f3b8"
    !insertmacro NSISUNZ_EXTRACT "DeusExe.zip" "System\" "AUTO_DELETE"

    # Latest Visual C++ 2015-2022 Redistribuable
    !insertmacro DOWNLOAD_2 "https://aka.ms/vs/17/release/vc_redist.x86.exe" \
                            "https://cdn2.mulderload.eu/g/_redist/VC_redist.x86.exe" \
                            "vc_redist.x86.exe" "c2743ffc36d2af40ade0e370be52d6b202874114"
    ExecWait '"vc_redist.x86.exe" /install /quiet /norestart' $0
    Delete "vc_redist.x86.exe"
SectionEnd

Section "Kentie's D3D10 renderer v29"
    AddSize 96 ; not counting redistribuables
    SectionIn RO
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://kentie.net/article/d3d10drv/files/d3d10drv-v29.zip" \
                            "https://cdn2.mulderload.eu/g/deus-ex/d3d10drv-v29.zip" \
                            "d3d10drv.zip" "07bf26fe348116830c5c86326bb112b74519b0d4"
    !insertmacro NSISUNZ_EXTRACT "d3d10drv.zip" "$INSTDIR\@mulderload\d3d10drv" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\d3d10drv\DeusEx" "$INSTDIR\System"
    RMDIR /r "$INSTDIR\@mulderload\d3d10drv"

    # Latest Visual C++ 2010 Redistribuable
    !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe" \
                            "https://cdn2.mulderload.eu/g/_redist/2010/vcredist_x86.exe" \
                            "vcredist_x86.exe" "2222fc008e469fec77d0d291877f357c6e1eb16d"
    ExecWait '"vcredist_x86.exe" /install /quiet /norestart' $0
    Delete "vcredist_x86.exe"

    # DirectX End-User Runtime Web Installer
    !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe" \
                            "https://cdn2.mulderload.eu/g/_redist/dxwebsetup.exe" \
                            "dxwebsetup.exe" "7bf35f2afca666078db35ca95130beb2e3782212"
    ExecWait '"dxwebsetup.exe" /Q' $0
    Delete "dxwebsetup.exe"
SectionEnd

Section "Textures Pack (from New Vision v1.5)"
    AddSize 2852127
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.moddb.com/downloads/start/48510" \
                            "https://cdn2.mulderload.eu/g/deus-ex/New_Vision_v1-5.exe" \
                            "New_Vision_v1-5.exe" "31eb1ead889a8c1230906d833e644403"

    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT_ONE "New_Vision_v1-5.exe" "$INSTDIR\@mulderload\NewVision" "New Vision\Maps\Maps.7z"  ""
    !insertmacro 7Z_EXTRACT_ONE "New_Vision_v1-5.exe" "$INSTDIR\@mulderload\NewVision" "New Vision\Textures\Textures.7z" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE

    !insertmacro NSIS7Z_EXTRACT "$INSTDIR\@mulderload\NewVision\Maps.7z" "$INSTDIR\Maps" "AUTO_DELETE"
    !insertmacro NSIS7Z_EXTRACT "$INSTDIR\@mulderload\NewVision\Textures.7z" "$INSTDIR\Textures" "AUTO_DELETE"
SectionEnd

Section /o "DXM's Patch FR v1.8b7 (French Subtitles)"
    AddSize 26624
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://www.dxm.be/host/files/DeusEx_FrenchPatch18b7.exe" \
                            "https://cdn2.mulderload.eu/g/deus-ex/DeusEx_FrenchPatch18b7.exe" \
                            "DeusEx_FrenchPatch18b7.exe" "3769f35d20f2705d4c2a347e6c8db1a5c8033ae1"

    ExecWait '"DeusEx_FrenchPatch18b7.exe"' $0
    Delete "DeusEx_FrenchPatch18b7.exe"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "DeusEx.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Deus Ex\System"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
