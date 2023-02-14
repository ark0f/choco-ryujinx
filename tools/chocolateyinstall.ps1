$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$pp = Get-PackageParameters
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.619/ryujinx-1.1.619-win_x64.zip'
$checksum64 = '42c1c1932b7504a6ad89f9907cb66b4fa42a743ab0a4e0a6ef2e3794c4a07fe1'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$startMenuShortcutPath = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Ryujinx.lnk"
$desktopShortcutPath = "$env:USERPROFILE\Desktop\Ryujinx.lnk"

function InstallShortcut {
  param (
    $ShortcutPath
  )

  $shortcutArgs = @{
    shortcutFilePath = $ShortcutPath
    workingDirectory = $ryujinx_folder
    targetPath       = "$ryujinx_folder\Ryujinx.exe"
  }

  Install-ChocolateyShortcut @shortcutArgs
}

InstallShortcut $startMenuShortcutPath

if ($pp['DesktopShortcut']) {
    InstallShortcut $desktopShortcutPath
}
