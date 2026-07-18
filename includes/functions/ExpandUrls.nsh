!ifndef __EXPANDURLS_NSH__
!define __EXPANDURLS_NSH__

!include "LogicLib.nsh"
!include "WordFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrContains.nsh"
!include "..\..\includes\functions\StrReplace.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"

Function ExpandUrls
    !insertmacro STACKFRAME_BEGIN 1 4
    # $0: urls list (separated by |)
    # $R0: current url index
    # $R1: current url value
    # $R2: temporary boolean
    # $R3: expanded urls list (separated by |)

    StrCpy $R0 1
    StrCpy $R3 ""

    ExpandUrls_loop:
        ClearErrors
        ${WordFind} "$0" "|" "E+$R0" $R1

        ${If} ${Errors}         ; no more url found (or single url case)
            ${If} $R0 == 1      ; handle single url input
                StrCpy $R1 "$0"
            ${Else}
                Goto ExpandUrls_done
            ${EndIf}
        ${EndIf}

    !insertmacro STR_STARTS_WITH $R1 "https://cdn.mulderload.eu/" $R2
    ${If} $R2 == 1
        Push $R1
        Call _ExpandUrlCdn
        Pop $R1
        Goto ExpandUrls_append
    ${EndIf}

    !insertmacro STR_STARTS_WITH $R1 "https://www.moddb.com/" $R2
    ${If} $R2 == 1
        Push $R1
        Call _ExpandUrlRedirect
        Pop $R1
        Goto ExpandUrls_append
    ${EndIf}

    !insertmacro STR_STARTS_WITH $R1 "https://www.nexusmods.com/" $R2
    ${If} $R2 == 1
        Push $R1
        Call _ExpandUrlRedirect
        Pop $R1
        Goto ExpandUrls_append
    ${EndIf}

    !insertmacro STR_STARTS_WITH $R1 "https://community.pcgamingwiki.com/" $R2
    ${If} $R2 == 1
        Push $R1
        Call _ExpandUrlRedirect
        Pop $R1
        Goto ExpandUrls_append
    ${EndIf}

    ; no expansion, keep original URL in $R1

    ExpandUrls_append:
        ${If} $R3 == ""
            StrCpy $R3 "$R1"
        ${Else}
            StrCpy $R3 "$R3|$R1"
        ${EndIf}

        IntOp $R0 $R0 + 1
        Goto ExpandUrls_loop

    ExpandUrls_done:
        !insertmacro STACKFRAME_RETURN 1 4 $R3
        !insertmacro STACKFRAME_END 1 4
FunctionEnd

Function _ExpandUrlCdn
    !insertmacro STACKFRAME_BEGIN 1 2
    ; $0: url input
    ; $R0: local
    ; $R1: return value

    !insertmacro STR_REPLACE "https://cdn.mulderload.eu/" "https://cdn.de.mulderload.eu/" "$0" $R0
    StrCpy $R1 "$0|$R0"

    !insertmacro STACKFRAME_RETURN 1 2 $R1
    !insertmacro STACKFRAME_END 1 2
FunctionEnd

Function _ExpandUrlRedirect
    !insertmacro STACKFRAME_BEGIN 1 4
    ; $0: url input
    ; $R0-R2: locals
    ; $R3: return value

    !insertmacro STR_REPLACE "https://" "https://redirect.mulderload.eu/" "$0" $R0
    !insertmacro STR_REPLACE "https://" "https://redirecf.mulderload.eu/" "$0" $R1
    !insertmacro STR_REPLACE "https://" "https://redirect.de.mulderload.eu/" "$0" $R2
    StrCpy $R3 "$R0|$R1|$R2"

    !insertmacro STACKFRAME_RETURN 1 4 $R3
    !insertmacro STACKFRAME_END 1 4
FunctionEnd

!ifmacrondef EXPAND_URLS
    !macro EXPAND_URLS URLS RESULT
        Push "${URLS}"
        Call ExpandUrls
        Pop ${RESULT}
    !macroend
!endif

!endif ; __EXPANDURLS_NSH__
