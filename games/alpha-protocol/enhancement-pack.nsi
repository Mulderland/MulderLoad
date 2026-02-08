!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer can$\r$\n- apply the GOG 2024 Update (v1.1) in your Steam copy$\r$\n- disable the intro videos$\r$\n$\r$\nEnjoy this updated game !"
!include "..\..\templates\select_exe.nsh"

Name "Alpha Protocol [PATCHS]"

Section "Steam Version - GOG Update v1.1"
    AddSize 4357211
    SetOutPath $INSTDIR

    # Check checksums
    /*StrCpy $R0 "CRC-32" ; PARAM1
    StrCpy $R1 "APGame\CookedPC\Maps\Game\Moscow\M08\M08_D01.umap"; PARAM2
    HashInfo::GetFileCRCHash "$R0" "$R1"
    Pop $0
    ${If} $0 == "9BFD7BED"
        MessageBox MB_OK "Your version is already up-to-date with GOG release v1.1. Skipping."
        DetailPrint "Skipping GOG Update v1.1."
        goto skip_section
    ${EndIf}*/

    # Delete files & folders not present (in GOG release)
    RMDir /r "$INSTDIR\_PatchBackup"
    Delete "Support\physx\PhysX_9.09.0814_SystemSoftware.exe"
    Delete "Binaries\Activator.exe"
    RMDir /r "$INSTDIR\Binaries\cs"
    RMDir /r "$INSTDIR\Binaries\de"
    RMDir /r "$INSTDIR\Binaries\en"
    RMDir /r "$INSTDIR\Binaries\es"
    RMDir /r "$INSTDIR\Binaries\fr"
    RMDir /r "$INSTDIR\Binaries\it"
    RMDir /r "$INSTDIR\Binaries\pl"
    RMDir /r "$INSTDIR\Binaries\ru"
    Delete "Binaries\saAudit2005MD.dll"
    Delete "Binaries\SANativeUIDLL.dll"
    Delete "Engine\Shaders\Material.usf"
    Delete "Engine\Shaders\VertexFactory.usf"

    # Replace old PhysX by newer PhysX (same as GOG) - Keep the old file name to be compatible with 34010_install.vdf
    !insertmacro Download https://us.download.nvidia.com/Windows/9.21.0713/PhysX_9.21.0713_SystemSoftware.exe "Support\physx\PhysX_9.09.0814_SystemSoftware.exe"

    # Download and Extract new/modified files (from GOG release)
    !insertmacro Download https://www.mediafire.com/file_premium/o5nd96qfxh3zmr4/AlphaProtocolSteam_GOGUpdate_v1.1.7z/file "AlphaProtocolSteam_GOGUpdate_v1.1.7z"
    Nsis7z::ExtractWithDetails "AlphaProtocolSteam_GOGUpdate_v1.1.7z" "Installing package %s..."
    Delete "AlphaProtocolSteam_GOGUpdate_v1.1.7z"

    /*skip_section:*/
SectionEnd

Section /o "Skip intro videos"
    SetOutPath $INSTDIR\APGame\Movies

    Rename "slate_ap.sfd" "slate_ap.sfd.bak"
    Rename "slate_obsidian.sfd" "slate_obsidian.sfd.bak"
    Rename "slate_sega.sfd" "slate_sega.sfd"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "APGame.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Alpha Protocol\Binaries"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
