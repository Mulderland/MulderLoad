!ifndef __CREATEJUNCTION_NSH__
!define __CREATEJUNCTION_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Function CreateJunction
    !insertmacro STACKFRAME_BEGIN 2 1
    # $0: junctionPath
    # $1: targetPath
    # $R0: return value (1 = success, 0 = failure)

    RMDir "$0" ; Can delete a junction or an empty folder (not a file, not a non-empty folder)

    ${If} ${FileExists} "$0"
        MessageBox MB_ICONEXCLAMATION "Cannot create junction because this path already exists:$\r$\n$\r$\n$0"
        StrCpy $R0 0
        Goto CreateJunction_end
    ${EndIf}

    CreateDirectory "$1"

    nsExec::Exec 'cmd /c mklink /J "$0" "$1"'
    Pop $R0

    ${If} $R0 != 0
        MessageBox MB_ICONEXCLAMATION "Cannot create junction:$\r$\nJunction: $0$\r$\nTarget: $1$\r$\n$\r$\nError code: $R0"
        StrCpy $R0 0
    ${Else}
        StrCpy $R0 1
    ${EndIf}

    CreateJunction_end:
    !insertmacro STACKFRAME_RETURN 2 1 $R0
    !insertmacro STACKFRAME_END 2 1
FunctionEnd

!ifmacrondef CREATE_JUNCTION
    !macro CREATE_JUNCTION JUNCTION_PATH TARGET_PATH RESULT
        Push "${TARGET_PATH}"
        Push "${JUNCTION_PATH}"
        Call CreateJunction
        Pop "${RESULT}"
    !macroend
!endif

!endif ; __CREATEJUNCTION_NSH__
