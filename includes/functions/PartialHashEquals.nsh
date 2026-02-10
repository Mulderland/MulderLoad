!ifndef __PARTIALHASHEQUALS_NSH__
!define __PARTIALHASHEQUALS_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"

Function PartialHashEquals
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: partialSha1 (23 characters with *** in the middle)
    # $1: fullSha1
    # $R0-$R2: locals

    !insertmacro STR_RIGHT_EXPLODE "***" $0 $R0 $R1

    ${If} "$R0" == ""
    ${OrIf} "$R1" == ""
        StrCpy $R2 0
        Goto PartialHashEquals_end
    ${EndIf}

    !insertmacro STR_STARTS_WITH $1 $R0 $R2

    ${If} $R2 != 1
        StrCpy $R2 0
        Goto PartialHashEquals_end
    ${EndIf}

    !insertmacro STR_ENDS_WITH $1 $R1 $R2

    ${If} $R2 != 1
        StrCpy $R2 0
        Goto PartialHashEquals_end
    ${EndIf}

    StrCpy $R2 1

    PartialHashEquals_end:
    !insertmacro STACKFRAME_RETURN 2 3 $R2
    !insertmacro STACKFRAME_END 2 3
FunctionEnd

!ifmacrondef PARTIAL_HASH_EQUALS
    !macro PARTIAL_HASH_EQUALS PARTIAL_SHA1 FULL_SHA1 RESULT
        Push "${FULL_SHA1}"
        Push "${PARTIAL_SHA1}"
        Call PartialHashEquals
        Pop ${RESULT}
    !macroend
!endif

!endif ; __PARTIALHASHEQUALS_NSH__
