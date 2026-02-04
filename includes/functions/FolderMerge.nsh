!ifndef __FOLDERMERGE_NSH__
!define __FOLDERMERGE_NSH__

!include "LogicLib.nsh"
!include "FileFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"

/*
Merge source folder into target folder (source files overwrite target)
After merge, source folder is deleted
Handles case where source is a subfolder of target
*/
Function FolderMerge
    !insertmacro STACKFRAME_BEGIN 2 3
    # $0: sourceFolder
    # $1: targetFolder
    # $R0: sourceFolder (normalized)
    # $R1: targetFolder (normalized)
    # $R2: temp
    
    DetailPrint " // Merging folder '$0' into '$1'"

    # Normalize paths (remove trailing backslash)
    StrCpy $R0 "$0"
    StrCpy $R1 "$1"

    StrCpy $R2 "$R0" 1 -1
    ${If} "$R2" == "\"
        StrCpy $R0 "$R0" -1
    ${EndIf}

    StrCpy $R2 "$R1" 1 -1
    ${If} "$R2" == "\"
        StrCpy $R1 "$R1" -1
    ${EndIf}

    # Create target directory structure first
    Push $R6
    Push $R7
    Push $R8
    Push $R9
    ${Locate} "$R0" "/L=D" "_FolderMerge_CreateDir"

    # Move all files (overwrite)
    ${Locate} "$R0" "/L=F /S=" "_FolderMerge_MoveFile"
    Pop $R9
    Pop $R8
    Pop $R7
    Pop $R6

    # Delete source folder (should be empty now)
    RMDir /r "$R0"

    !insertmacro STACKFRAME_END 2 3
FunctionEnd

# Callback: create directory structure in target
Function _FolderMerge_CreateDir
    ${If} "$R6" == ""
        Push $2
        StrLen $2 "$R0"
        StrCpy $2 $R9 "" $2
        CreateDirectory "$R1$2"
        Pop $2
    ${EndIf}
    Push $R1
FunctionEnd

# Callback: move file to target (overwrite if exists)
Function _FolderMerge_MoveFile
    Push $2
    Push $3
    # Calculate relative path
    StrLen $2 "$R0"
    StrCpy $2 $R9 "" $2
    StrCpy $3 "$R1$2"
    # Delete target if exists, then rename (move)
    ${If} ${FileExists} "$3"
        Delete "$3"
    ${EndIf}
    Rename "$R9" "$3"
    Pop $3
    Pop $2
    Push $R1
FunctionEnd

# Warning: Use full paths for arguments, and no trailing backslash
!ifmacrondef FOLDER_MERGE
    !macro FOLDER_MERGE SOURCE_FOLDER TARGET_FOLDER
        Push "${TARGET_FOLDER}"
        Push "${SOURCE_FOLDER}"
        Call FolderMerge
    !macroend
!endif

!endif ; __FOLDERMERGE_NSH__
