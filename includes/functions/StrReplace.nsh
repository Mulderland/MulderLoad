!ifndef __STRREPLACE_NSH__
!define __STRREPLACE_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Function StrReplace
    !insertmacro STACKFRAME_BEGIN 3 4
    # $0: search
    # $1: replacement
    # $2: haystack
    # $R0-$R3: locals

    ${If} "$0" == ""
        StrCpy $R3 $2
        Goto StrReplace_end
    ${EndIf}

    ${If} "$2" == ""
        StrCpy $R3 ""
        Goto StrReplace_end
    ${EndIf}
    
    StrLen $R0 $0          ; search length
    StrCpy $R3 ""          ; result accumulator
    StrCpy $R1 $2          ; remaining to scan

    StrReplace_loop:
    ${If} "$R1" == ""
        Goto StrReplace_end
    ${EndIf}

    StrCpy $R2 $R1 $R0
    ${If} "$R2" == "$0"
        StrCpy $R3 "$R3$1"
        StrCpy $R1 $R1 "" $R0
    ${Else}
        StrCpy $R2 $R1 1
        StrCpy $R3 "$R3$R2"
        StrCpy $R1 $R1 "" 1
    ${EndIf}
    Goto StrReplace_loop

    StrReplace_end:
    !insertmacro STACKFRAME_RETURN 3 4 $R3
    !insertmacro STACKFRAME_END 3 4
FunctionEnd

!ifmacrondef STR_REPLACE
    !macro STR_REPLACE SEARCH REPLACEMENT HAYSTACK RESULT
        Push "${HAYSTACK}"
        Push "${REPLACEMENT}"
        Push "${SEARCH}"
        Call StrReplace
        Pop ${RESULT}
    !macroend
!endif

!endif ; __STRREPLACE_NSH__
