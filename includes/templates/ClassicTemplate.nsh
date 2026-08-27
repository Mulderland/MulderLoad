# UI
!include MUI2.nsh
!define MUI_ICON "..\..\MulderLoad.ico"

# My Functions
!include "..\..\includes\functions\CreateJunction.nsh"
!include "..\..\includes\functions\DeleteRange.nsh"
!include "..\..\includes\functions\DetectOS.nsh"
!include "..\..\includes\functions\Download.nsh"
!include "..\..\includes\functions\DownloadRange.nsh"
!include "..\..\includes\functions\GetParentDirectory.nsh"
!include "..\..\includes\functions\FileHashEquals.nsh"
!include "..\..\includes\functions\FileStrContains.nsh"
!include "..\..\includes\functions\FileStrReplace.nsh"
!include "..\..\includes\functions\FindSteamGamePath.nsh"
!include "..\..\includes\functions\FindSteamModsPath.nsh"
!include "..\..\includes\functions\FindSteamRootPath.nsh"
!include "..\..\includes\functions\FolderMerge.nsh"
!include "..\..\includes\functions\HasDotnetDesktopRuntime.nsh"
!include "..\..\includes\functions\Move.nsh"
!include "..\..\includes\functions\StrContains.nsh"
!include "..\..\includes\functions\StrCount.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrReplace.nsh"
!include "..\..\includes\functions\StrResolveFilename.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"
!include "..\..\includes\misc\CommonMacros.nsh"

# Customize pages
!define MUI_COMPONENTSPAGE_NODESC
!include "..\..\includes\misc\Wording.nsh"

# MUI Macros
!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE AfterDirectoryPage
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!ifndef AFTER_DIRECTORY_PAGE
    Function AfterDirectoryPage
    FunctionEnd
!endif

# Run as user by default
RequestExecutionLevel none

# Ensure the installer is not corrupted
CRCCheck force
