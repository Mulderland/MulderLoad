!define MUI_WELCOMEPAGE_TEXT "\
This $\"BYOF Installer$\" can install Colin McRae: Dirt 2 from the original disc image, and install:$\r$\n\
- Updated installers for OpenAL, GFWL, Rapture3D.$\r$\n\
- Care Package v1.1 (by thrive4)$\r$\n\
- FOV Change Software (by dengo)$\r$\n\
- GFWL Fix (by ThirteenAG)$\r$\n\
$\r$\n\
WARNING: For legal reasons, this installer doesn't include or download the original disc image. You must provide your own. Tested with EU release; others may not work.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!define MUI_FINISHPAGE_RUN "$INSTDIR\MulderConfig.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run MulderConfig"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\@mulderload\README.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show information about GFWL"
!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\Unshield.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

!insertmacro BYOF_DEFINE "DVD" "$INSTDIR\Images files|*.iso" "d5732861de09582d6c8dfb2ab1254dea54dc9f1e"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Name "Colin McRae: Dirt 2"
InstallDir "e:\MulderLoad\Colin McRae Dirt 2" # TODO c:

SectionGroup /e "Colin McRae Dirt 2 (Full Installation, v1.1)" lang
    Section
        AddSize 10800333
        SetOutPath "$INSTDIR"

        # Extract Iso
        !insertmacro 7Z_GET
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_DVD" "$INSTDIR\@mulderload\iso" ""
        !insertmacro 7Z_REMOVE

        # Unpack CAB
        !insertmacro UNSHIELD_GET
        !insertmacro UNSHIELD_UNPACK "$INSTDIR\@mulderload\iso\data1.cab" "$INSTDIR\@mulderload\unpack"
        !insertmacro UNSHIELD_REMOVE
        RMDir /r "$INSTDIR\@mulderload\iso"

        # Move files to final location
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\CodiesIcon" "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\Dll" "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\GameExecutable" "$INSTDIR"
        !insertmacro FORCE_RENAME "$INSTDIR\dirt2.exe" "$INSTDIR\dirt2o.exe"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\GameFolder_Disc" "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\LanguageWorld_Disc" "$INSTDIR"
        RMDIR /r "$INSTDIR\@mulderload\unpack"

        # Download v1.1 Update
        !insertmacro DOWNLOAD_2 "https://cdn1.mulderload.eu/games/colin-mcrae-dirt-2/byof-installer/Dirt2Retail_Update1.1.7z" \
                                "https://www.mediafire.com/file_premium/eoygtrmzryn96l8/Dirt2Retail_Update1.1.7z/file" \
                                "Dirt2Retail_Update1.1.7z" "51fc103b4e2685444ed6b2f809fce032d0d1f230"
        !insertmacro NSIS7Z_EXTRACT "Dirt2Retail_Update1.1.7z" ".\" "AUTO_DELETE"

        # Apply v1.1 Update
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
        !insertmacro XDELTA3_REMOVE
    SectionEnd

    Section "English" lang_eng
        ExecShell "runas" "$SYSDIR\reg.exe" 'ADD "HKLM\SOFTWARE\Codemasters\DiRT2" /v LANGUAGE /t REG_SZ /d eng /f /reg:32'
    SectionEnd

    Section /o "French" lang_fre
        ExecShell "runas" "$SYSDIR\reg.exe" 'ADD "HKLM\SOFTWARE\Codemasters\DiRT2" /v LANGUAGE /t REG_SZ /d fre /f /reg:32'
    SectionEnd

    Section /o "German" lang_ger
        ExecShell "runas" "$SYSDIR\reg.exe" 'ADD "HKLM\SOFTWARE\Codemasters\DiRT2" /v LANGUAGE /t REG_SZ /d ger /f /reg:32'
    SectionEnd

    Section /o "Italian" lang_ita
        ExecShell "runas" "$SYSDIR\reg.exe" 'ADD "HKLM\SOFTWARE\Codemasters\DiRT2" /v LANGUAGE /t REG_SZ /d ita /f /reg:32'
    SectionEnd

    Section /o "Spanish" lang_spa
        ExecShell "runas" "$SYSDIR\reg.exe" 'ADD "HKLM\SOFTWARE\Codemasters\DiRT2" /v LANGUAGE /t REG_SZ /d spa /f /reg:32'
    SectionEnd
SectionGroupEnd

!define BYOF_INSTALLER_NSI
!include "enhancement-pack.nsi"

Section
    ExecShell "runas" "$INSTDIR\redist\OpenAL\OpenALwEAX.exe"
SectionEnd

Function .onInit
    StrCpy $9 ${lang_eng} ; Radio Button
FunctionEnd

Function .onSelChange
    ${If} ${SectionIsSelected} ${lang}
        !insertmacro UnSelectSection ${lang}
    ${Else}
        !insertmacro StartRadioButtons $9
            !insertmacro RadioButton ${lang_eng}
            !insertmacro RadioButton ${lang_fre}
            !insertmacro RadioButton ${lang_ger}
            !insertmacro RadioButton ${lang_ita}
            !insertmacro RadioButton ${lang_spa}
        !insertmacro EndRadioButtons
    ${EndIf}
FunctionEnd
