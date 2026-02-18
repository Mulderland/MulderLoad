!define MUI_WELCOMEPAGE_TEXT "\
This downgrader is for the latest Steam version of Resident Evil 4 (2023) (v1.5.0.0 - February 2026). Works with all editions && languages.$\r$\n\
$\r$\n\
It downloads and apply $\"xdelta patches$\" to revert your game to the n-1 version (v1.1.1.0 - March 2025).$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}"

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Resident Evil 4 (2023) [Steam Downgrader]"

Section "Downgrade Steam version to v1.1.1.0 (March 2025)"
    AddSize 371500

    DetailPrint " // Comparing binary with v1.1.1.0 checksum..."
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\re4.exe" "ee5c88dac146a3c642b8da20925032a8a0d3e31e" $0
    ${If} $0 == "1"
        MessageBox MB_ICONEXCLAMATION "Binary is already the v1.1.1.0. Skipping."
        DetailPrint " // Skipping downgrade."
        Quit
    ${EndIf}

    DetailPrint " // Comparing binary with v1.5.0.0 checksum..."
    !insertmacro FILE_HASH_EQUALS "$INSTDIR\re4.exe" "c4017d5c0638f602ba17a38c22f4f45933305985" $0
    ${If} $0 != "1"
        MessageBox MB_ICONEXCLAMATION "Only latest and legit Steam release can apply this downgrade. Aborting."
        DetailPrint " // Aborting downgrade."
        Quit
    ${EndIf}

    SetOutPath "$INSTDIR"

    # Download xdelta3 patches
    !insertmacro DOWNLOAD_RANGE_1 "https://cdn2.mulderload.eu/g/resident-evil-4-2023/steam-downgrader_v1.5.0.0_to_v1.1.1.0/2050651.7z.001" "2050651.7z.001" "51e70078ec16bb42d6ddc90327d9dc4b72c21174" 6
    !insertmacro NSIS7Z_EXTRACT "2050651.7z.001" ".\" ""
    !insertmacro DELETE_RANGE "2050651.7z.001" 6

    !insertmacro DOWNLOAD_1 "https://cdn2.mulderload.eu/g/resident-evil-4-2023/steam-downgrader_v1.5.0.0_to_v1.1.1.0/2050653.7z" "2050653.7z" "ecddf37a2758dbfa2746cf78b250f87491387853"
    !insertmacro NSIS7Z_EXTRACT "2050653.7z" ".\" "AUTO_DELETE"

    # Apply xdelta3 patches
    !insertmacro XDELTA3_GET
    !insertmacro XDELTA3_PATCH_FOLDER "$INSTDIR"
    !insertmacro XDELTA3_REMOVE

    # Remove files not present in v1.1.1.0
    Delete "re_chunk_000.pak.patch_004.pak" ; added in depot 2050651
    Delete "re_chunk_000.pak.patch_005.pak" ; added in depot 2050653
SectionEnd

Section /o "Block future Steam update"
    SetOutPath "$INSTDIR\..\.."
    DetailPrint " // Block future update (appmanifest_2050650.acf)"
    SetFileAttributes "appmanifest_2050650.acf" READONLY
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "re4.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\RESIDENT EVIL 4 BIOHAZARD RE4"
    StrCpy $SELECT_RELATIVE_INSTDIR ""
FunctionEnd
