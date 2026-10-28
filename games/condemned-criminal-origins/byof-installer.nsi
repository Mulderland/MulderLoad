!define MUI_WELCOMEPAGE_TEXT "\
WARNING: For legal reasons, this installer doesn't include or distribute the original game files. You must provide your own DVD image. It has been tested with all official releases.$\r$\n\
$\r$\n\
It will installs the game (without running Installshield), and:$\r$\n\
- AI Upscaled Textures (Neural Origins)$\r$\n\
- Improved Shaders (Sikkmod)$\r$\n\
- DSOAL + OpenAL Soft (to restore EAX support)$\r$\n\
- MulderConfig, for intro skipping, FOV adjustment && more.$\r$\n\
- OLED Alternate HUD Colors (by Mulder)$\r$\n\
- Toggle HUD (by Akelaphobia)$\r$\n\
- Widescreen Fix (by ThirteenAG) repacked with DxWrapper$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_1}$\r$\n\
$\r$\n\
Special thanks to ThirteenAG && the Neural Origins modders!"

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\i6Comp.nsh"

; ...........................................................Europe (Rerelease)............................Europe/Asia..........................USA/Europe.................
!insertmacro BYOF_DEFINE "DVD" "Images files|*.iso" "e912ddef763cd3a841a4813795175c6f7f48e8fd,02a29646550de1d9e17bcaf6bcab2a1f6f7486eb,89d660460f83c1f905b7c43c9c1afbecbce73cd0"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Name "Condemned: Criminal Origins"
InstallDir "C:\Mulderland\Condemned - Criminal Origins"

!macro I6COMP_UNPACK_GROUPS ARCHIVE_PATH TARGET_DIR
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with I6Comp"

    # Backup $0 and OutPath
    Push $0
    StrCpy $0 "$OUTDIR"

    # Unpack
    SetOutPath "${TARGET_DIR}"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\i6comp\i6comp.exe" x -f "${ARCHIVE_PATH}"'

    # Restore OutPath and $0
    SetOutPath "$0"
    Pop $0
!macroend

SectionGroup "Condemned: Criminal Origins"
    Section
        AddSize 6540065

        SetOutPath "$INSTDIR"

        # Extract ISO
        !insertmacro 7Z_GET
        !insertmacro 7Z_IMAGE_EXTRACT "$byofPath_DVD" "$INSTDIR\@mulderload\iso" ""

        # Unpack CAB
        !insertmacro I6COMP_GET
        !insertmacro I6COMP_UNPACK_GROUPS "$INSTDIR\@mulderload\iso\data1.cab" "$INSTDIR\@mulderload\unpack"
        !insertmacro I6COMP_REMOVE
        RMDir /r "$INSTDIR\@mulderload\iso"

        # Move files to final location
        CreateDirectory "$INSTDIR\Game"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\GameFiles" "$INSTDIR\Game"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\GameFiles_English" "$INSTDIR\Game"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\DefaultComponent" "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\DefaultComponent_English" "$INSTDIR"
        !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\unpack\SelfRegFiles" "$INSTDIR"

        # Clean up temporary directories
        RMDIR /r "$INSTDIR\@mulderload\unpack"

        # NoCD Patch
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/condemned-criminal-origins/update/NoCD%20Patch%20v1.0.320.7z" \
                                "NoCD Patch v1.0.320.7z" \
                                "7ed261111a571601cc166d9863289cdad608f946"
        !insertmacro 7Z_EXTRACT "NoCD Patch v1.0.320.7z" "$INSTDIR" "AUTO_DELETE"
    SectionEnd

    Section "Redistributables"
        SetOutPath "$INSTDIR\Redist"

        !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe" \
                                "https://cdn.mulderload.eu/redistributables/microsoft/vc2010/vcredist_x64.exe" \
                                "vcredist_x64.exe" \
                                "8691972f0a5bf919701ac3b80fb693fc715420c2"
        AddSize 10037

        !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe" \
                                "https://cdn.mulderload.eu/redistributables/microsoft/vc2010/vcredist_x86.exe" \
                                "vcredist_x86.exe" \
                                "2222fc008e469fec77d0d291877f357c6e1eb16d"
        AddSize 8783

        !insertmacro DOWNLOAD_2 "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe" \
                                "https://cdn.mulderload.eu/redistributables/microsoft/dx9/dxwebsetup.exe" \
                                "dxwebsetup.exe" \
                                "7bf35f2afca666078db35ca95130beb2e3782212"
        AddSize 289
    SectionEnd
SectionGroupEnd

!define NSI_INCLUDE
!include "enhancement-pack.nsi"
