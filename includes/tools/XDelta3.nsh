
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\misc\CommonMacros.nsh"

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
    !insertmacro STACKFRAME_BEGIN 2 2
    # $0: target_file
    # $1: xdelta3_file

    ${If} ${FileExists} "$0.new"
        Delete "$0.new"
    ${EndIf}

    DetailPrint " // Patching $0 with $1"
    nsExec::ExecToStack '"$INSTDIR\@mulderload\xdelta3\xdelta3.exe" -d -s "$0" "$1" "$0.new"'
    Pop $R0
    Pop $R1

    ${If} $R0 = 0
        !insertmacro FORCE_RENAME "$0.new" "$0" ; replace original file with the patched one
    ${Else}
        MessageBox MB_ICONEXCLAMATION "Error $R0 when patching $0$\r$\n$\r$\nDetails: $R1"
        Delete "$0.new" ; delete the failed (probably doesn't exist, it's just in case)
    ${EndIf}

    Delete "$1" ; delete the .xdelta file

    !insertmacro STACKFRAME_END 2 2
FunctionEnd

Function XDelta3PatchFolder
    !insertmacro STACKFRAME_BEGIN 1 3
    # $0 = folder du patch
    # $R0 = handle FindFirst / FindNext
    # $R1-2 = temp

    FindFirst $R0 $R1 "$0\*.xdelta"
    ${DoWhile} $R1 != ""
        # full path of the .xdelta file
        StrCpy $R2 "$0\$R1"
        Push $R2

        # full path of the target file (remove .xdelta, 7 chars)
        StrCpy $R2 "$0\$R1" -7
        Push $R2

        Call XDelta3PatchFile
        FindNext $R0 $R1
    ${Loop}
    FindClose $R0

    FindFirst $R0 $R1 "$0\*"
    ${DoWhile} $R1 != ""
        ${If} $R1 != "."
        ${AndIf} $R1 != ".."
            StrCpy $R2 "$0\$R1"
            ${If} ${FileExists} "$R2\*" ; if it's a folder
                Push $R2
                Call XDelta3PatchFolder
            ${EndIf}
        ${EndIf}
        FindNext $R0 $R1
    ${Loop}
    FindClose $R0

    !insertmacro STACKFRAME_END 1 3
FunctionEnd
