!ifndef __FILESTRCONTAINS_NSH__
!define __FILESTRCONTAINS_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrContains.nsh"

Function FileStrContains
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: fileToRead
    # $1: needle
    # $R0: temp file handle
    # $R1: current line
    # $R2: result of StrContains / final result

    StrCpy $R2 "0"

    FileOpen $R0 "$0" r
    IfErrors FileStrContains_end

    FileStrContains_loop:
        ClearErrors
        FileRead $R0 $R1
        IfErrors FileStrContains_close

        !insertmacro STR_CONTAINS "$R1" "$1" $R2

        ${If} $R2 == "1"
            Goto FileStrContains_close
        ${EndIf}

        Goto FileStrContains_loop

    FileStrContains_close:
        FileClose $R0

    FileStrContains_end:
        !insertmacro STACKFRAME_RETURN 2 3 $R2
        !insertmacro STACKFRAME_END 2 3
FunctionEnd

!ifmacrondef FILE_STR_CONTAINS
    !macro FILE_STR_CONTAINS FILE_TO_READ NEEDLE RESULT
        Push "${NEEDLE}"
        Push "${FILE_TO_READ}"
        Call FileStrContains
        Pop ${RESULT}
    !macroend
!endif

!endif ; __FILESTRCONTAINS_NSH__
