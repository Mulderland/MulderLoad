!define MUI_WELCOMEPAGE_TEXT "\
This Enhancement Pack for Alpha Protocol includes$\r$\n\
- GOG 2024 update for the Steam version (if detected)$\r$\n\
- Widescreen Fix && FOV Modifier (by zoli456)$\r$\n\
- Shooter Experience mod (by CalebChambers)$\r$\n\
- MulderConfig, a configuration tool that lets you toggle Shooter Experience, adjust the FOV, enable hidden Ultra quality settings, skip intro videos and skip the Steam launcher.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the GOG team for their work on the preservation of this great game!"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-Mulderland.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show README about known issues and workarounds"
!define ON_SELECTED_FILE
!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Alpha Protocol [Enhancement Pack]"

Section "Apply the 'GOG 2024 Update' to the Steam version" update2024
    SetOutPath "$INSTDIR"

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
                            "https://cdn.mulderload.eu/redistributables/physx/PhysX_9.21.0713_SystemSoftware.exe" \
                            "Support\physx\PhysX_9.09.0814_SystemSoftware.exe" \
                            "ffa850b7463cae49c651c24ee364f8f31fcf158e"

    DetailPrint " // Download GOG 2024 update"
    !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/alpha-protocol/update/Steam to GOG 2024 [MLD].7z.001" \
                                "Steam to GOG 2024 [MLD].7z.001" \
                                "91c3f7b346a85f5908de8c9b0d8379713ca5f0b2" \
                                3

    !insertmacro NSIS7Z_EXTRACT "Steam to GOG 2024 [MLD].7z.001" ".\" ""
    !insertmacro DELETE_RANGE "Steam to GOG 2024 [MLD].7z.001" 3

    DetailPrint " // Apply GOG 2024 update"
    !insertmacro XDELTA3_GET
    !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
    !insertmacro XDELTA3_REMOVE
    skip_section:
SectionEnd

Section "Widescreen Fix && FOV Modifier (by zoli456)"
    SetOutPath "$INSTDIR\Binaries"

    !insertmacro DOWNLOAD_1 "https://community.pcgamingwiki.com/files/file/3938-alpha-protocol-widescreen-fixer/" \
                            "AlphaFixer.7z" \
                            "ded6a05dfe53b37cfaaad98357c66fbba39c3aa8"

    !insertmacro NSIS7Z_EXTRACT "AlphaFixer.7z" ".\" ""
    AddSize 756
SectionEnd

Section "Weapon Accuracy Patch ('Shooter Experience' by CalebChambers)"
    SetOutPath "$INSTDIR\.MulderConfig\ShooterExperience\APGame\Config"

    !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/alphaprotocol/mods/11?tab=files&file_id=22" \
                            "Shooter experience.zip" \
                            "fec2ccacaed7b6ebaaf062ec57c5a621e9ccd473"

    !insertmacro NSISUNZ_EXTRACT "Shooter experience.zip" ".\" "AUTO_DELETE"
    AddSize 93

    Rename "APWeaponStats.ini" "DefaultWeaponStats.ini"
SectionEnd

Section "MulderConfig"
    ${IfNot} ${FileExists} "$INSTDIR\.MulderConfig\Backup\APGame\Config\DefaultWeaponStats.ini"
        CopyFiles /SILENT "$INSTDIR\APGame\Config\DefaultWeaponStats.ini" "$INSTDIR\.MulderConfig\Backup\APGame\Config\DefaultWeaponStats.ini"
    ${EndIf}
    AddSize 95

    # Workaround to avoid a warning in MulderConfig on GOG release
    ${IfNot} ${FileExists} "$INSTDIR\APLauncher.exe"
        FileOpen $0 "$INSTDIR\APLauncher.exe" w
        FileClose $0
    ${EndIf}

    !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources"
SectionEnd

Section
    RMDir /r "$INSTDIR\@mulderload"
    File /oname=README-Mulderland.txt resources\README.txt
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "APGame.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Alpha Protocol\Binaries"
    StrCpy $SELECT_RELATIVE_INSTDIR ".."
FunctionEnd

Function OnSelectedFile
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\Binaries\APGame.exe" "618b5f8c9ef45be6cb5cddbd0f05a80aed15a714" $0 ; steam checksum
    ${If} $0 = "1"
        MessageBox MB_ICONINFORMATION "The executable matches the Steam version.$\r$\n$\r$\nThe 'GOG 2024 update' will be available on the next screen."
        SectionSetFlags ${update2024} ${SF_SELECTED}
    ${Else}
        MessageBox MB_ICONINFORMATION "The executable does not match the Steam version (or the GOG 2024 update may already be installed).$\r$\n$\r$\nThe 'GOG 2024 update' option will not be available."
        SectionSetFlags ${update2024} ${SF_RO}
    ${EndIf}
FunctionEnd
