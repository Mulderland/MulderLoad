!include "LogicLib.nsh"

!macro INNOEXTRACT_GET
    DetailPrint " // Getting InnoExtract"
    !insertmacro DOWNLOAD_2 "https://github.com/dscharrer/innoextract/releases/download/1.9/innoextract-1.9-windows.zip" \
                            "https://cdn2.mulderload.eu/g/_tools/innoextract-1.9-windows.zip" \
                            "$INSTDIR\@mulderload\innoextract\innoextract.zip" "ed06aeebf5ed1a7851a314e2524dab1bed072ca3"
    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\innoextract\innoextract.zip" "$INSTDIR\@mulderload\innoextract" "innoextract.exe" "AUTO_DELETE"
!macroend

# Note: require full paths
!macro INNOEXTRACT_UNPACK ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with InnoExtract"

    ; Backup $0 and OutPath
    Push $0
    StrCpy $0 "$OUTDIR"

    ; Unpack
    SetOutPath "$INSTDIR\@mulderload\innoextract\tmp"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\innoextract\innoextract.exe" -c0 -p0 -q "${ARCHIVE_PATH}"'
    !insertmacro FOLDER_MERGE "$INSTDIR\@mulderload\innoextract\tmp\app" "${TARGET_DIR}"
    RMDir /r "$INSTDIR\@mulderload\innoextract\tmp"

    ; Restore OutPath and $0
    SetOutPath "$0"
    Pop $0

    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro INNOEXTRACT_REMOVE
    DetailPrint " // Removing InnoExtract"
    RMDir /r "$INSTDIR\@mulderload\innoextract"
!macroend
