!include "nsDialogs.nsh"
!include "LogicLib.nsh"

!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\StrContains.nsh"

!define BYOF_COUNTER 0

!macro BYOF_DEFINE LABEL SEARCH_PATTERN HASHES
    !define BYOF_LABEL_${BYOF_COUNTER} "${LABEL}" ; Make label findable by ID (int) in BYOF_PAINT

    Var byofText_${LABEL}
    Var byofStatus_${LABEL}
    Var byofHash_${LABEL}
    Var /GLOBAL byofPath_${LABEL}

    Function ByofBrowse${BYOF_COUNTER}
        # OnClick pushes the clicked control HWND on the stack (usually the button)
        Pop $0

        # Pass explicit handles to the common function
        Push "${SEARCH_PATTERN}"
        Push "${HASHES}"
        Push $byofText_${LABEL}
        Push $byofStatus_${LABEL}
        Push $byofHash_${LABEL}
        Call ByofBrowseCommon
        Pop $byofPath_${LABEL}

        # Update Next Button
        Call UpdateNextButton
    FunctionEnd

    !define /redef /math BYOF_COUNTER ${BYOF_COUNTER} + 1
!macroend

!macro BYOF_PAINT BYOF_ID
    !define __LABEL ${BYOF_LABEL_${BYOF_ID}}
    !define /math __y0 ${ROW_COUNTER} * 30
    !define /math __y2 ${__y0} + 2
    !define /math __y15 ${__y0} + 15

    ${NSD_CreateLabel} 0 ${__y2}u 30u 12u "${__LABEL}:"
    Pop $0

    ${NSD_CreateText} 35u ${__y0}u 210u 12u ""
    Pop $byofText_${__LABEL}

    ${NSD_CreateButton} 250u ${__y0}u 50u 12u "Browse"
    Pop $0
    ${NSD_OnClick} $0 ByofBrowse${BYOF_ID}

    ${NSD_CreateLabel} 254u ${__y15}u 50u 12u ""
    Pop $byofStatus_${__LABEL}

    ${NSD_CreateLabel} 35u ${__y15}u 210u 12u ""
    Pop $byofHash_${__LABEL}

    !define /redef /math ROW_COUNTER ${ROW_COUNTER} + 1
    !undef __LABEL
    !undef __y0
    !undef __y2
    !undef __y15
!macroend

Function ByofBrowseCommon
    !insertmacro STACKFRAME_BEGIN 5 2
    # $0 : Hash HWND
    # $1 : Status HWND
    # $2 : Text HWND
    # $3 : Hashes
    # $4 : Search Pattern
    # $R0-R1 : scratch

    nsDialogs::SelectFileDialog open "" "$4|All Files|*.*"
    Pop $R0

    ${If} "$R0" == ""
        !insertmacro STACKFRAME_RETURN 5 2 $R0
        !insertmacro STACKFRAME_END 5 2
        Return
    ${EndIf}

    ${NSD_SetText} $2 "$R0"
    ${NSD_SetText} $1 ""
    ${NSD_SetText} $0 "Calculating hash..."

    # Force a repaint to show the file location in "textInput" before hash calculation
    System::Call 'user32::UpdateWindow(p$HWNDPARENT)'
    Sleep 50

    NSCurl::sha1 "$R0"
    Pop $R1 ; sha1
    ${NSD_SetText} $0 "$R1"

    !insertmacro STR_CONTAINS $3 $R1 $R1

    ${If} $R1 == 1
        ${NSD_SetText} $1 "    Valid IMG"
    ${Else}
        ${NSD_SetText} $1 "Unknown IMG"
    ${EndIf}

    !insertmacro STACKFRAME_RETURN 5 2 $R0
    !insertmacro STACKFRAME_END 5 2
FunctionEnd

!macro BYOF_PAGE_CREATE
    Function ByofPage
        nsDialogs::Create 1018
        Pop $0

        # Disable Next button
        Call UpdateNextButton

        !define ROW_COUNTER 0
        !define __i 0
        !insertmacro __BYOF_PAINT_LOOP
        !undef __i

        nsDialogs::Show
    FunctionEnd
!macroend

!macro __BYOF_PAINT_LOOP
    !if ${__i} < ${BYOF_COUNTER}
        !insertmacro BYOF_PAINT ${__i}
        !define /redef /math __i ${__i} + 1
        !insertmacro __BYOF_PAINT_LOOP
    !endif
!macroend

Function UpdateNextButton
    !insertmacro STACKFRAME_BEGIN 0 2
    # $R0: Next button HWND
    # $R1: should enable (0 or 1)

    GetDlgItem $R0 $HWNDPARENT 1

    Call EnableNextButton
    Pop $R1

    EnableWindow $R0 $R1

    !insertmacro STACKFRAME_END 0 2
FunctionEnd

!macro BYOF_WRITE_ENABLE_NEXT_BUTTON
    Function EnableNextButton
        !define __i 0
        !insertmacro __CHECK_PATH_LOOP
        !undef __i

        # All paths valid
        Push 1
    FunctionEnd
!macroend

!macro __CHECK_PATH_LOOP
    !if ${__i} < ${BYOF_COUNTER}
        !define __LABEL ${BYOF_LABEL_${__i}}
        ${If} "$byofPath_${__LABEL}" == ""
            Push 0
            !undef __LABEL
            Return
        ${EndIf}
        !undef __LABEL
        !define /redef /math __i ${__i} + 1
        !insertmacro __CHECK_PATH_LOOP
    !endif
!macroend
