!ifndef __DELETERANGE_NSH__
!define __DELETERANGE_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

/*
TODOS:
- Handle *.partXX.rar
- Handle *.rar, *.r00...
*/

Function _GetNextFile
    !insertmacro STACKFRAME_BEGIN 1 2
    # $0: filePath (example: othername.7z.001)

    StrCpy $R0 $0 -3 ; base filePath (example: othername.7z.)

    StrCpy $R1 $0 3 -3      ; "001" (we use $1, could also use $0)
    IntOp  $R1 $R1 + 1      ; 2
    IntFmt $R1 "%03d" $R1   ; "002"

    !insertmacro STACKFRAME_RETURN 1 2 "$R0$R1" ; next filePath
    !insertmacro STACKFRAME_END 1 2
FunctionEnd

Function DeleteRange
    !insertmacro STACKFRAME_BEGIN 2 2
    # $0: filePath (ending with .001)
    # $1: nbParts

    StrCpy $R0 $0  ; current filePath
    StrCpy $R1 1   ; currentPart

    DeleteRange_loop:
        Delete "$R0"

        # Done?
        ${If} $R1 >= $1
            Goto DeleteRange_end
        ${EndIf}

        IntOp $R1 $R1 + 1 ; currentPart++

        # Get next filePath
        Push $R0
        Call _GetNextFile
        Pop $R0 ; next filePath

        Goto DeleteRange_loop

    DeleteRange_end:
    !insertmacro STACKFRAME_END 2 2
FunctionEnd

!ifmacrondef DELETE_RANGE
    !macro DELETE_RANGE FILE_PATH NB_PARTS
        Push "${NB_PARTS}"
        Push "${FILE_PATH}"
        Call DeleteRange
    !macroend
!endif

!endif
