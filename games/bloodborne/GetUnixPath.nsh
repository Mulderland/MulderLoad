# TODO: move to /includes/functions

Function GetUnixPath
    !insertmacro STACKFRAME_BEGIN 1 2
    # $0: Path in Windows format (example: H:\Games\Bloodborne)

    nsExec::ExecToStack '"C:\windows\system32\winepath.exe" -u "$0"'
    Pop $R0 ; exit code
    Pop $R1 ; result

    # Remove trailing newline
    !insertmacro STR_REPLACE "$\r$\n" "" $R1 $R1
    !insertmacro STR_REPLACE "$\n" "" $R1 $R1

    !insertmacro STACKFRAME_RETURN 1 2 $R1
    !insertmacro STACKFRAME_END 1 2
FunctionEnd

!ifmacrondef GET_UNIX_PATH
    !macro GET_UNIX_PATH WIN_PATH RESULT
        Push "${WIN_PATH}"
        Call GetUnixPath
        POP ${RESULT}
    !macroend
!endif
