!macro UNSHIELD_GET
    DetailPrint " // Getting Unshield"
    !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/g1dnl1mvl64u2u3/unshield-1.5.1.7z/file" \
                            "https://cdn1.mulderload.eu/games/_tools/unshield-1.5.1.7z" \
                            "$INSTDIR\@mulderload\unshield\unshield.7z" "c3ff078e0016d423476437edfdfbdb9ac7ef19a7"
    !insertmacro NSIS7Z_EXTRACT "$INSTDIR\@mulderload\unshield\unshield.7z" "$INSTDIR\@mulderload\unshield" "AUTO_DELETE"
!macroend

!macro UNSHIELD_UNPACK ARCHIVE_PATH TARGET_DIR
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with Unshield"

    # Backup registers
    Push $R0
    Push $R1
    Push $R2

    # Save OutPath to $R0
    StrCpy $R0 "$OUTDIR"

    # Get archive directory in $R1, archive name in $R2
    !insertmacro STR_RIGHT_EXPLODE "\" "${ARCHIVE_PATH}" $R1 $R2

    # Unpack
    SetOutPath $R1
    nsExec::ExecToLog '"$INSTDIR\@mulderload\unshield\unshield.exe" -d "${TARGET_DIR}" x "$R2"'
    Pop $R1

    # Restore OutPath
    SetOutPath "$R0"

    # Restore registers
    Pop $R2
    Pop $R1
    Pop $R0
!macroend

!macro UNSHIELD_REMOVE
    DetailPrint " // Removing Unshield"
    RMDir /r "$INSTDIR\@mulderload\unshield"
!macroend
