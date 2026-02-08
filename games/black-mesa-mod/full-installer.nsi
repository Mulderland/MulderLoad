!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will$\r$\n- download Black Mesa mod from Archive.org$\r$\n- download the 2023 fix (thanks to RN97 and EffBoyardee)$\r$\n- make english subtitles to work for french users$\r$\n- (optionally) download and install the official french translation$\r$\n$\r$\nYou need to have 'Source SDK Base 2007' for this mod to work, this installer will try to install it via Steam.$\r$\n$\r$\nAfter installation, you will have to quit & restart Steam for the game to appear in your library."
!include "..\..\templates\select_exe.nsh"

Name "Black Mesa (mod)"

Section "Source SDK Base 2007 (Steam)"
    MessageBox MB_ICONINFORMATION  "Steam will install Source SDK Base 2007. Click OK and follow instructions on Steam."
    Exec '"$INSTDIR\..\..\..\steam.exe" steam://install/218'
    Sleep 10000
    MessageBox MB_OK "Click OK when 'Source SDK Base 2007' installation is complete."
SectionEnd

Section "Black Mesa (with 2023 update)"
    SectionIn RO
    SetOutPath $INSTDIR

    # This zip already includes the 2023 patch, but unzip doesn't work for files > 4Gb
    #!insertmacro Download https://ia600500.us.archive.org/11/items/blackmesa.2/blackmesa.2.zip blackmesa.2.zip

    # So let's use the 2012 version in 7z...
    !insertmacro Download https://archive.org/download/blackmesasource2012/blackmesa.7z "blackmesa.7z"
    Nsis7z::ExtractWithDetails "blackmesa.7z" "Installing package %s..."
    Delete "blackmesa.7z"

    # ...and the 2023 "update" created with WinMerge
    !insertmacro Download https://www.mediafire.com/file_premium/voo0iccje87wy3o/update_2023.7z/file "update_2023.7z"
    Nsis7z::ExtractWithDetails "2023_update.7z" "Installing package %s..."
    Delete "2023_update.7z"

    # Make english subtitles available for french users
    CopyFiles "$INSTDIR\resource\closecaption_english.dat" "$INSTDIR\resource\closecaption_french.dat"
    CopyFiles "$INSTDIR\resource\closecaption_english.txt" "$INSTDIR\resource\closecaption_french.txt"
SectionEnd

Section /o "Patch FR (French Subtitles)"
    SetOutPath $INSTDIR

    !insertmacro Download https://www.mediafire.com/file_premium/2bsqcj02ceiqjkz/Black_Mesa_-_Official_French_Translation_1.0_Setup.exe/file "Black_Mesa_-_Official_French_Translation_1.0_Setup.exe"
    ExecWait '"Black_Mesa_-_Official_French_Translation_1.0_Setup.exe" /DIR="$INSTDIR" /SILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $0
    Delete "Black_Mesa_-_Official_French_Translation_1.0_Setup.exe"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods\BMS"
FunctionEnd
