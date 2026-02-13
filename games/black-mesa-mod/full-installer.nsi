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

!include "..\..\includes\templates\SelectTemplate.nsh"
!include "..\..\includes\tools\7z.nsh"
!include "..\..\includes\tools\InnoExtract.nsh"

Name "Black Mesa (Mod)"

Section "Black Mesa 2012 Fixed (Full Installation)"
    AddSize 7423918
    SetOutPath "$INSTDIR\blackmesa"

    # https://www.moddb.com/mods/black-mesa/downloads/black-mesa-source-fixed
    !insertmacro DOWNLOAD_3 "https://www.moddb.com/downloads/start/253401" \
                            "https://archive.org/download/blackmesa.2/blackmesa.2.zip" \
                            "https://cdn2.mulderload.eu/g/black-mesa-2012/blackmesa.2.zip" \
                            "blackmesa.2.zip" "80bf0c05c337cba9725cd8e135f5cb4f"

    # Extract with 7z (NSIS built-in unzip can't handle files > 4Gb)
    SetOutPath "$INSTDIR"
    !insertmacro 7Z_GET
    !insertmacro 7Z_EXTRACT "blackmesa\blackmesa.2.zip" ".\" "AUTO_DELETE"
    !insertmacro 7Z_REMOVE

    # Make english subtitles available for french users
    CopyFiles "$INSTDIR\blackmesa\resource\closecaption_english.dat" "$INSTDIR\blackmesa\resource\closecaption_french.dat"
    CopyFiles "$INSTDIR\blackmesa\resource\closecaption_english.txt" "$INSTDIR\blackmesa\resource\closecaption_french.txt"
SectionEnd

Section /o "Patch FR (French Subtitles)"
    AddSize 293601
    SetOutPath "$INSTDIR\blackmesa"

    # https://www.moddb.com/addons/black-mesa-official-french-translation
    !insertmacro DOWNLOAD_3 "https://www.moddb.com/addons/start/50301" \
                            "https://cdn2.mulderload.eu/g/black-mesa-2012/Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" \
                            "https://www.mediafire.com/file_premium/2bsqcj02ceiqjkz/Black_Mesa_-_Official_French_Translation_1.0_Setup.exe/file" \
                            "Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" "67ff98cac9a092316b25601389c719f8e57f4282"

    # Extract with InnoExtract
    !insertmacro INNOEXTRACT_GET
    !insertmacro INNOEXTRACT_UNPACK "$INSTDIR\blackmesa\Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" "$INSTDIR\blackmesa" "AUTO_DELETE"
    !insertmacro INNOEXTRACT_REMOVE

    Rename "$INSTDIR\blackmesa\BMS_French\BlackMesa_French_LisezMoi.pdf" "$INSTDIR\blackmesa\BlackMesa_French_LisezMoi.pdf"
    RMDir /r "$INSTDIR\blackmesa\BMS_French"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods"
FunctionEnd
