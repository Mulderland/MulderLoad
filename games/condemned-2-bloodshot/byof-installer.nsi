!define MUI_WELCOMEPAGE_TEXT "This installer requires a user-provided image of the original Xbox 360 DVD of Condemned 2: Bloodshot.$\r$\n\
$\r$\n\
It will verify the integrity of the provided image, install Condemned2Recomp, and extract the game files to the installation folder.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to psxrestore for successfully bringing this great game to the PC platform!$\r$\n\
$\r$\n\
This installer and the PC port are not affiliated with or endorsed by Sega, Monolith Productions or any of the original developers."

!include "..\..\includes\templates\ByofTemplate.nsh"

Name "Condemned 2: Bloodshot"
InstallDir "C:\Mulderland\Condemned 2 - Bloodshot"

; ............................................................USA/Europe (En,Fr,It,Es)......
!insertmacro BYOF_DEFINE "DVD" "Image files|*.iso" "c1ec069da8244416b06dd130e53af19442a8d434"
!insertmacro BYOF_PAGE_CREATE
!insertmacro BYOF_WRITE_ENABLE_NEXT_BUTTON

Section "Condemned2Recomp v0.5.1"
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_2 "https://github.com/psxrestore/Condemned2Recomp/releases/download/0.5.1/condemned2recompV0.5.1_windows.zip" \
                            "https://cdn.mulderload.eu/games/condemned-2-bloodshot/condemned2recompV0.5.1_windows.zip" \
                            "condemned2recomp.zip" \
                            "87812b1475435296e95240a54e4e462e5abba9124c8c3234275bbddb19c8be74"

    !insertmacro NSISUNZ_EXTRACT "condemned2recomp.zip" ".\" "AUTO_DELETE"

    AddSize 65502
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
    nsExec::ExecToStack '"$INSTDIR\extract-xiso.exe" -x -d Assets "$byofPath_DVD"'
    AddSize 7108708
    Delete "extract-xiso.exe"

    # Patch Arch02 files like done here: https://github.com/psxrestore/Condemned2Recomp/blob/861d612c8c5229d6028177a3e7a86308cbac901c/src/suite/xdvdfs_extractor.h#L78
    !insertmacro FILE_HASH_EQUALS "Assets\Layer01.Arch02" "fef900d062326ad5b4e60217a6cdb3190322ab08" $R0
    ${If} $R0 == 1
        DetailPrint " // Patching Assets\Layer01.Arch02 with 10 zero bytes"
        FileOpen $R0 "Assets\Layer01.Arch02" a
        FileSeek $R0 0 END
        # Add 10 zero bytes
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileClose $R0
    ${EndIf}
    !insertmacro FILE_HASH_EQUALS "Assets\Layer02.Arch02" "45688c4bbaae49b0260f52e7d6e4402187dc3b37" $R0
    ${If} $R0 == 1
        DetailPrint " // Patching Assets\Layer02.Arch02 with 10 zero bytes"
        FileOpen $R0 "Assets\Layer02.Arch02" a
        FileSeek $R0 0 END
        # Add 10 zero bytes
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileWriteByte $R0 0
        FileClose $R0
    ${EndIf}
SectionEnd
