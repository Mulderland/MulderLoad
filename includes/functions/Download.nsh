!ifndef __DOWNLOAD_NSH__
!define __DOWNLOAD_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\FileHashEquals.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"

Function Download
    !insertmacro STACKFRAME_BEGIN 3 2
    # $0: url
    # $1: filePath
    # $2: expectedHash (can be "")
    # $R0-R1: scratch (result in $R1)

    !insertmacro STR_STARTS_WITH $0 "https://www.moddb.com/" $R0
    ${If} $R0 == 1
        !insertmacro STR_RIGHT_EXPLODE "/" $0 $R0 $R1
        NScurl::http GET "https://redirect.mulderload.eu/moddb/$R1" "$1" /HEADER "X-API-Key: $%MLD_REDIRECT_API_KEY%" /INSIST /RESUME /CANCEL /END
    ${Else}
        !insertmacro STR_STARTS_WITH $0 "https://community.pcgamingwiki.com/files/file/" $R0
        ${If} $R0 == 1
            !insertmacro STR_RIGHT_EXPLODE "/file/" $0 $R0 $R1
            !insertmacro STR_RIGHT_EXPLODE "/#" $R0 $R0 $R1
            NScurl::http GET "https://redirect.mulderload.eu/pcgw/$R0/$R1" "$1" /HEADER "X-API-Key: $%MLD_REDIRECT_API_KEY%" /INSIST /RESUME /CANCEL /END
        ${Else}
            NScurl::http GET "$0" "$1" /INSIST /RESUME /CANCEL /END
        ${EndIf}
    ${EndIf}
    Pop $R0

    # Download failed
    ${If} "$R0" != "OK"
        Delete "$1" ; necessary or a failed download due to a 403 will leave another file, not a partial file that can be resumed
        StrCpy $R1 0
        Goto Download_end
    ${EndIf}

    # No hash to check
    ${If} "$2" == ""
        StrCpy $R1 1
        Goto Download_end
    ${EndIf}

    # Check hash
    !insertmacro FILE_HASH_EQUALS "$1" "$2" $R0
    ${If} $R0 != 1
        MessageBox MB_ICONEXCLAMATION "Hash check failed for downloaded file: $1"
        StrCpy $R1 0
        Goto Download_end
    ${EndIf}

    StrCpy $R1 1

    Download_end:
    !insertmacro STACKFRAME_RETURN 3 2 $R1
    !insertmacro STACKFRAME_END 3 2
FunctionEnd

!ifmacrondef _DOWNLOAD
    !macro _DOWNLOAD URL FILE_PATH EXPECTED_HASH RESULT
        Push "${EXPECTED_HASH}"
        Push "${FILE_PATH}"
        Push "${URL}"
        Call Download
        Pop ${RESULT}
    !macroend
!endif

!ifmacrondef DOWNLOAD_1
    !macro DOWNLOAD_1 URL1 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" $0
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, aborting..."
            Abort
        ${EndIf}
    !macroend
!endif

!ifmacrondef DOWNLOAD_2
    !macro DOWNLOAD_2 URL1 URL2 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" $0
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, trying alternative URL..."
            !insertmacro DOWNLOAD_1 "${URL2}" "${FILE_PATH}" "${EXPECTED_HASH}"
        ${EndIf}
    !macroend
!endif

!ifmacrondef DOWNLOAD_3
    !macro DOWNLOAD_3 URL1 URL2 URL3 FILE_PATH EXPECTED_HASH
        !insertmacro _DOWNLOAD "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" $0
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, trying alternative URL..."
            !insertmacro DOWNLOAD_2 "${URL2}" "${URL3}" "${FILE_PATH}" "${EXPECTED_HASH}"
        ${EndIf}
    !macroend
!endif

!endif ; __DOWNLOAD_NSH__
