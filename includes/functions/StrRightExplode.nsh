!ifndef __STRRIGHTEXPLODE_NSH__
!define __STRRIGHTEXPLODE_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Function StrRightExplode
    !insertmacro STACKFRAME_BEGIN 2 6
    # $0: delimiter
    # $1: input
    # $R0: delimiter length
    # $R1: input length
    # $R2: search position
    # $R3: extracted substring
    # $R4: left result
    # $R5: right result

    # Edge case: empty delimiter
    ${If} "$0" == ""
        StrCpy $R4 $1
        StrCpy $R5 ""
        Goto StrRightExplode_end
    ${EndIf}

    StrLen $R0 $0
    StrLen $R1 $1
    IntOp $R2 $R1 - $R0  ; Start at last possible position

    StrRightExplode_loop:
    ${If} $R2 < 0
        StrCpy $R4 $1
        StrCpy $R5 ""
        Goto StrRightExplode_end
    ${EndIf}

    StrCpy $R3 $1 $R0 $R2
    ${If} "$R3" == "$0"
        StrCpy $R4 $1 $R2              ; Left part
        IntOp $R2 $R2 + $R0            ; Skip delimiter
        StrCpy $R5 $1 "" $R2           ; Right part (from position to end)
        Goto StrRightExplode_end
    ${EndIf}

    IntOp $R2 $R2 - 1
    Goto StrRightExplode_loop

    StrRightExplode_end:
    !insertmacro STACKFRAME_RETURN 2 6 $R5
    !insertmacro STACKFRAME_RETURN 2 6 $R4
    !insertmacro STACKFRAME_END 2 6
FunctionEnd

!ifmacrondef STR_RIGHT_EXPLODE
    !macro STR_RIGHT_EXPLODE DELIMITER INPUT LEFT_RESULT RIGHT_RESULT
        Push "${INPUT}"
        Push "${DELIMITER}"
        Call StrRightExplode
        Pop ${LEFT_RESULT}
        Pop ${RIGHT_RESULT}
    !macroend
!endif

!endif ; __STRRIGHTEXPLODE_NSH__
