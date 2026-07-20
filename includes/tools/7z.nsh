!include "LogicLib.nsh"

!macro 7Z_GET
    DetailPrint " // Getting 7z"
    !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/dependencies/7z/7z-v26.02.zip" \
                            "https://raw.githubusercontent.com/Mulderland/MulderLoad/refs/heads/main/build/binaries/7z-v26.02.zip" \
                            "$INSTDIR\@mulderload\7z\7z.zip" \
                            "591e5377407ce18b4f9f8ed67c7d5b4e42a81821"

    !insertmacro NSISUNZ_EXTRACT "$INSTDIR\@mulderload\7z\7z.zip" "$INSTDIR\@mulderload\7z" "AUTO_DELETE"

    !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/dependencies/7z/Iso7z-v1.8.7.zip" \
                            "https://www.tc4shell.com/binary/Iso7z.zip" \
                            "$INSTDIR\@mulderload\7z\Iso7z.zip" \
                            "8af613c248dbb2360c84bbcee4352fbcf62b7b8d"

    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\7z\Iso7z.zip" "$INSTDIR\@mulderload\7z\Formats" "Iso7z.64.dll" "AUTO_DELETE"
!macroend

!macro 7Z_EXTRACT ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    DetailPrint " // Extracting ${ARCHIVE_PATH} with 7z"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\7z\7z.exe" x -aoa -o"${TARGET_DIR}" "${ARCHIVE_PATH}"'

    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

# similar to /noextractpath /file
!macro 7Z_EXTRACT_ONE ARCHIVE_PATH TARGET_DIR FILE_PATH AUTO_DELETE
    DetailPrint " // Partially extracting ${ARCHIVE_PATH} with 7z"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\7z\7z.exe" e -aoa -o"${TARGET_DIR}" "${ARCHIVE_PATH}" "${FILE_PATH}"'

    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro 7Z_REMOVE
    DetailPrint " // Removing 7z"
    RMDir /r "$INSTDIR\@mulderload\7z"
!macroend
