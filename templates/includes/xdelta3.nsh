!macro XDelta3_ApplyPatches DIR
    ; Preserve caller registers
    Push $0
    Push $1
    Push $2
    Push $3

    ; Put starting dir in $0 and call the recursive function
    StrCpy $0 "${DIR}"
    Call XDelta3_ApplyPatches_Rec

    Pop $3
    Pop $2
    Pop $1
    Pop $0
!macroend

Function XDelta3_ApplyPatches_Rec
    ; Preserve registers used by this function
    Push $0
    Push $1
    Push $2
    Push $3
    Push $4
    Push $5

    ; $0 is expected to contain the directory to process
    StrCpy $1 "$0" ; local base dir in $1

    ; Process .xdelta files in current directory
    FindFirst $2 $3 "$1\*.xdelta"
    ${DoWhile} $3 != ""
        ${GetBaseName} "$3" $4
        DetailPrint "Patching: $4 with $3"
        nsExec::ExecToLog '"$INSTDIR\xdelta3.exe" -d -s "$1\$4" "$1\$3" "$1\$4.new"'

        IfFileExists "$1\$4.new" 0 +4
            Delete "$1\$4"
            Rename "$1\$4.new" "$1\$4"
            Delete "$1\$3" ; delete the .xdelta file

        FindNext $2 $3
    ${Loop}
    FindClose $2

    ; Recurse into subdirectories
    FindFirst $2 $3 "$1\*.*"
    ${DoWhile} $3 != ""
        ; skip "." and ".."
        StrCmp $3 "." skipEntry
        StrCmp $3 ".." skipEntry

        ; If it's a directory, Call recursively
        IfFileExists "$1\$3\*" 0 skipEntry
            StrCpy $0 "$1\$3"
            Call XDelta3_ApplyPatches_Rec
        skipEntry:
        FindNext $2 $3
    ${Loop}
    FindClose $2

    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Pop $0
FunctionEnd
