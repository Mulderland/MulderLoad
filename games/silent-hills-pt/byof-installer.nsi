!define MUI_WELCOMEPAGE_TEXT "This installer requires user-provided copy of the original USA P.T. (CUSA01127)$\r$\n\
$\r$\n\
It will verify the integrity of the provided image, install P.T. Unofficial PC Port (Windows or Linux, depending on your OS), and extract the game files to the installation folder.$\r$\n\
$\r$\n\
Special thanks to LoreanXavier for successfully bringing this legendary demo to the PC platform!$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
This installer and the PC port are not affiliated with or endorsed by Konami, Kojima Productions or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\I6Comp.nsh"
!include "..\..\includes\tools\XDelta3.nsh"

Name "Silent Hills: P.T. (Unofficial PC port)"
InstallDir "C:\Mulderland\Silent Hills P.T."

!insertmacro BYOF_DEFINE "USAdemo" "PKG files|*.pkg" "0627b5b3cbf0e05a2ba99b058999a81d0fac153a"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "P.T. PC Port v1.02 (by LoreanXavier)"
    SetOutPath "$INSTDIR"

    !insertmacro DETECT_OS $R0
    ${If} $R0 == "Linux"
        !insertmacro DOWNLOAD_2 "https://github.com/LoreanXavier/pt-pc/releases/download/v1.0.2/P.T.PC.Port-portable-linux.zip" \
                                "https://cdn.mulderload.eu/games/silent-hills-pt/P.T.PC.Port-portable-linux-v1.0.2.zip" \
                                "P.T.PC.Port-portable.zip" \
                                "7cb174e984591bed2183b2555192128592e50781727dc4ad7a4d0cb85224495a"
    ${Else}
        !insertmacro DOWNLOAD_2 "https://github.com/LoreanXavier/pt-pc/releases/download/v1.0.2/P.T.PC.Port-portable-windows.zip" \
                                "https://cdn.mulderload.eu/games/silent-hills-pt/P.T.PC.Port-portable-windows-v1.0.2.zip" \
                                "P.T.PC.Port-portable.zip" \
                                "0b3470da25a8d217ef952d3ed543eee822fa47372cde6986b251098ae1904dea"
    ${EndIf}
    !insertmacro NSISUNZ_EXTRACT "P.T.PC.Port-portable.zip" ".\" "AUTO_DELETE"
    !insertmacro FOLDER_MERGE "$INSTDIR\pt-port-20261010-943efa66" "$INSTDIR"
    AddSize 472259
SectionEnd

Section "Extract game files from PKG"
        SetOutPath "$INSTDIR"

        DetailPrint " // Get pkgextract"
        !insertmacro DOWNLOAD_2 "https://github.com/paulomanrique/ps4-pkg-extractor/releases/download/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                                "https://cdn.mulderload.eu/dependencies/ps4-pkg-extractor/v0.0.1/pkgextract-x86_64-pc-windows-msvc.zip" \
                                "pkgextract.zip" \
                                "0c736ee02779fb5cf4403a91da23f94fdaa72debf995be0c400ac9c36acee63a"

        !insertmacro NSISUNZ_EXTRACT "pkgextract.zip" ".\" "AUTO_DELETE"

        DetailPrint " // Extracting game files from PKGs"
        nsExec::ExecToStack '"$INSTDIR\pkgextract.exe" -o ".\CUSA01127" -f "$byofPath_USAdemo"'
        AddSize 1320712

        DetailPrint " // Cleaning up"
        Delete "pkgextract.exe"
SectionEnd
