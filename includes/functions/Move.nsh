!ifndef __MOVE_NSH__
!define __MOVE_NSH__

!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"

Function Move
    !insertmacro STACKFRAME_BEGIN 2 2
    # $0: source file
    # $1: destination file (must be an absolute path)

    !insertmacro STR_RIGHT_EXPLODE "\" $1 $R0 $R1
    CreateDirectory "$R0"
    Rename $0 $1

    !insertmacro STACKFRAME_END 2 2
FunctionEnd

!ifmacrondef MOVE
    !macro MOVE SOURCE DESTINATION
        Push "${DESTINATION}"
        Push "${SOURCE}"
        Call Move
    !macroend
!endif

!endif ; __MOVE_NSH__
