!include "LogicLib.nsh"

!macro 7Z_IMAGE_EXTRACT ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    Push $0

    !insertmacro STR_ENDS_WITH "${ARCHIVE_PATH}" ".bin" $0
    ${If} $0 == 1
        !insertmacro 7Z_EXTRACT "${ARCHIVE_PATH}" "${TARGET_DIR}" "${AUTO_DELETE}"
        !insertmacro STR_RESOLVE_FILENAME "${ARCHIVE_PATH}" 0 $0
        !insertmacro 7Z_EXTRACT "${TARGET_DIR}\$0.iso" "${TARGET_DIR}" "AUTO_DELETE" ; always delete the temporary .iso
    ${Else}
        !insertmacro 7Z_EXTRACT "${ARCHIVE_PATH}" "${TARGET_DIR}" "${AUTO_DELETE}"
    ${EndIf}

    Pop $0
!macroend

!macro NSIS7Z_EXTRACT ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    DetailPrint " // Extracting ${ARCHIVE_PATH}"

    ; Backup $0 and OutPath
    Push $0
    StrCpy $0 "$OUTDIR"

    ; Extract
    SetOutPath "${TARGET_DIR}"
    Nsis7z::ExtractWithDetails "${ARCHIVE_PATH}" "Extracting package %s..."

    ; Restore OutPath and $0
    SetOutPath "$0"
    Pop $0

    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro NSISUNZ_EXTRACT ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    DetailPrint " // Extracting ${ARCHIVE_PATH}"
    nsisunz::Unzip "${ARCHIVE_PATH}" "${TARGET_DIR}"
    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro NSISUNZ_EXTRACT_ONE ARCHIVE_PATH TARGET_DIR FILE_PATH AUTO_DELETE
    DetailPrint " // Partially extracting ${ARCHIVE_PATH}"
    nsisunz::Unzip /noextractpath /file "${FILE_PATH}" "${ARCHIVE_PATH}" "${TARGET_DIR}"
    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro FORCE_RENAME OLD_PATH NEW_PATH
    IfFileExists `${OLD_PATH}` 0 +4
        IfFileExists `${NEW_PATH}` 0 +2
            Delete `${NEW_PATH}`
        Rename `${OLD_PATH}` `${NEW_PATH}`
!macroend

!macro FORCE_COPY OLD_PATH NEW_PATH
    IfFileExists `${OLD_PATH}` 0 +4
        IfFileExists `${NEW_PATH}` 0 +2
            Delete `${NEW_PATH}`
        CopyFiles `${OLD_PATH}` `${NEW_PATH}`
!macroend

!macro DOWNLOAD_DGVOODOO2
    Push $R0
    ReadRegStr $R0 HKCU "Software\Wine" ""
    ${If} $R0 != ""
        DetailPrint " // DgVoodoo2: Wine/Proton detected, download v2.81.3 (old compatible version)"
        !insertmacro DOWNLOAD_2 "https://www.mediafire.com/file_premium/xkpacrm7c27bwhp/dgVoodoo2_81_3.zip/file" \
                                "https://cdn2.mulderload.eu/g/_common/dgVoodoo2_81_3.zip" \
                                "dgVoodoo2.zip" "0b04c7d621192425c595badfc60c12060017738c"
    ${Else}
        DetailPrint " // DgVoodoo2: Windows detected, download v2.86.5 (latest version)"
        !insertmacro DOWNLOAD_2 "https://github.com/dege-diosg/dgVoodoo2/releases/download/v2.86.5/dgVoodoo2_86_5.zip" \
                                "https://cdn2.mulderload.eu/g/_common/dgVoodoo2_86_5.zip" \
                                "dgVoodoo2.zip" "4942e9af65f5204f576a444ff73a765cad6b8e28"
    ${EndIf}
    Pop $R0
!macroend
