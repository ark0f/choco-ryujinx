$releases = "https://github.com/Ryujinx/release-channel-master/releases"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex   = '.zip$'
    $url     = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
    $url     = 'https://github.com' + $url
    $version = $url -split '/' | Select-Object -Last 1 -Skip 1
    return @{ Version = $version; URL64 = $url }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

Update-Package -ChecksumFor 64
