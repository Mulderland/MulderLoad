!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Broken Sword 2.5, a fan-game. It will:$\r$\n\
- install the latest version of the game (using InnoExtract)$\r$\n\
- install the latest language patch$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the developers, mindFactory! Broken Sword is a trademark of Revolution Software. This project is not affiliated with or endorsed by Revolution Software."

!include "..\..\includes\templates\ClassicTemplate.nsh"
!include "..\..\includes\tools\InnoExtract.nsh"

Name "Broken Sword 2.5: The Return of the Templars"
InstallDir "C:\MulderLoad\Broken Sword 2.5"

Section "Broken Sword 2.5 + Language Patch 2010"
    AddSize 887808
    SetOutPath "$INSTDIR"

    # Get installer
    !insertmacro DOWNLOAD_2 "https://server.c-otto.de/baphometsfluch/bs25setup.zip" \
                            "https://cdn2.mulderload.eu/g/broken-sword-25-the-return-of-the-templars/bs25setup.zip" \
                            "bs25setup.zip" "d23601a4991ded4b15999f127accbfed7be93a83"
    !insertmacro NSISUNZ_EXTRACT "bs25setup.zip" ".\" "AUTO_DELETE"

    # Unpack installer
    !insertmacro INNOEXTRACT_GET
    !insertmacro INNOEXTRACT_UNPACK "$INSTDIR\bs25-setup.exe" "$INSTDIR" "AUTO_DELETE"
    !insertmacro INNOEXTRACT_REMOVE
    Delete "bs25-setup-1.bin"

    # Get language patch
    !insertmacro DOWNLOAD_2 "http://baphometsfluch25.de/downloads/sonstiges/BS25_patch000_multilingual.zip" \
                            "https://cdn2.mulderload.eu/g/broken-sword-25-the-return-of-the-templars/BS25_patch000_multilingual.zip" \
                            "BS25_patch000_multilingual.zip" "3ccc20cb9d4277c9530eed88a114128863f0e070"
    !insertmacro NSISUNZ_EXTRACT "BS25_patch000_multilingual.zip" ".\" "AUTO_DELETE"
SectionEnd
