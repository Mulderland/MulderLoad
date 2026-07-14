!macro I6COMP_GET
    DetailPrint " // Getting I6Comp Unpacker"
    !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/dependencies/i6comp/i6comp02.zip" \
                            "https://www.sac.sk/download/pack/i6comp02.zip" \
                            "$INSTDIR\@mulderload\i6comp\i6comp02.zip" \
                            "d42bc9b2f7aa035a966320ed5ae8f38b8049c104"

    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\i6comp\i6comp02.zip" "$INSTDIR\@mulderload\i6comp" "Release\i6comp.exe" "AUTO_DELETE"
!macroend

!macro I6COMP_UNPACK ARCHIVE_PATH TARGET_DIR
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with I6Comp"

    # Backup $0 and OutPath
    Push $0
    StrCpy $0 "$OUTDIR"

    # Unpack
    SetOutPath "${TARGET_DIR}"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\i6comp\i6comp.exe" x "${ARCHIVE_PATH}"'

    # Restore OutPath and $0
    SetOutPath "$0"
    Pop $0
!macroend

!macro I6COMP_REMOVE
    DetailPrint " // Removing I6Comp"
    Delete "$INSTDIR\@mulderload\i6comp\i6comp.exe"
    RMDir "$INSTDIR\@mulderload\i6comp"
!macroend
