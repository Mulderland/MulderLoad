!ifndef __GETNEXT3DIGIT_NSH__
!define __GETNEXT3DIGIT_NSH__

!include "..\..\includes\core\StackFrame.nsh"

Function GetNext3Digit
    !insertmacro STACKFRAME_BEGIN 1 3
    # $0: digit (example "001")

    # Split the digit in 3 variables
    StrCpy $R0 $0 1 2     ; units
    StrCpy $R1 $0 1 1     ; tens
    StrCpy $R2 $0 1 0     ; hundreds

    # Manual increment to avoid octal issues with leading zeros
    IntOp $R0 $R0 + 1
    StrCmp $R0 10 0 +6
        StrCpy $R0 0
        IntOp $R1 $R1 + 1
        StrCmp $R1 10 0 +3
            StrCpy $R1 0
            IntOp $R2 $R2 + 1

    # Concat the new digit
    StrCpy $R2 "$R2$R1$R0"

    !insertmacro STACKFRAME_RETURN 1 3 $R2
    !insertmacro STACKFRAME_END 1 3
FunctionEnd

!ifmacrondef GET_NEXT_3DIGIT
    !macro GET_NEXT_3DIGIT 3DIGIT RESULT
        Push "${3DIGIT}"
        Call GetNext3Digit
        Pop ${RESULT}
    !macroend
!endif

!endif ; __GETNEXT3DIGIT_NSH__
