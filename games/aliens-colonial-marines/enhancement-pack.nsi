!define MUI_WELCOMEPAGE_TEXT "Welcome to this NSIS installer from the MulderLoad project.$\r$\n$\r$\nThis installer will download and install the ACM Overhaul mod v6.2 that fixes a lot of things in this game."
!include "..\..\templates\select_exe.nsh"

Name "Aliens: Colonial Marines [PATCHS]"

SectionGroup /e "TemplarGFX's ACM Overhaul v6.2"
    Section "Reset game configuration (recommended)"
        RMDir /r "$PROFILE\Documents\My Games\Aliens Colonial Marines\PecanGame\Config\"
    SectionEnd

    Section "ACM Overhaul v6.0"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/1un6g79zzss7283/ACMO_V6_MODDB_SEP2020.7z/file "ACMO_V6_MODDB_SEP2020.7z"
        Nsis7z::ExtractWithDetails "ACMO_V6_MODDB_SEP2020.7z" "Installing package %s..."
        Delete "ACMO_V6_MODDB_SEP2020.7z"

        Delete "PecanGame\CookedPCConsole\DEFGEN_UnlocksVersus_SF.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\GearboxFramework.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\PecanGame.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\PecanGameHorde.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\Engine.upk.uncompressed_size"
        Delete "Binaries\Win32\ACM.exe"
        Delete "Binaries\Win32\_ACM.exe"
        Rename "Binaries\Win32\ACM_fix.exe" "Binaries\Win32\ACM.exe"
    SectionEnd

    Section "ACM Overhaul v6.2 Update"
        SetOutPath $INSTDIR

        !insertmacro Download https://www.mediafire.com/file_premium/9fqvzug1aq2ak8h/ACMO_V6-2_PATCH_MODDB_SEP2020.7z/file "ACMO_V6-2_PATCH_MODDB_SEP2020.7z"
        Nsis7z::ExtractWithDetails "ACMO_V6-2_PATCH_MODDB_SEP2020.7z" "Installing package %s..."
        Delete "ACMO_V6-2_PATCH_MODDB_SEP2020.7z"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "ACM.exe"
    StrCpy $SELECT_DEFAULT_FOLDER "C:\Program Files (x86)\Steam\steamapps\common\Aliens Colonial Marines\Binaries\Win32"
    StrCpy $SELECT_RELATIVE_INSTDIR "..\.."
FunctionEnd
