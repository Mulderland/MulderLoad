!ifndef __SELECT_PAGE_NSH__
!define __SELECT_PAGE_NSH__

!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"

Var BROWSE_BUTTON

Var /GLOBAL SELECT_FILENAME
Var /GLOBAL SELECT_DEFAULT_FOLDER
Var /GLOBAL SELECT_RELATIVE_INSTDIR

Function SelectPage
    nsDialogs::Create 1018
    Pop $0

    # Disable Next button
    GetDlgItem $0 $HWNDPARENT 1
    EnableWindow $0 0

    ${NSD_CreateBrowseButton} 20% 40% 60% 16u "Click to localize $SELECT_FILENAME"
    Pop $BROWSE_BUTTON
    GetFunctionAddress $0 SelectFileDialog
    nsDialogs::OnClick $BROWSE_BUTTON $0

    nsDialogs::Show
FunctionEnd

Function SelectFileDialog
    nsDialogs::SelectFileDialog open "$SELECT_DEFAULT_FOLDER\" "$SELECT_FILENAME|$SELECT_FILENAME"
    Call GetParent
    Pop $R0

    # Re-enable Next button
    ${If} "$R0" != ""
        GetDlgItem $0 $HWNDPARENT 1
        EnableWindow $0 1
    ${EndIf}

    StrCpy $INSTDIR "$R0\$SELECT_RELATIVE_INSTDIR"
FunctionEnd

# https://nsis.sourceforge.io/Get_parent_directory
Function GetParent
    !insertmacro STACKFRAME_BEGIN 1 3
    # $0: path
    # $R0: index
    # $R1: length
    # $R2: char

    StrCpy $R0 0
    StrLen $R1 $0

    GetParent_loop:
    IntOp $R0 $R0 + 1
    IntCmp $R0 $R1 GetParent_get 0 GetParent_get
    StrCpy $R2 $0 1 -$R0
    StrCmp $R2 "\" GetParent_get
    Goto GetParent_loop

    GetParent_get:
    StrCpy $0 $0 -$R0

    !insertmacro STACKFRAME_RETURN 1 3 $0
    !insertmacro STACKFRAME_END 1 3
FunctionEnd

!endif ; __SELECT_PAGE_NSH__
