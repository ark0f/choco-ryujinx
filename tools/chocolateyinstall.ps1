$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = Join-Path $(Get-ToolsLocation) $env:ChocolateyPackageName
$pp = Get-PackageParameters
$ryujinx_folder = "$toolsDir\publish"
$url64      = 'https://github.com/Ryujinx/release-channel-master/releases/download/1.1.213/ryujinx-1.1.213-win_x64.zip'
$checksum64 = '4ba66d6f0fd8d4ebb63a5b4028abad84dc7938f3976c49c081d61b9be6e78803'

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
    workingDirectory = $ryujinx_folder
    targetPath       = "$ryujinx_folder\Ryujinx.exe"
  }

  $shortcutArgs.shortcutFilePath = $ShortcutPath
  Install-ChocolateyShortcut @shortcutArgs
}

InstallShortcut $startMenuShortcutPath

if ($pp['DesktopShortcut']) {
    InstallShortcut $desktopShortcutPath
}
