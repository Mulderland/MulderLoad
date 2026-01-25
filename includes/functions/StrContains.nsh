!ifndef __STRCONTAINS_NSH__
!define __STRCONTAINS_NSH__

!include "LogicLib.nsh"
!include "StrFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"

${StrStr}

Function StrContains
    !insertmacro STACKFRAME_BEGIN 2 1
    # $0: haystack
    # $1: needle
    # $R0: locals

    ${If} "$1" == ""
        StrCpy $R0 "1"
        Goto StrContains_end
    ${EndIf}

    ${StrStr} $R0 $0 $1

    ${If} $R0 == ""
        StrCpy $R0 "0"
    ${Else}
        StrCpy $R0 "1"
    ${EndIf}

    StrContains_end:
    !insertmacro STACKFRAME_RETURN 2 1 $R0
    !insertmacro STACKFRAME_END 2 1
FunctionEnd

!ifmacrondef STR_CONTAINS
    !macro STR_CONTAINS HAYSTACK NEEDLE RESULT
        Push "${NEEDLE}"
        Push "${HAYSTACK}"
        Call StrContains
        Pop ${RESULT}
    !macroend
!endif

!endif ; __STRCONTAINS_NSH__
