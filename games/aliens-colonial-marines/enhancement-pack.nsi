!define MUI_WELCOMEPAGE_TEXT "\
This is an Enhancement Pack for Aliens: Colonial Marines which will$\r$\n\
- download and install ACM Overhaul v6.0$\r$\n\
- download and install ACM Overhaul v6.2 update$\r$\n\
automatically without manual step required.$\r$\n\
$\r$\n\
${TXT_WELCOMEPAGE_MULDERLAND_3}$\r$\n\
$\r$\n\
Special thanks to the TemplarGFX team for their work on this amazing overhaul mod that fixes many issues of the original game and enhance it in many ways !"

!include "..\..\includes\templates\SelectTemplate.nsh"

Name "Aliens: Colonial Marines [Enhancement Pack]"

SectionGroup /e "TemplarGFX's ACM Overhaul v6.2"
    Section "Reset game configuration (recommended)"
        RMDir /r "$PROFILE\Documents\My Games\Aliens Colonial Marines\PecanGame\Config\"
    SectionEnd

    Section
        AddSize 1289748
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/templargfxs-acm-overhaul/downloads/acmo-v6-moddb-sep2020" \
                                "ACMO_V6_MODDB_SEP2020.zip" \
                                "34501c84738b72044027758915c49875"

        !insertmacro NSISUNZ_EXTRACT "ACMO_V6_MODDB_SEP2020.zip" ".\" "AUTO_DELETE"

        # Delete ACMOverhaulV6Install.bat and do what it does instead
        Delete "ACMOverhaulV6Install.bat"
        Delete "PecanGame\CookedPCConsole\DEFGEN_UnlocksVersus_SF.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\GearboxFramework.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\PecanGame.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\PecanGameHorde.upk.uncompressed_size"
        Delete "PecanGame\CookedPCConsole\Engine.upk.uncompressed_size"
        Delete "Binaries\Win32\ACM.exe"
        Delete "Binaries\Win32\_ACM.exe"
        Rename "Binaries\Win32\ACM_fix.exe" "Binaries\Win32\ACM.exe"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/templargfxs-acm-overhaul/downloads/acm-overhaul-v62-patch" \
                                "ACMO_V6-2_PATCH_MODDB_SEP2020.zip" \
                                "f10d3081708c6fe16734afa36316b043"

        !insertmacro NSISUNZ_EXTRACT "ACMO_V6-2_PATCH_MODDB_SEP2020.zip" ".\" "AUTO_DELETE"
    SectionEnd
SectionGroupEnd

Function .onInit
    StrCpy $SELECT_FILENAME "ACM.exe"
    StrCpy $SELECT_RELATIVE_PATH "Binaries\Win32"
    StrCpy $SELECT_STEAM_FOLDER "Aliens Colonial Marines"
FunctionEnd
