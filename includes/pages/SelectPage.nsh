!ifndef __SELECT_PAGE_NSH__
!define __SELECT_PAGE_NSH__

!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\FindSteamGamePath.nsh"
!include "..\..\includes\functions\GetParentDirectory.nsh"
!include "..\..\includes\functions\StrCount.nsh"

Var /GLOBAL SELECT_FILENAME         ; The filename to select (e.g. "AlphaProtocol.exe")
Var /GLOBAL SELECT_INSTALL_PATH     ; The default install path to use as the initial directory in the file dialog (e.g. "C:\GOG\Alpha Protocol")
Var /GLOBAL SELECT_RELATIVE_PATH    ; The relative path from the install path to the executable (e.g. "Binaries" if the executable is in a "Binaries" subfolder). Can be "" or omitted. WARNING: NO STARTING OR TRAILING SLASHES!
Var /GLOBAL SELECT_STEAM_FOLDER     ; The Steam folder name to search for. If found, it takes precedence over SELECT_INSTALL_PATH

Function SelectPage
    !insertmacro STACKFRAME_BEGIN 0 2
    # $R0: hwnd of the page
    # $R1: hwnd of the browse button

    # Create the page
    nsDialogs::Create 1018
    Pop $R0

    # Disable the next button
    GetDlgItem $R0 $HWNDPARENT 1
    EnableWindow $R0 0

    # Create the browse button
    ${NSD_CreateBrowseButton} 20% 40% 60% 16u "Click to localize $SELECT_FILENAME"
    Pop $R1

    # Assign SelectFileDialog to the browse button
    GetFunctionAddress $R0 SelectFileDialog
    nsDialogs::OnClick $R1 $R0

    # Show the page
    nsDialogs::Show

    !insertmacro STACKFRAME_END 0 2
FunctionEnd

Function SuggestDirectory
    !insertmacro STACKFRAME_BEGIN 0 2
    # $R0: temporary variable
    # $R1: result

    StrCpy $R1 ""

    ${If} $SELECT_STEAM_FOLDER != ""
        !insertmacro FIND_STEAM_GAME_PATH $SELECT_STEAM_FOLDER $R1
        ${If} $R1 != ""
            Goto SuggestDirectory_end
        ${Else}
            !insertmacro DETECT_OS $R0
            ${If} $R0 == "Linux"
                ReadEnvStr $R0 USERNAME
                StrCpy $R1 "Z:\run\media\$R0" ; Game was not found, but it may be installed on an external drive.
                Goto SuggestDirectory_end
            ${EndIf}
        ${EndIf}
    ${EndIf}

    ${If} $SELECT_INSTALL_PATH != ""
        StrCpy $R1 $SELECT_INSTALL_PATH
    ${EndIf}

    SuggestDirectory_end:
    !insertmacro STACKFRAME_RETURN 0 2 $R1
    !insertmacro STACKFRAME_END 0 2
FunctionEnd

Function GetRootDirectory
    !insertmacro STACKFRAME_BEGIN 1 3
    # $0: full path to the executable
    # $R0: parent count
    # $R1: separator count
    # $R2: result

    ${If} "$SELECT_RELATIVE_PATH" == ""
        StrCpy $R0 1
    ${Else}
        !insertmacro STR_COUNT "$SELECT_RELATIVE_PATH" "\" $R1
        IntOp $R0 $R1 + 2
    ${EndIf}

    !insertmacro GET_PARENT_DIRECTORY "$0" $R0 $R2

    !insertmacro STACKFRAME_RETURN 1 3 $R2
    !insertmacro STACKFRAME_END 1 3
FunctionEnd

Function SelectFileDialog
    !insertmacro STACKFRAME_BEGIN 0 2

    Call SuggestDirectory
    Pop $R0

    nsDialogs::SelectFileDialog open "$R0\$SELECT_RELATIVE_PATH" "$SELECT_FILENAME|$SELECT_FILENAME"
    Call GetRootDirectory
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
        Push 1 ; Success by default
    FunctionEnd
!endif

!endif ; __SELECT_PAGE_NSH__
