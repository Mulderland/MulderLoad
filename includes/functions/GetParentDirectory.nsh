!ifndef __GETPARENTDIRECTORY_NSH__
!define __GETPARENTDIRECTORY_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"

Function GetParentDirectory
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: full path
    # $1: number of parents to go up
    # $R0: left part
    # $R1: right part
    # $R2: result

    StrCpy $R2 $0

    ; Remove trailing backslashes
    GetParentDirectory_trim:
    StrCpy $R0 $R2 1 -1
    ${If} "$R0" != "\"
        Goto GetParentDirectory_loop
    ${EndIf}

    StrCpy $R2 $R2 -1
    Goto GetParentDirectory_trim

    GetParentDirectory_loop:
    ${If} $1 <= 0
        Goto GetParentDirectory_end
    ${EndIf}

    !insertmacro STR_RIGHT_EXPLODE "\" "$R2" $R0 $R1
    StrCpy $R2 $R0

    IntOp $1 $1 - 1
    Goto GetParentDirectory_loop

    GetParentDirectory_end:
    !insertmacro STACKFRAME_RETURN 2 3 $R2
    !insertmacro STACKFRAME_END 2 3
FunctionEnd


!ifmacrondef GET_PARENT_DIRECTORY
    !macro GET_PARENT_DIRECTORY PATH NB_PARENTS RESULT
        Push "${NB_PARENTS}"
        Push "${PATH}"
        Call GetParentDirectory
        Pop ${RESULT}
    !macroend
!endif

!endif ; __GETPARENTDIRECTORY_NSH__
