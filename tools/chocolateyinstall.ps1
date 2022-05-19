$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.131/ryujinx-1.1.131-win_x64.zip'
$checksum64 = 'cba05cf9ea4b48fe5d3ee785d1b08f771cf2d5b1bf0407d003a898e51aadf461'

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
