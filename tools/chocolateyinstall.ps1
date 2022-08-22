$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.227/ryujinx-1.1.227-win_x64.zip'
$checksum64 = '8c201f3076fa0d20557d92f1f417971714fe60e696ffc2cdb5e4811a354839c6'

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
