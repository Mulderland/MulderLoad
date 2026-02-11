!macro WISEUNPACKER_GET
    DetailPrint " // Getting WiseUnpacker"
    !insertmacro DOWNLOAD_2 "https://github.com/mnadareski/WiseUnpacker/releases/download/2.1.0/WiseUnpacker_2.1.0_net10.0_win-x64_release.zip" \
                            "https://cdn2.mulderload.eu/g/_tools/WiseUnpacker_2.1.0_net10.0_win-x64_release.zip" \
                            "$INSTDIR\@mulderload\wiseunpacker\WiseUnpacker.zip" "ed48824a640692948ffb53f5ef29bbfa290f8a2d"
    !insertmacro NSISUNZ_EXTRACT "$INSTDIR\@mulderload\wiseunpacker\WiseUnpacker.zip" "$INSTDIR\@mulderload\wiseunpacker" "AUTO_DELETE"
!macroend

!macro WISEUNPACKER_UNPACK ARCHIVE_PATH TARGET_DIR
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with WiseUnpacker"

    nsExec::ExecToLog '"$INSTDIR\@mulderload\wiseunpacker\wiseunpacker.exe" -x -o="${ARCHIVE_PATH}_unpacked" "${ARCHIVE_PATH}"'
    !insertmacro FOLDER_MERGE "${ARCHIVE_PATH}_unpacked\MAINDIR" "${TARGET_DIR}"
!macroend

!macro WISEUNPACKER_REMOVE
    DetailPrint " // Removing WiseUnpacker"
    RMDir /r "$INSTDIR\@mulderload\wiseunpacker"
!macroend
