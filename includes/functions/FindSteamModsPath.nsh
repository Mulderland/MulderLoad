!ifndef __FINDSTEAMMODSPATH_NSH__
!define __FINDSTEAMMODSPATH_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\DetectOS.nsh"
!include "..\..\includes\functions\FindSteamRootPath.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrReplace.nsh"

Function _FindSteamModsPathInRegistry
    !insertmacro STACKFRAME_BEGIN 0 2
    StrCpy $R1 ""

    ReadRegStr $R0 HKCU "Software\Valve\Steam" "SourceModInstallPath"
    ${If} $R0 != ""
        !insertmacro STR_REPLACE "/" "\" $R0 $R1
        Goto _FindSteamModsPathInRegistry_end
    ${EndIf}

    ReadRegStr $R0 HKLM "Software\Valve\Steam" "SourceModInstallPath"
    ${If} $R0 != ""
        !insertmacro STR_REPLACE "/" "\" $R0 $R1
    ${EndIf}

    _FindSteamModsPathInRegistry_end:
    !insertmacro STACKFRAME_RETURN 0 2 $R1
    !insertmacro STACKFRAME_END 0 2
FunctionEnd

Function FindSteamModsPath
    !insertmacro STACKFRAME_BEGIN 0 1

    Call _FindSteamModsPathInRegistry
    Pop $R0

    ${If} $R0 == ""
        !insertmacro FIND_STEAM_ROOT_PATH $R0
        ${If} $R0 != ""
            StrCpy $R0 "$R0\steamapps\sourcemods"
        ${EndIf}
    ${EndIf}

    !insertmacro STACKFRAME_RETURN 0 1 $R0
    !insertmacro STACKFRAME_END 0 1
FunctionEnd

!ifmacrondef FIND_STEAM_MODS_PATH
    !macro FIND_STEAM_MODS_PATH RESULT
        Call FindSteamModsPath
        Pop ${RESULT}
    !macroend
!endif

!endif ; __FINDSTEAMMODSPATH_NSH__
