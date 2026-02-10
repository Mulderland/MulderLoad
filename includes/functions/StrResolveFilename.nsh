!ifndef __STRRESOLVEFILENAME_NSH__
!define __STRRESOLVEFILENAME_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"

Function _StrRemoveExtension
    !insertmacro STACKFRAME_BEGIN 1 2
    # $0: filename
    # $R0-$R1: locals

    # Edge case: file without name (example .dockerignore)
    !insertmacro STR_STARTS_WITH $0 "." $R0
    ${If} $R0 == 1
        StrCpy $R0 ""
        Goto _StrRemoveExtension_end
    ${EndIf}

    !insertmacro STR_RIGHT_EXPLODE "." $0 $R0 $R1

    # If no . found ($R1 empty), return filename as-is (example: "Dockerfile")
    ${If} "$R1" == ""
        StrCpy $R0 $0
    ${EndIf}

    _StrRemoveExtension_end:
    !insertmacro STACKFRAME_RETURN 1 2 $R0
    !insertmacro STACKFRAME_END 1 2
FunctionEnd

# Resolve the filename from a full path
# If keep_extension = 1, return filename with extension
# If keep_extension = 0, return filename without last extension
Function StrResolveFilename
    !insertmacro STACKFRAME_BEGIN 2 2
    # $0: fullPath
    # $1: keepExtension (1 = keep, 0 = remove)
    # $R0: locals
    # $R1: result

    # Check last character for slash
    StrCpy $R0 $0 1 -1
    ${If} "$R0" == "\"
    ${OrIf} "$R0" == "/"
        StrCpy $R1 ""
        Goto StrResolveFilename_end
    ${EndIf}

    # Extract filename
    !insertmacro STR_RIGHT_EXPLODE "\" $0 $R0 $R1
    ${If} "$R1" == ""
        !insertmacro STR_RIGHT_EXPLODE "/" $0 $R0 $R1
    ${EndIf}
    ${If} "$R1" == ""
        StrCpy $R1 $0
    ${EndIf}

    # Remove extension if requested
    ${If} $1 == 0
        Push $R1
        Call _StrRemoveExtension
        Pop $R1
    ${EndIf}

    StrResolveFilename_end:
    !insertmacro STACKFRAME_RETURN 2 2 $R1
    !insertmacro STACKFRAME_END 2 2
FunctionEnd

!ifmacrondef STR_RESOLVE_FILENAME
    !macro STR_RESOLVE_FILENAME FULL_PATH KEEP_EXTENSION RESULT
        Push "${KEEP_EXTENSION}"
        Push "${FULL_PATH}"
        Call StrResolveFilename
        Pop ${RESULT}
    !macroend
!endif

!endif ; __STRRESOLVEFILENAME_NSH__
