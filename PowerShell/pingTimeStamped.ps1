ping -t 8.8.8.8 | ForEach-Object{"{0} - {1}" -f (Get-Date),$_} > c:\users\%username%\desktop\ping_log.txt