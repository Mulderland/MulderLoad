!macro AbortIfFolderNotEmpty folder
    RMDir "${folder}" # Try to delete (will only work if folder is empty)
    IfFileExists "${folder}" yes no
    yes:
        MessageBox MB_ICONSTOP "Folder '${folder}' already exists and is not empty. Please delete it, or choose another folder."
        Abort
    no: # continue
!macroend
