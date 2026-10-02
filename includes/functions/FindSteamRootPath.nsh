!ifndef __FINDSTEAMROOTPATH_NSH__
!define __FINDSTEAMROOTPATH_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\DetectOS.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrReplace.nsh"

Function _FindSteamRootPathInRegistry
    !insertmacro STACKFRAME_BEGIN 0 2
    StrCpy $R1 ""

    ReadRegStr $R0 HKCU "Software\Valve\Steam" "SteamPath"
    ${If} $R0 != ""
        !insertmacro STR_REPLACE "/" "\" $R0 $R1
        Goto _FindSteamRootPathInRegistry_end
    ${EndIf}

    ReadRegStr $R0 HKLM "Software\Valve\Steam" "SteamPath"
    ${If} $R0 != ""
        !insertmacro STR_REPLACE "/" "\" $R0 $R1
    ${EndIf}

    _FindSteamRootPathInRegistry_end:
    !insertmacro STACKFRAME_RETURN 0 2 $R1
    !insertmacro STACKFRAME_END 0 2
FunctionEnd

Function FindSteamRootPath
    !insertmacro STACKFRAME_BEGIN 0 2
    # $R0: temp
    # $R1: result

    Call _FindSteamRootPathInRegistry
    Pop $R0

    ${If} $R0 != ""
        StrCpy $R1 $R0
        Goto FindSteamRootPath_end
    ${EndIf}

    !insertmacro DETECT_OS $R0

    ${If} $R0 == "Linux"
        ReadEnvStr $R0 USERNAME
        ${If} ${FileExists} "Z:\home\$R0\.steam\root\steamapps\*.*"
            StrCpy $R1 "Z:\home\$R0\.steam\root"
        ${ElseIf} ${FileExists} "Z:\home\$R0\.steam\steam\steamapps\*.*"
            StrCpy $R1 "Z:\home\$R0\.steam\steam"
        ${ElseIf} ${FileExists} "Z:\home\$R0\.local\share\Steam\steamapps\*.*"
            StrCpy $R1 "Z:\home\$R0\.local\share\Steam"
        ${Else}
            Goto FindSteamRootPath_windows
        ${EndIf}
    ${Else}
        FindSteamRootPath_windows:
        ${If} ${FileExists} "C:\Program Files (x86)\Steam\steamapps\*.*"
            StrCpy $R1 "C:\Program Files (x86)\Steam"
        ${ElseIf} ${FileExists} "C:\Program Files\Steam\steamapps\*.*"
            StrCpy $R1 "C:\Program Files\Steam"
        ${Else}
            StrCpy $R1 ""
        ${EndIf}
    ${EndIf}

    FindSteamRootPath_end:
    !insertmacro STACKFRAME_RETURN 0 2 $R1
    !insertmacro STACKFRAME_END 0 2
FunctionEnd

!ifmacrondef FIND_STEAM_ROOT_PATH
    !macro FIND_STEAM_ROOT_PATH RESULT
        Call FindSteamRootPath
        Pop ${RESULT}
    !macroend
!endif

!endif ; __FINDSTEAMROOTPATH_NSH__
