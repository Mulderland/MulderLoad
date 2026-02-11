!include "LogicLib.nsh"

!macro CICDEC_GET
    DetailPrint " // Getting CicDec"
    !insertmacro DOWNLOAD_2 "https://github.com/Bioruebe/cicdec/releases/download/3.0.1/cicdec.zip" \
                            "https://cdn2.mulderload.eu/g/_tools/cicdec.zip" \
                            "$INSTDIR\@mulderload\cicdec\cicdec.zip" "218d04239535108ae52cb1b8b671a58ca552d4e5"
    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\cicdec\cicdec.zip" "$INSTDIR\@mulderload\cicdec" "Bio.cs.dll" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\cicdec\cicdec.zip" "$INSTDIR\@mulderload\cicdec" "cicdec.exe" ""
    !insertmacro NSISUNZ_EXTRACT_ONE "$INSTDIR\@mulderload\cicdec\cicdec.zip" "$INSTDIR\@mulderload\cicdec" "ICSharpCode.SharpZipLib.dll" "AUTO_DELETE"
!macroend

!macro CICDEC_UNPACK ARCHIVE_PATH TARGET_DIR AUTO_DELETE
    DetailPrint " // Unpacking ${ARCHIVE_PATH} with CicDec"
    nsExec::ExecToLog '"$INSTDIR\@mulderload\cicdec\cicdec.exe" "${ARCHIVE_PATH}" "${TARGET_DIR}"'

    ${If} "${AUTO_DELETE}" == "AUTO_DELETE"
        Delete "${ARCHIVE_PATH}"
    ${EndIf}
!macroend

!macro CICDEC_REMOVE
    DetailPrint " // Removing CicDec"
    RMDir /r "$INSTDIR\@mulderload\cicdec"
!macroend
