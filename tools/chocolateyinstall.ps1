$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$pp = Get-PackageParameters
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.692/ryujinx-1.1.692-win_x64.zip'
$checksum64 = 'd97fb414e99ad3353c9e2176a20871e298e4ec0081cc25f2d93aab21d8b242da'

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
