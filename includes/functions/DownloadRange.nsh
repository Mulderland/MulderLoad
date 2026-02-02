!ifndef __DOWNLOADRANGE_NSH__
!define __DOWNLOADRANGE_NSH__

!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\Download.nsh"

/*
TODOS:
- Handle *.partXX.rar
- Handle *.rar, *.r00...
- Smarter mirror handling. Today, if part17 fails on server A, everything is redownloaded on server B.
*/

Function _GetNextUrl
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: url      (example: http://example.com/file.7z.001)
    # $1: filePath (example: othername.7z.001)

    StrCpy $R0 $0 -3 ; base url      (example: http://example.com/file.7z.)
    StrCpy $R1 $1 -3 ; base filePath (example: othername.7z.)

    StrCpy $R2 $1 3 -3      ; "001" (we use $1, could also use $0)
    IntOp  $R2 $R2 + 1      ; 2
    IntFmt $R2 "%03d" $R2   ; "002"

    !insertmacro STACKFRAME_RETURN 2 3 "$R1$R2" ; next filePath
    !insertmacro STACKFRAME_RETURN 2 3 "$R0$R2" ; next url
    !insertmacro STACKFRAME_END 2 3
FunctionEnd

!ifmacrondef _GET_NEXT_URL
    !macro _GET_NEXT_URL URL FILE_PATH
        Push "${FILE_PATH}"
        Push "${URL}"
        Call _GetNextUrl
        Pop ${URL}       ; next url (last returned)
        Pop ${FILE_PATH} ; next filePath (first returned)
    !macroend
!endif

Function DownloadRange
    !insertmacro STACKFRAME_BEGIN 4 5
    # $0: url (ending with .001)
    # $1: filePath (ending with .001)
    # $2: expectedHash (only for the .001 file)
    # $3: nbParts
    # Returns: 1 on success, 0 on failure

    StrCpy $R0 $0  ; current url
    StrCpy $R1 $1  ; current filePath
    StrCpy $R2 $2  ; expected hash (part 1 only)
    StrCpy $R3 1   ; currentPart
    StrCpy $R4 1   ; result (optimistic)

    # Guard: nbParts must be >= 1
    ${If} $3 < 1
        StrCpy $R4 0
        Goto DownloadRange_end
    ${EndIf}

    DownloadRange_loop:
        # Download(currentUrl, currentFilePath, expectedHashForThisPart) -> $R4
        !insertmacro _DOWNLOAD $R0 $R1 $R2 $R4

        ${If} $R4 != 1
            StrCpy $R4 0
            Goto DownloadRange_end
        ${EndIf}

        # Done?
        ${If} $R3 >= $3
            Goto DownloadRange_end
        ${EndIf}

        # Next part
        IntOp $R3 $R3 + 1
        StrCpy $R2 ""  ; no expected hash for parts > 1

        # _GetNext(url, filePath) -> (nextUrl, nextFilePath)
        !insertmacro _GET_NEXT_URL $R0 $R1

        Goto DownloadRange_loop

    DownloadRange_end:
    !insertmacro STACKFRAME_RETURN 4 5 $R4
    !insertmacro STACKFRAME_END 4 5
FunctionEnd

!ifmacrondef _DOWNLOAD_RANGE
    !macro _DOWNLOAD_RANGE URL FILE_PATH EXPECTED_HASH NB_PARTS
        Push "${NB_PARTS}"
        Push "${EXPECTED_HASH}"
        Push "${FILE_PATH}"
        Push "${URL}"
        Call DownloadRange
        Pop $0
    !macroend
!endif

!ifmacrondef DOWNLOAD_RANGE_1
    !macro DOWNLOAD_RANGE_1 URL1 FILE_PATH EXPECTED_HASH NB_PARTS
        !insertmacro _DOWNLOAD_RANGE "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" "${NB_PARTS}"
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, aborting..."
            Abort
        ${EndIf}
    !macroend
!endif

!ifmacrondef DOWNLOAD_RANGE_2
    !macro DOWNLOAD_RANGE_2 URL1 URL2 FILE_PATH EXPECTED_HASH NB_PARTS
        !insertmacro _DOWNLOAD_RANGE "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" "${NB_PARTS}"
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, trying alternative URL..."
            !insertmacro DOWNLOAD_RANGE_1 "${URL2}" "${FILE_PATH}" "${EXPECTED_HASH}" "${NB_PARTS}"
        ${EndIf}
    !macroend
!endif

!ifmacrondef DOWNLOAD_RANGE_3
    !macro DOWNLOAD_RANGE_3 URL1 URL2 URL3 FILE_PATH EXPECTED_HASH NB_PARTS
        !insertmacro _DOWNLOAD_RANGE "${URL1}" "${FILE_PATH}" "${EXPECTED_HASH}" "${NB_PARTS}"
        ${If} $0 != 1
            MessageBox MB_ICONEXCLAMATION "Download or hash check failed for ${FILE_PATH}, trying alternative URL..."
            !insertmacro DOWNLOAD_RANGE_2 "${URL2}" "${URL3}" "${FILE_PATH}" "${EXPECTED_HASH}" "${NB_PARTS}"
        ${EndIf}
    !macroend
!endif

!endif ; __DOWNLOADRANGE_NSH__
