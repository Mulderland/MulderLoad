!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download The Stanley Parable (mod) v1.4.$\r$\n$\r$\nYou need to have 'Source SDK Base 2007' for this mod to work, this installer will try to install it via Steam.$\r$\n$\r$\nAfter installation, you will have to quit & restart Steam for the game to appear in your library."
!include "..\..\templates\select_exe.nsh"

Name "The Stanley Parable (mod)"

Section "Source SDK Base 2007 (Steam)"
    MessageBox MB_ICONINFORMATION  "Steam will install Source SDK Base 2007. Click OK and follow instructions on Steam."
    Exec '"$INSTDIR\..\..\..\steam.exe" steam://install/218'
    Sleep 10000
    MessageBox MB_OK "Click OK when 'Source SDK Base 2007' installation is complete."
SectionEnd

Section "The Stanley Parable (mod) v1.4"
    SectionIn RO
    !insertmacro AbortIfFolderNotEmpty "$INSTDIR\thestanleyparable"
    SetOutPath $INSTDIR\thestanleyparable.tmp

    !insertmacro Download https://www.mediafire.com/file_premium/xffffm9ryi03mz6/The_Stanley_Parable_v1.4.zip/file "The_Stanley_Parable_v1.4.zip"
    nsisunz::Unzip "The_Stanley_Parable_v1.4.zip" ".\"
    Delete "The_Stanley_Parable_v1.4.zip"

    SetOutPath $INSTDIR
    Rename "$INSTDIR\thestanleyparable.tmp\thestanleyparable" "$INSTDIR\thestanleyparable"
    Rename "$INSTDIR\thestanleyparable.tmp\author commentary.txt" "$INSTDIR\thestanleyparable\author commentary.txt"
    Rename "$INSTDIR\thestanleyparable.tmp\changelist.txt" "$INSTDIR\thestanleyparable\changelist.txt"
    Rename "$INSTDIR\thestanleyparable.tmp\readme.txt" "$INSTDIR\thestanleyparable\readme.txt"
    RMDir /r "$INSTDIR\thestanleyparable.tmp"
SectionEnd

Function .onInit
    StrCpy $SELECT_FILENAME "steam.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam"
    StrCpy $SELECT_RELATIVE_INSTDIR "steamapps\sourcemods"
FunctionEnd
