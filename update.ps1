$releases = "https://api.github.com/repos/Ryujinx/release-channel-master/releases/latest"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $download_page = ConvertFrom-Json $download_page
    $regex   = '.zip$'
    $url     = $download_page.assets | 
        Select-Object -Expand browser_download_url |
        Where-Object { $_ -match $regex } | 
        Select-Object -First 1
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
