!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download the latest version of Broken Sword 2.5 from the developer servers$\r$\n- run the setup$\r$\n- download and extract the latest language patch."
!include "..\..\templates\standard.nsh"

Name "Broken Sword 2.5: The Return of the Templars"
InstallDir "C:\MulderLoad\Broken Sword 2.5"

Section "Broken Sword 2.5 + Language Patch 2010"
    SectionIn RO
    SetOutPath $INSTDIR

    !insertmacro Download https://server.c-otto.de/baphometsfluch/bs25setup.zip "bs25setup.zip"
    nsisunz::Unzip "bs25setup.zip" ".\"
    Delete "bs25setup.zip"

    ExecWait '"bs25-setup.exe" /DIR="$INSTDIR" /SILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $0
    Delete "bs25-setup.exe"
    Delete "bs25-setup-1.bin"

    !insertmacro Download http://baphometsfluch25.de/downloads/sonstiges/BS25_patch000_multilingual.zip "BS25_patch000_multilingual.zip"
    nsisunz::Unzip "BS25_patch000_multilingual.zip" ".\"
    Delete "BS25_patch000_multilingual.zip"
SectionEnd
