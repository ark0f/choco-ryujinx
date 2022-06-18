$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.150/ryujinx-1.1.150-win_x64.zip'
$checksum64 = 'ea7c0931a89d829e4e45b4cb731b838a2bdc73e4cca912bbc723c459e6a33beb'

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
