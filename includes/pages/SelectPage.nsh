!ifndef __SELECT_PAGE_NSH__
!define __SELECT_PAGE_NSH__

!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\FindSteamGamePath.nsh"

Var BROWSE_BUTTON

Var /GLOBAL SELECT_FILENAME         ; The filename to select (e.g. "AlphaProtocol.exe")
Var /GLOBAL SELECT_INSTALL_PATH     ; The default install path to use as the initial directory in the file dialog (e.g. "C:\GOG\Alpha Protocol")
Var /GLOBAL SELECT_RELATIVE_PATH    ; The relative path from the install path to the executable (e.g. "Binaries" if the executable is in a "Binaries" subfolder). Can be "" or omitted
Var /GLOBAL SELECT_STEAM_FOLDER     ; The Steam folder name to search for. If found, it takes precedence over SELECT_INSTALL_PATH

Function SelectPage
    !insertmacro STACKFRAME_BEGIN 0 1

    nsDialogs::Create 1018
    Pop $R0

    # Disable Next button
    GetDlgItem $R0 $HWNDPARENT 1
    EnableWindow $R0 0

    ${NSD_CreateBrowseButton} 20% 40% 60% 16u "Click to localize $SELECT_FILENAME"
    Pop $BROWSE_BUTTON
    GetFunctionAddress $R0 SelectFileDialog
    nsDialogs::OnClick $BROWSE_BUTTON $R0

    nsDialogs::Show

    !insertmacro STACKFRAME_END 0 1
FunctionEnd

Function DetectGamePath
    !insertmacro STACKFRAME_BEGIN 0 1

    StrCpy $R0 ""
    ${If} $SELECT_STEAM_FOLDER != ""
        !insertmacro FIND_STEAM_GAME_PATH $SELECT_STEAM_FOLDER $R0
        ${If} $R0 != ""
            Goto DetectGamePath_end
        ${EndIf}
    ${EndIf}

    ${If} $SELECT_INSTALL_PATH != ""
        StrCpy $R0 $SELECT_INSTALL_PATH
    ${EndIf}

    DetectGamePath_end:
    !insertmacro STACKFRAME_RETURN 0 1 $R0
    !insertmacro STACKFRAME_END 0 1
FunctionEnd

Function SelectFileDialog
    !insertmacro STACKFRAME_BEGIN 0 2

    Call DetectGamePath
    Pop $R0

    nsDialogs::SelectFileDialog open "$R0\$SELECT_RELATIVE_PATH" "$SELECT_FILENAME|$SELECT_FILENAME"
    Call GetParent
    Pop $R0

    ${If} "$R0" != ""
        StrCpy $INSTDIR "$R0"

        Call OnSelectedFile
        Pop $R0 ; 1 if success, 0 if error

        # Enable or Re-disable Next button
        GetDlgItem $R1 $HWNDPARENT 1
        EnableWindow $R1 $R0
    ${EndIf}

    !insertmacro STACKFRAME_END 0 2
FunctionEnd

!ifndef ON_SELECTED_FILE
    Function OnSelectedFile
        !insertmacro STACKFRAME_BEGIN 0 0
        !insertmacro STACKFRAME_RETURN 0 0 1
        !insertmacro STACKFRAME_END 0 0
    FunctionEnd
!endif

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
