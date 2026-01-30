!ifndef __FILEHASHEQUALS_NSH__
!define __FILEHASHEQUALS_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Function FileHashEquals
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: filePath
    # $1: expectedHash
    # $R0-R2: locals (result in $R2)

    StrLen $R0 $1 ; Get length of expected hash

    ${If} $R0 == 40
        NScurl::sha1 -file "$0"
        Pop $R1
    ${ElseIf} $R0 == 32
        NScurl::md5 -file "$0"
        Pop $R1
    ${ElseIf} $R0 == 23
        NScurl::sha1 -file "$0"
        Pop $R1
        # TODO
        StrCpy $R2 0 ; false
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Unsupported hash length: $R0"
        StrCpy $R2 0 ; false
        Goto FileHashEquals_end
    ${EndIf}

    ${If} "$R1" == "$1"
        StrCpy $R2 1 ; true
    ${Else}
        StrCpy $R2 0 ; false
    ${EndIf}

    FileHashEquals_end:
    !insertmacro STACKFRAME_RETURN 2 3 $R2
    !insertmacro STACKFRAME_END 2 3
FunctionEnd

!ifmacrondef FILE_HASH_EQUALS
    !macro FILE_HASH_EQUALS FILE_PATH EXPECTED_HASH RESULT
        Push "${EXPECTED_HASH}"
        Push "${FILE_PATH}"
        Call FileHashEquals
        Pop ${RESULT}
    !macroend
!endif

!endif ; __FILEHASHEQUALS_NSH__
