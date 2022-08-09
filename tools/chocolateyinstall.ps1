$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.209/ryujinx-1.1.209-win_x64.zip'
$checksum64 = 'eaab26209191979fa453fe0aa0b907e2d800a8c100062f9cbdbd91e1dca8a508'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$shortcutArgs = @{
  shortcutFilePath = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Ryujinx.lnk"
  workingDirectory = $ryujinx_folder
  targetPath       = "$ryujinx_folder\Ryujinx.exe"
}

Install-ChocolateyShortcut @shortcutArgs
