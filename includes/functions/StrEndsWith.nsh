!ifndef __STRENDSWITH_NSH__
!define __STRENDSWITH_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Function StrEndsWith
    !insertmacro STACKFRAME_BEGIN 2 1
    # $0: haystack
    # $1: needle
    # $R0: locals

    StrLen $R0 $1

    StrCpy $R0 "$0" $R0 -$R0

    ${If} "$R0" == "$1"
        StrCpy $R0 "1"
    ${Else}
        StrCpy $R0 "0"
    ${EndIf}

    !insertmacro STACKFRAME_RETURN 2 1 $R0
    !insertmacro STACKFRAME_END 2 1
FunctionEnd

!ifmacrondef STR_ENDS_WITH
    !macro STR_ENDS_WITH HAYSTACK NEEDLE RESULT
        Push "${NEEDLE}"
        Push "${HAYSTACK}"
        Call StrEndsWith
        Pop ${RESULT}
    !macroend
!endif

!endif ; __STRENDSWITH_NSH__
