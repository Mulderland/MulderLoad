/*
This code is based on:
https://nsis.sourceforge.io/More_advanced_replace_text_in_file

Minor changes made:
- Reduced registers usage from 17 to 15 (scratch variables from 12 to 10) by reusing registers where possible.
  - Removed separate line copy variable (use $R2 directly, without using $7)
  - Removed $8 and reused $R8 for multiple temporary operations (chunk extraction, left part calculation)
- Renamed three non-R registers to R registers ($5 to $R7, $6 to $R8, $9 to $R9)
- Removed manual Exch/Push/Pop stack manipulation in favor of STACKFRAME_BEGIN / STACKFRAME_END
- Renamed function and macro for naming convention
- Renamed labels to follow naming convention: FunctionName_camelCase
- Fixed indentation to 4 spaces for consistency

fstOcc (first occurrence to be replaced):
- fstOcc = all behaves like fstOcc = 1
- If fstOcc > number of occurrences: the file is not modified
- fstOcc <= 0 leaves the file unchanged (regardless of nrOcc)

nrOcc (max number of occurrences replaced):
- nrOcc = all: replace while oldStr is found
- nrOcc > 0: replace up to nrOcc occurrences
- nrOcc <= 0 behaves like all

Search order: left-to-right and top-to-bottom.
replacementStr, oldStr and the read line should be < 1024 characters.
For NSIS Unicode, fileToModify must be UTF-8 encoded.
*/

!ifndef __FILESTRREPLACE_NSH__
!define __FILESTRREPLACE_NSH__

!include "..\..\includes\core\StackFrame.nsh"

Function FileStrReplace
    !insertmacro STACKFRAME_BEGIN 5 10
    # $0: fileToModify
    # $1: nrOcc (number of oldStr occurrences to replace, or "all")
    # $2: fstOcc (first occurrence to replace, or "all")
    # $3: replacementStr
    # $4: oldStr
    # $R0: temp file handle
    # $R1: input file handle
    # $R2: current line being processed
    # $R3: oldStr length
    # $R4: fstOcc counter
    # $R5: nrOcc counter
    # $R6: temp file path
    # $R7: cursor position
    # $R8: chunk extracted / temp calculation / left part
    # $R9: reconstructed line

    GetTempFileName $R6
    FileOpen $R1 "$0" r                         ; file to search in
    FileOpen $R0 "$R6" w                        ; temp file
    StrLen $R3 $4			                    ; the length of oldStr
    StrCpy $R4 0				                ; counter initialization
    StrCpy $R5 -1			                    ; counter initialization

    FileStrReplace_loopRead:
    ClearErrors
    IfErrors FileStrReplace_exit
    FileRead $R1 $R2 ; reading line
    IfErrors FileStrReplace_exit
    StrCpy $R7 -1
    StrLen $R8 $R2
    IntOp $R7 $R7 - $R8

    FileStrReplace_loopFilter:
    IntOp $R7 $R7 + 1
    StrCmp $R7 0 FileStrReplace_fileWrite
    StrCpy $R8 $R2 $R3 $R7
    StrCmp $R8 $4 0 FileStrReplace_loopFilter
    IntOp $R8 $R7 + $R3
    IntCmp $R8 0 FileStrReplace_yes FileStrReplace_no

    FileStrReplace_yes:
    StrCpy $R9 ""
    Goto FileStrReplace_done

    FileStrReplace_no:
    StrCpy $R9 $R2 "" $R8

    FileStrReplace_done:
    StrCpy $R8 $R2 $R7
    StrCpy $R9 $R8$3$R9
    IntOp $R4 $R4 + 1			                ; counter incrementation
    StrCmp $2 all FileStrReplace_followUp       ; exchange ok, then goes to search the next oldStr
    IntCmp $R4 $2 FileStrReplace_followUp	    ; FileStrReplace_no exchange until fstOcc has been reached,
    Goto FileStrReplace_loopFilter			    ; and then searching for the next oldStr

    FileStrReplace_followUp:
    IntOp $R4 $R4 - 1			                ; FileStrReplace_now counter is to be stuck to fstOcc
    IntOp $R5 $R5 + 1			                ; counter incrementation
    StrCmp $1 all FileStrReplace_exchangeOk     ; goes to exchange oldStr with replacementStr
    IntCmp $R5 $1 FileStrReplace_finalize	    ; proceeding exchange until nrOcc has been reached

    FileStrReplace_exchangeOk:
    IntOp $R7 $R7 + $R3 			            ; updating cursor
    StrCpy $R2 $R9
    Goto FileStrReplace_loopFilter

    FileStrReplace_finalize:
    IntOp $R5 $R5 - 1

    FileStrReplace_fileWrite:
    FileWrite $R0 $R2
    Goto FileStrReplace_loopRead

    FileStrReplace_exit:
    FileClose $R0
    FileClose $R1
    Delete "$0"
    Rename "$R6" "$0"

    !insertmacro STACKFRAME_END 5 10
FunctionEnd

!ifmacrondef FILE_STR_REPLACE
    !macro FILE_STR_REPLACE OLD_STR REPLACEMENT_STR FST_OCC NR_OCC FILE_TO_MODIFY
        Push "${OLD_STR}"
        Push "${REPLACEMENT_STR}"
        Push "${FST_OCC}"
        Push "${NR_OCC}"
        Push "${FILE_TO_MODIFY}"
        Call FileStrReplace
    !macroend
!endif

!endif ; __FILESTRREPLACE_NSH__
