!ifndef __STRCOUNT_NSH__
!define __STRCOUNT_NSH__

!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\FindSteamGamePath.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"

Function StrCount
    !insertmacro STACKFRAME_BEGIN 2 5
    # $0: haystack (input string)
    # $1: needle (substring to count)
    # $R0: input length
    # $R1: search length
    # $R2: position
    # $R3: extracted string
    # $R4: count

    StrCpy $R4 0

    ${If} "$1" == ""
        Goto StrCount_end
    ${EndIf}

    StrLen $R0 $0
    StrLen $R1 $1
    IntOp $R2 $R0 - $R1

    StrCount_loop:
    ${If} $R2 < 0
        Goto StrCount_end
    ${EndIf}

    StrCpy $R3 $0 $R1 $R2
    ${If} "$R3" == "$1"
        IntOp $R4 $R4 + 1
        IntOp $R2 $R2 - $R1
    ${Else}
        IntOp $R2 $R2 - 1
    ${EndIf}

    Goto StrCount_loop

    StrCount_end:
    !insertmacro STACKFRAME_RETURN 2 5 $R4
    !insertmacro STACKFRAME_END 2 5
FunctionEnd

!ifmacrondef STR_COUNT
    !macro STR_COUNT HAYSTACK NEEDLE RESULT
        Push "${NEEDLE}"
        Push "${HAYSTACK}"
        Call StrCount
        Pop ${RESULT}
    !macroend
!endif

!endif ; __STRCOUNT_NSH__
