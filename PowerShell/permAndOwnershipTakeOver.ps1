$pathName = Read-Host "What is the full path name for the file/folder? "
Get-ChildItem $pathName -Directory | ForEach-Object {
    $path = $_.FullName
    $user = $_.Name
  
    & takeown /f "$path" /r /a
    & icacls "$path" '/grant:rx' 'SYSTEM:(OI)(CI)F' 'Administrators:(OI)(CI)F' "DOMAIN\${user}:(OI)(CI)F"
  }
  
  
  robocopy "E:\Data\ServerFolders\Communications" "F:\RCECO\Communications_to_be_Filled" /S /E /Z /ZB /R:5 /W:5 /TBD /NP /V /MT:16