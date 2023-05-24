$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$pp = Get-PackageParameters
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.819/ryujinx-1.1.819-win_x64.zip'
$checksum64 = '746656eab42549f94f6afc30d496b173944a9604858e98595c21b263703412ec'

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
