!ifndef __WINEDLLOVERRIDE_NSH__
!define __WINEDLLOVERRIDE_NSH__

!include "LogicLib.nsh"
!include "FileFunc.nsh"
!include "..\..\includes\core\StackFrame.nsh"
!include "..\..\includes\functions\DetectOS.nsh"

# Writes Wine DLL overrides into the current prefix registry (does nothing on Windows).
# Same effect as winecfg "Libraries" tab, or WINEDLLOVERRIDES="dll=n,b".
#
# Note: WINEDLLOVERRIDES env var (e.g. set by Proton for DXVK/VKD3D) takes precedence over the registry.
Function WineDllOverride
    !insertmacro STACKFRAME_BEGIN 3 5
    # $0: exe name ("" = global, for the whole prefix), path is allowed (only the filename is kept)
    # $1: comma-separated list of dll names (".dll" suffix is optional), ex: "ddraw,d3dimm,d3d8"
    # $2: load order: "native,builtin", "builtin,native", "native", "builtin", "disabled", or "remove"
    # $R0: registry key
    # $R1: temp / current char
    # $R2: current dll name
    # $R3: position in dll list
    # $R4: temp

    !insertmacro DETECT_OS $R1
    ${If} $R1 != "Linux"
        Goto WineDllOverride_end
    ${EndIf}

    ${If} $0 == ""
        StrCpy $R0 "Software\Wine\DllOverrides"
        StrCpy $0 "global" ; only used for logging from here
    ${Else}
        ${GetFileName} "$0" $0
        StrCpy $R0 "Software\Wine\AppDefaults\$0\DllOverrides"
    ${EndIf}

    StrCpy $R2 ""
    StrCpy $R3 0

    WineDllOverride_loop:
        StrCpy $R1 $1 1 $R3 ; "" when the end of the list is reached

        ${If} $R1 == ","
        ${OrIf} $R1 == ""
            # Strip the optional ".dll" suffix
            StrCpy $R4 $R2 "" -4
            ${If} $R4 == ".dll"
                StrCpy $R2 $R2 -4
            ${EndIf}

            ${If} $R2 != ""
                ${If} $2 == "remove"
                    DetailPrint " // Wine: remove DLL override $R2 ($0)"
                    DeleteRegValue HKCU "$R0" "$R2"
                ${Else}
                    DetailPrint " // Wine: DLL override $R2=$2 ($0)"
                    WriteRegStr HKCU "$R0" "$R2" "$2"
                ${EndIf}
            ${EndIf}

            ${If} $R1 == ""
                Goto WineDllOverride_end
            ${EndIf}
            StrCpy $R2 ""
        ${ElseIf} $R1 != " "
            StrCpy $R2 "$R2$R1"
        ${EndIf}

        IntOp $R3 $R3 + 1
        Goto WineDllOverride_loop

    WineDllOverride_end:
    !insertmacro STACKFRAME_END 3 5
FunctionEnd

# Global override (whole Wine prefix)
!ifmacrondef WINE_DLL_OVERRIDE
    !macro WINE_DLL_OVERRIDE DLLS MODE
        Push "${MODE}"
        Push "${DLLS}"
        Push ""
        Call WineDllOverride
    !macroend
!endif

# Per-application override (only when EXE is running), preferred when possible
!ifmacrondef WINE_DLL_OVERRIDE_APP
    !macro WINE_DLL_OVERRIDE_APP EXE DLLS MODE
        Push "${MODE}"
        Push "${DLLS}"
        Push "${EXE}"
        Call WineDllOverride
    !macroend
!endif

!endif ; __WINEDLLOVERRIDE_NSH__
