!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Alpha Protocol, which can$\r$\n\
- upgrade a Steam installation to the GOG 2024 re-release$\r$\n\
- skip intro videos$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the GOG team for their work on the preservation of this great game!"

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Alpha Protocol [Enhancement Pack]"

Section "Update Steam to GOG version (2024 re-release)"
    AddSize 4357211
    SetOutPath "$INSTDIR"

    DetailPrint " // Comparing binary with GOG checksum..."
    !insertmacro FILE_HASH_EQUALS "Binaries\APGame.exe" "bfa50aa9f8ce655be1356b691358d9ec2c9496a6" $0
    ${If} $0 == "1"
        MessageBox MB_ICONEXCLAMATION "Binary is already up-to-date with GOG release v1.1. Skipping."
        DetailPrint " // Skipping GOG Update v1.1."
        goto skip_section
    ${EndIf}

    DetailPrint " // Comparing binary with Steam checksum..."
    !insertmacro FILE_HASH_EQUALS "Binaries\APGame.exe" "618b5f8c9ef45be6cb5cddbd0f05a80aed15a714" $0
    ${If} $0 != "1"
        MessageBox MB_ICONEXCLAMATION "Only Steam release can apply this update. Aborting."
        DetailPrint " // Aborting GOG Update v1.1."
        goto skip_section
    ${EndIf}

    DetailPrint " // Delete files & folders not present in GOG release..."
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

    DetailPrint " // Update PhysX installer to the same shipped with GOG release..." ; keep the old file name to be compatible with 34010_install.vdf
    !insertmacro DOWNLOAD_2 "https://us.download.nvidia.com/Windows/9.21.0713/PhysX_9.21.0713_SystemSoftware.exe" \
                            "https://cdn2.mulderload.eu/g/alpha-protocol/PhysX_9.21.0713_SystemSoftware.exe" \
                            "Support\physx\PhysX_9.09.0814_SystemSoftware.exe" "ffa850b7463cae49c651c24ee364f8f31fcf158e"

    DetailPrint " // Download new files from GOG release..."
    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/o5nd96qfxh3zmr4/AlphaProtocolSteam_GOGUpdate_v1.1.7z/file" \
                            "https://cdn2.mulderload.eu/g/alpha-protocol/AlphaProtocolSteam_GOGUpdate_v1.1.7z" \
                            "AlphaProtocolSteam_GOGUpdate_v1.1.7z" "d8c4d4c5123d8f9c4bdabc3d45621fbef230763a"
    !insertmacro NSIS7Z_EXTRACT "AlphaProtocolSteam_GOGUpdate_v1.1.7z" ".\" "AUTO_DELETE"
    skip_section:
SectionEnd

Section /o "Skip intro videos"
    SetOutPath "$INSTDIR\APGame\Movies"

    !insertmacro FORCE_RENAME "slate_ap.sfd" "slate_ap.sfd.bak"
    !insertmacro FORCE_RENAME "slate_obsidian.sfd" "slate_obsidian.sfd.bak"
    !insertmacro FORCE_RENAME "slate_sega.sfd" "slate_sega.sfd.bak"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "APGame.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Alpha Protocol\Binaries"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd
