$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.195/ryujinx-1.1.195-win_x64.zip'
$checksum64 = '6acb868b68076e51774869024025fa5a3e6d1eb93b982ec8c1baba0954f2ea9e'

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
