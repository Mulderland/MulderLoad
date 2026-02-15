!ifndef __CHECKOUTDATED_NSH__
!define __CHECKOUTDATED_NSH__

!include "..\..\includes\core\StackFrame.nsh"

Function CheckOutdated
    !insertmacro STACKFRAME_BEGIN 0 1
    # $R0: locals

    NScurl::sha256 -file $EXEPATH
    Pop $R0

    StrCpy $R0 "3b3286b449a11f81587e1c75498bfe425d4a16f5252af25611538c2a85e08e60" ; TODO Remove
    MessageBox MB_ICONEXCLAMATION|MB_OKCANCEL "This installer is outdated.$\r$\nDownloads may fail and you'll miss updates or bug fixes.$\r$\n$\r$\nDownload the latest version from Mulderland.com now?" IDOK CheckOutdated_ok IDCANCEL CheckOutdated_skip

    CheckOutdated_ok:
    ExecShell "open" "https://www.mulderland.com/?utm_source=nsis&utm_campaign=outdated"
    Sleep 300
    Quit

    CheckOutdated_skip:
    !insertmacro STACKFRAME_END 0 1
FunctionEnd

!endif ; __CHECKOUTDATED_NSH__
