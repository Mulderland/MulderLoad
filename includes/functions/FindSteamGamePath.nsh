!ifndef __FINDSTEAMGAMEPATH_NSH__
!define __FINDSTEAMGAMEPATH_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\DetectOS.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrReplace.nsh"

Function FindSteamGamePath
    !insertmacro STACKFRAME_BEGIN 1 2
    # $0: gameFolderName
    # $R0: temp
    # $R1: result

    !insertmacro DETECT_OS $R0

    ${If} $R0 == "Linux"
        ReadEnvStr $R1 STEAM_APP_PATH
        ${If} $R1 != ""
            # Installer launched with ProtonTricks
            !insertmacro STR_ENDS_WITH $R1 $0 $R0
            ${If} $R0 = 0
                MessageBox MB_ICONEXCLAMATION "Invalid ProtonTricks prefix$\r$\n$\r$\nPlease quit and restart using Wine, or choose the correct ProtonTricks prefix."
                Quit
            ${EndIf}
            !insertmacro STR_REPLACE "/" "\" $R1 $R1
            StrCpy $R1 "Z:$R1"
        ${Else}
            # Installer launcher with Wine
            ReadEnvStr $R0 USERNAME
            ${If} ${FileExists} "Z:\home\$R0\.steam\root\steamapps\common\$0\*.*"
                StrCpy $R1 "Z:\home\$R0\.steam\root\steamapps\common\$0"
            ${ElseIf} ${FileExists} "Z:\home\$R0\.steam\steam\steamapps\common\$0\*.*"
                StrCpy $R1 "Z:\home\$R0\.steam\steam\steamapps\common\$0"
            ${ElseIf} ${FileExists} "Z:\home\$R0\.local\share\Steam\steamapps\common\$0\*.*"
                StrCpy $R1 "Z:\home\$R0\.local\share\Steam\steamapps\common\$0"
            ${Else}
                Goto FindSteamPath_windows
            ${EndIf}
        ${EndIf}
    ${Else}
        # Installer launched with Windows (or Wine)
        FindSteamPath_windows:
        ${If} ${FileExists} "C:\Program Files (x86)\steam\steamapps\common\$0\*.*"
            StrCpy $R1 "C:\Program Files (x86)\steam\steamapps\common\$0"
        ${ElseIf} ${FileExists} "C:\Program Files\steam\steamapps\common\$0\*.*"
            StrCpy $R1 "C:\Program Files\steam\steamapps\common\$0"
        ${ElseIf} ${FileExists} "D:\steamapps\common\$0\*.*"
            StrCpy $R1 "D:\steamapps\common\$0"
        ${ElseIf} ${FileExists} "D:\Games\steamapps\common\$0\*.*"
            StrCpy $R1 "D:\Games\steamapps\common\$0"
        ${ElseIf} ${FileExists} "D:\SteamLibrary\steamapps\common\$0\*.*"
            StrCpy $R1 "D:\SteamLibrary\steamapps\common\$0"
        ${ElseIf} ${FileExists} "E:\steamapps\common\$0\*.*"
            StrCpy $R1 "E:\steamapps\common\$0"
        ${ElseIf} ${FileExists} "E:\Games\steamapps\common\$0\*.*"
            StrCpy $R1 "E:\Games\steamapps\common\$0"
        ${ElseIf} ${FileExists} "E:\SteamLibrary\steamapps\common\$0\*.*"
            StrCpy $R1 "E:\SteamLibrary\steamapps\common\$0"
        ${ElseIf} ${FileExists} "F:\steamapps\common\$0\*.*"
            StrCpy $R1 "F:\steamapps\common\$0"
        ${ElseIf} ${FileExists} "F:\Games\steamapps\common\$0\*.*"
            StrCpy $R1 "F:\Games\steamapps\common\$0"
        ${ElseIf} ${FileExists} "F:\SteamLibrary\steamapps\common\$0\*.*"
            StrCpy $R1 "F:\SteamLibrary\steamapps\common\$0"
        ${Else}
            StrCpy $R1 ""
        ${EndIf}
    ${EndIf}

    !insertmacro STACKFRAME_RETURN 1 2 $R1
    !insertmacro STACKFRAME_END 1 2
FunctionEnd

!ifmacrondef FIND_STEAM_GAME_PATH
    !macro FIND_STEAM_GAME_PATH FOLDER_NAME RESULT
        Push "${FOLDER_NAME}"
        Call FindSteamGamePath
        Pop ${RESULT}
    !macroend
!endif

!endif ; __FINDSTEAMGAMEPATH_NSH__
