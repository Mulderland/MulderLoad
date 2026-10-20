!define MUI_WELCOMEPAGE_TEXT "This installer requires a user-provided image of the original Xbox 360 DVD of Dante's Inferno.$\r$\n\
$\r$\n\
It will verify the integrity of the provided image, install hells-gate-recomp (the unofficial PC port), and extract the game files to the installation folder.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to florinp93 for successfully bringing this great game to the PC platform!$\r$\n\
$\r$\n\
This installer and the PC port are not affiliated with or endorsed by EA, Visceral Games or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "Dante's Inferno"
InstallDir "C:\Mulderland\Dante's Inferno"

; .................................................................Europe (En,De,It)................USA/Europe (En,Fr,Es)........
!insertmacro BYOF_DEFINE "DVD" "Image files|*.iso" "a8920be61d80305158423092bb3ab1f089c7795c,633e2f81cda61c9a1d9486710855151a2474aa51"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "hells-gate-recomp v0.8.4-beta"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/florinp93/hells-gate-recomp/releases/download/v0.8.4-beta/DantesInferno-0.8.4-beta-portable.zip" \
                            "https://cdn.mulderload.eu/games/dantes-inferno/port/DantesInferno-0.8.4-beta-portable.zip" \
                            "DantesInferno-portable.zip" \
                            "9cdea0d96f5210ad737c95316dd4806d41c88a1716e526a71f69dfe62e3755f2"

    !insertmacro NSISUNZ_EXTRACT "DantesInferno-portable.zip" ".\" "AUTO_DELETE"

    AddSize 94838
SectionEnd

Section "Extract game files from DVD image"
    SetOutPath "$INSTDIR"

    DetailPrint " // Get latest extract-xiso"
    !insertmacro DOWNLOAD_2 "https://github.com/XboxDev/extract-xiso/releases/download/build-202609111233/extract-xiso-Win64_Release.zip" \
                            "https://cdn.mulderload.eu/dependencies/extract-xiso/build-202609111233/extract-xiso-Win64_Release.zip" \
                            "extract-xiso.zip" \
                            "fc891dfa72f08e3838a2f8b7ec34a8e4d61678da1cc8fee879677f00bf114ce3"

    !insertmacro NSISUNZ_EXTRACT_ONE "extract-xiso.zip" ".\" "artifacts\extract-xiso.exe" "AUTO_DELETE"

    DetailPrint " // Extracting game files from DVD image"
    nsExec::ExecToStack '"$INSTDIR\extract-xiso.exe" -x -d game "$byofPath_DVD"'
    AddSize 5764493
SectionEnd
