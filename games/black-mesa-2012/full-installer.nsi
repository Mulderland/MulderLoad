!define MUI_WELCOMEPAGE_TEXT "\
This installer is for Black Mesa (the 2012 mod), the free version of the *almost official* remake of Half-Life. It will:$\r$\n\
- install Black Mesa 2012 (fixed by RN97 and EffBoyardee)$\r$\n\
- enable English subtitles for French users$\r$\n\
- (optionally) install the French translation$\r$\n\
$\r$\n\
IMPORTANT:$\r$\n\
- you need to have $\"Source SDK Base 2007$\" installed$\r$\n\
- after installation, restart Steam so the game appears$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
$\r$\n\
Special thanks to the Crowbar Collective! Consider buying the full game on Steam: it includes many improvements over this early version, as well as the final Xen chapters."

!define AFTER_DIRECTORY_PAGE
!include "..\..\includes\templates\ClassicTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\InnoExtract.nsh"

Name "Black Mesa (2012)"
InstallDir "C:\MulderLoad\Black Mesa 2012"

Section "Black Mesa 2012 Fixed (Full Installation)"
    AddSize 7423918
    SetOutPath "$INSTDIR\@mulderload"

    !insertmacro DOWNLOAD_2 "https://www.moddb.com/mods/black-mesa/downloads/black-mesa-source-fixed" \
                            "https://archive.org/download/blackmesa.2/blackmesa.2.zip" \
                            "blackmesa.2.zip" \
                            "80bf0c05c337cba9725cd8e135f5cb4f"

    # Extract with 7z (NSIS built-in unzip can't handle files > 4Gb)
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "blackmesa.2.zip" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE

    # Move the files to the root of the installation folder
    SetOutPath "$INSTDIR"
    !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\blackmesa" "$INSTDIR"

    # Make english subtitles available for french users
    CopyFiles "$INSTDIR\resource\closecaption_english.dat" "$INSTDIR\resource\closecaption_french.dat"
    CopyFiles "$INSTDIR\resource\closecaption_english.txt" "$INSTDIR\resource\closecaption_french.txt"
SectionEnd

Section /o "French patch (subtitles)"
    AddSize 293601
    SetOutPath "$INSTDIR"

    !insertmacro DOWNLOAD_1 "https://www.moddb.com/addons/black-mesa-official-french-translation" \
                            "Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" \
                            "67ff98cac9a092316b25601389c719f8e57f4282"

    # Extract with InnoExtract
    !insertmacro INNOEXTRACT_GET
    !insertmacro INNOEXTRACT_UNPACK "$INSTDIR\Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" "$INSTDIR" "AUTO_DELETE"
    !insertmacro INNOEXTRACT_REMOVE

    Rename "$INSTDIR\BMS_French\BlackMesa_French_LisezMoi.pdf" "$INSTDIR\BlackMesa_French_LisezMoi.pdf"
    RMDir /r "$INSTDIR\BMS_French"
SectionEnd

Section
    RMDir /r "$INSTDIR\@mulderload"
SectionEnd

Function AfterDirectoryPage
    !insertmacro STEAM_SOURCEMOD_PRE_INSTALL "Source SDK Base 2007" "blackmesa"
FunctionEnd
