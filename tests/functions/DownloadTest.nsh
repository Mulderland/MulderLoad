!include "WordFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\ExpandUrls.nsh"
!include "..\..\tests\runner\TestMacros.nsh"

# The real Download function is not easily testable, so let's do a similar function with the same loop
Function DownloadLite
    !insertmacro STACKFRAME_BEGIN 3 6
    # $0: urls list (separated by |)
    # $1: filePath
    # $2: -
    # $R0: current url index
    # $R1: current url value
    # $R2: -
    # $R3: expanded urls list (separated by |)
    # $R4 -
    # $R5: result (number of iteration)

    !insertmacro EXPAND_URLS $0 $R3
    StrCpy $R0 1
    StrCpy $R5 0

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

        IntOp $R5 $R5 + 1
        Goto Download_next

    Download_next:
        IntOp $R0 $R0 + 1
        Goto Download_loop

    Download_end:
        !insertmacro STACKFRAME_RETURN 3 6 $R5
        !insertmacro STACKFRAME_END 3 6
FunctionEnd

!macro DOWNLOAD_LITE URLS FILE_PATH RESULT
    Push ""
    Push "${FILE_PATH}"
    Push "${URLS}"
    Call DownloadLite
    Pop ${RESULT}
!macroend

Section "Download"
    DetailPrint " // Download classic"
    !insertmacro DOWNLOAD_LITE "https://www.classic.com/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 1 ; classic

    DetailPrint " // Download cdn"
    !insertmacro DOWNLOAD_LITE "https://cdn.mulderload.eu/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 2 ; cdn + cdn.de

    DetailPrint " // Download moddb"
    !insertmacro DOWNLOAD_LITE "https://www.moddb.com/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 3 ; redirect + redirect.cf + redirect.de

    DetailPrint " // Download classic, cdn"
    !insertmacro DOWNLOAD_LITE "https://www.classic.com/games/a-game/a-file.7z|https://cdn.mulderload.eu/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 3 ; classic + cdn + cdn.de

    DetailPrint " // Download cdn, classic"
    !insertmacro DOWNLOAD_LITE "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://www.classic.com/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 3 ; cdn + cdn.de + classic

    DetailPrint " // Download cdn, moddb"
    !insertmacro DOWNLOAD_LITE "https://cdn.mulderload.eu/games/a-game/a-file.7z|https://www.moddb.com/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 5 ; cdn + cdn.de + redirect + redirect.cf + redirect.de

    DetailPrint " // Download moddb, classic"
    !insertmacro DOWNLOAD_LITE "https://www.moddb.com/games/a-game/a-file.7z|https://cdn.mulderload.eu/games/a-game/a-file.7z" "a-file.7z" $0
    !insertmacro ASSERT_EQUALS $0 5 ; redirect + redirect.cf + redirect.de + cdn + cdn.de
SectionEnd
