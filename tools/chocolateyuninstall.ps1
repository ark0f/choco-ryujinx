$toolsDir = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
Remove-Item $toolsDir -Force -Recurse

$icon_name = (Get-ChildItem "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs" -Filter "Ryujinx.lnk" -ErrorAction SilentlyContinue).FullName
Remove-Item $icon_name -ErrorAction SilentlyContinue
