!ifndef __DOWNLOAD_NSH__
!define __DOWNLOAD_NSH__

!include "LogicLib.nsh"
!include "WordFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\ExpandUrls.nsh"
!include "..\..\includes\functions\FileHashEquals.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"

!ifmacrondef _IS_MULDERLOAD
    !macro _IS_MULDERLOAD URL RESULT
        Push "${URL}"
        Call _IsMulderLoad
        Pop ${RESULT}
    !macroend
!endif

Function Download
    !insertmacro STACKFRAME_BEGIN 3 6
    # $0: urls list (separated by |)
    # $1: filePath
    # $2: expectedHash (can be "")
    # $R0: current url index
    # $R1: current url value
    # $R2: temporary status (nscurl / hash)
    # $R3: expanded urls list (separated by |)
    # $R4: _isMulderLoad
    # $R5: result (OK, ERR_DOWNLOAD, ERR_HASH)

    !insertmacro EXPAND_URLS $0 $R3
    StrCpy $R0 1
    StrCpy $R5 "ERR_DOWNLOAD"

    Download_loop:
        ClearErrors
        ${WordFind} "$R3" "|" "E+$R0" $R1
        ${If} ${Errors}         ; no more url found (or single url case)
            ${If} $R0 == 1      ; handle single url input
                StrCpy $R1 "$0"
            ${Else}
                Goto Download_end
            ${EndIf}
        ${EndIf}

        DetailPrint " // Downloading $R1"

        !insertmacro _IS_MULDERLOAD $R1 $R4
        ${If} $R4 == 1
            NScurl::http GET "$R1" "$1" /HEADER "Mld-Key: $%MULDERLOAD_KEY%" /CONNECTTIMEOUT 10s /INSIST /RESUME /CANCEL /END
        ${Else}
            NScurl::http GET "$R1" "$1" /CONNECTTIMEOUT 10s /INSIST /RESUME /CANCEL /END
        ${EndIf}
        Pop $R2 ; nscurl status

        ${If} "$R2" != "OK"
            DetailPrint "Failed: $R1"
            Delete "$1" ; necessary or a failed download due to a 403 will leave another file, not a partial file that can be resumed
            Goto Download_next
        ${EndIf}

        ${If} "$2" == ""
            StrCpy $R5 "OK"
            Goto Download_end
        ${EndIf}

        DetailPrint " // Validating $1"
        !insertmacro FILE_HASH_EQUALS "$1" "$2" $R2

        ${If} $R2 == 1
            StrCpy $R5 "OK"
            Goto Download_end
        ${Else}
            StrCpy $R5 "ERR_HASH"
            DetailPrint "Hash mismatch for '$R1'"
            Delete "$1" ; delete corrupted file
        ${EndIf}

    Download_next:
        IntOp $R0 $R0 + 1
        Goto Download_loop

    Download_end:
        !insertmacro STACKFRAME_RETURN 3 6 $R5
        !insertmacro STACKFRAME_END 3 6
FunctionEnd

Function _IsMulderLoad
    !insertmacro STACKFRAME_BEGIN 1 2
    # $0: url
    # $R0: local
    # $R1: result

    StrCpy $R1 0

    !insertmacro STR_STARTS_WITH "$0" "https://cdn.mulderload.eu/" $R0
    ${If} $R0 == 1
        StrCpy $R1 1
        Goto _IsMulderLoad_done
    ${EndIf}

    !insertmacro STR_STARTS_WITH "$0" "https://redirect.mulderland.com/" $R0
    ${If} $R0 == 1
        StrCpy $R1 1
        Goto _IsMulderLoad_done
    ${EndIf}

    !insertmacro STR_STARTS_WITH "$0" "https://redirecf.mulderload.eu/" $R0
    ${If} $R0 == 1
        StrCpy $R1 1
        Goto _IsMulderLoad_done
    ${EndIf}

    !insertmacro STR_STARTS_WITH "$0" "https://cdn.de.mulderland.com/" $R0
    ${If} $R0 == 1
        StrCpy $R1 1
        Goto _IsMulderLoad_done
    ${EndIf}

    !insertmacro STR_STARTS_WITH "$0" "https://redirect.de.mulderland.com/" $R0
    ${If} $R0 == 1
        StrCpy $R1 1
        Goto _IsMulderLoad_done
    ${EndIf}

    _IsMulderLoad_done:
        !insertmacro STACKFRAME_RETURN 1 2 $R1
        !insertmacro STACKFRAME_END 1 2
FunctionEnd

!ifmacrondef _DOWNLOAD
    !macro _DOWNLOAD URLS FILE_PATH EXPECTED_HASH
        Push "${EXPECTED_HASH}"
        Push "${FILE_PATH}"
        Push "${URLS}"
        Call Download
        Pop $0

        ${If} $0 == "ERR_DOWNLOAD"
            MessageBox MB_ICONSTOP "Download failed for ${FILE_PATH}, aborting..."
            Abort
        ${ElseIf} $0 == "ERR_HASH"
            MessageBox MB_ICONSTOP "Incorrect hash for ${FILE_PATH}, aborting..."
            Abort
        ${EndIf}
    !macroend
!endif

!ifmacrondef DOWNLOAD_1
    !macro DOWNLOAD_1 URL1 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}"
    !macroend
!endif

!ifmacrondef DOWNLOAD_2
    !macro DOWNLOAD_2 URL1 URL2 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}|${URL2}" "${FILE_PATH}" "${EXPECTED_HASH}"
    !macroend
!endif

!ifmacrondef DOWNLOAD_3
    !macro DOWNLOAD_3 URL1 URL2 URL3 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}|${URL2}|${URL3}" "${FILE_PATH}" "${EXPECTED_HASH}"
    !macroend
!endif

!endif ; __DOWNLOAD_NSH__
