# UI
!include MUI2.nsh
!define MUI_ICON "..\..\MulderLoad.ico"

# My Macros / Functions
!include "..\..\includes\functions\DeleteRange.nsh"
!include "..\..\includes\functions\Download.nsh"
!include "..\..\includes\functions\DownloadRange.nsh"
!include "..\..\includes\functions\FileHashEquals.nsh"
!include "..\..\includes\functions\FileStrReplace.nsh"
!include "..\..\includes\functions\FolderMerge.nsh"
!include "..\..\includes\functions\StrContains.nsh"
!include "..\..\includes\functions\StrEndsWith.nsh"
!include "..\..\includes\functions\StrReplace.nsh"
!include "..\..\includes\functions\StrRightExplode.nsh"
!include "..\..\includes\functions\StrStartsWith.nsh"
!include "..\..\includes\misc\CommonMacros.nsh"

# Customize pages
!define MUI_COMPONENTSPAGE_NODESC
!include "..\..\includes\misc\Wording.nsh"

# MUI Macros
!insertmacro MUI_PAGE_WELCOME
!include "..\..\includes\pages\SelectPage.nsh"
Page Custom SelectPage
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

# Run as user by default
RequestExecutionLevel none

# Ensure the installer is not corrupted
CRCCheck force
