
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

!macro XDELTA3_GET
    DetailPrint " // Getting XDelta3"
    !insertmacro DOWNLOAD_2 "https://github.com/jmacd/xdelta-gpl/releases/download/v3.0.11/xdelta3-3.0.11-x86_64.exe.zip" \
                            "https://cdn2.mulderload.eu/g/_tools/xdelta3-3.0.11-x86_64.exe.zip" \
                            "$INSTDIR\@mulderload\xdelta3\xdelta3.zip" "d280cca0a52ce7e6da03bc2d27035a7b46b39c77"
    !insertmacro NSISUNZ_EXTRACT "$INSTDIR\@mulderload\xdelta3\xdelta3.zip" "$INSTDIR\@mulderload\xdelta3" "AUTO_DELETE"
    Rename "$INSTDIR\@mulderload\xdelta3\xdelta3-3.0.11-x86_64.exe" "$INSTDIR\@mulderload\xdelta3\xdelta3.exe"
!macroend

!macro XDELTA3_PATCH_FILE TARGET_FILE XDELTA3_FILE
    Push `${XDELTA3_FILE}`
    Push `${TARGET_FILE}`
    Call XDelta3PatchFile
!macroend

!macro XDELTA3_PATCH_FOLDER TARGET_FOLDER
    Push `${TARGET_FOLDER}`
    Call XDelta3PatchFolder
!macroend

!macro XDELTA3_REMOVE
    DetailPrint " // Removing XDelta3"
    Delete "$INSTDIR\@mulderload\xdelta3\xdelta3.exe"
    RMDir "$INSTDIR\@mulderload\xdelta3"
!macroend

Function XDelta3PatchFile
    !insertmacro STACKFRAME_BEGIN 2 0
    ; $0: target_file
    ; $1: xdelta3_file

    IfFileExists "$0.new" 0 +2
        Delete "$0.new"

    DetailPrint " // Patching $0 with XDelta3"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\xdelta3\xdelta3.exe" -d -s "$0" "$1" "$0.new"'

    IfFileExists "$0.new" 0 +4
        Delete "$0"
        Rename "$0.new" "$0"
        Delete "$1" ; delete the .xdelta file

    !insertmacro STACKFRAME_END 2 0
FunctionEnd

Function XDelta3PatchFolder
    !insertmacro STACKFRAME_BEGIN 1 5
    ; $0: folder to process
    ; $R0-$R4: scratch

    StrCpy $R0 "$0"

    ; Process .xdelta files in current directory
    StrCpy $R1 ""
    StrCpy $R2 ""
    ClearErrors
    FindFirst $R1 $R2 "$R0\*.xdelta"
    IfErrors XDelta3PatchFolder_noXdelta
        ${DoWhile} $R2 != ""
            ${GetBaseName} "$R2" $R3
            !insertmacro XDELTA3_PATCH_FILE "$R0\$R3" "$R0\$R2"
            FindNext $R1 $R2
        ${Loop}
        FindClose $R1
    XDelta3PatchFolder_noXdelta:

    ; Recurse into subdirectories
    StrCpy $R1 ""
    StrCpy $R2 ""
    ClearErrors
    FindFirst $R1 $R2 "$R0\*.*"
    IfErrors XDelta3PatchFolder_noEntries
        ${DoWhile} $R2 != ""
            ; skip "." and ".."
            StrCmp $R2 "." XDelta3PatchFolder_nextEntry
            StrCmp $R2 ".." XDelta3PatchFolder_nextEntry

            ; If it's a directory, Call recursively
            IfFileExists "$R0\$R2\*" 0 XDelta3PatchFolder_nextEntry
                Push "$R0\$R2"
                Call XDelta3PatchFolder

            XDelta3PatchFolder_nextEntry:
                FindNext $R1 $R2
        ${Loop}
        FindClose $R1
    XDelta3PatchFolder_noEntries:

    !insertmacro STACKFRAME_END 1 5
FunctionEnd
