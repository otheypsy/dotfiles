
# ------------------------ #
# --- Input Components --- #
# ------------------------ #
function Read-ChoiceInput {
    param (
        [string]$Title = 'Generic choice title',
        [string]$Message = 'Generic choice message',
        [string[]]$Options = @('Option 1', 'Option 2', 'Option 3'),
        [int]$Default = 0
    )

    $choices = @()
    for ($i = 0; $i -lt $Options.Length; $i++) {
        $choices += (New-Object System.Management.Automation.Host.ChoiceDescription -ArgumentList "&$i" $Options[$i])
    }

    $choice = $host.UI.PromptForChoice($Title, $Message, $Options, $Default)

    return [string]$Options[$choice]
}


# -------------- #
# --- ffmpeg --- #
# -------------- #

Set-Alias -Name 'jvideo' -Value 'Join-Video'
<#
.SYNOPSIS
    Join video files
.DESCRIPTION
    A script that uses ffpmeg to join all video files from the current folder. All files must be of the same type (mp4 or mkv)
#>
function Join-Video {

    $prompt = 'Select video format'
    $formats = @('mp4', 'mkv')
    $format = Read-SelectionInput -Prompt $prompt -Options $formats -Current 0


    $choice = $host.UI.PromptForChoice(
        'Select video format',
        'Enter your choice',
        [System.Management.Automation.Host.ChoiceDescription[]] @('&mp4', '&mkv'),
        0
    )

    switch ($choice) {
        0 { $format = $formats[0] }
        1 { $format = $formats[1] }
    }

    $output = Read-Host 'Enter name for output video [Default: output]'
    if ($output -eq '') { $output = 'output' }

    New-Item -Path 'parts.txt' -ItemType 'File' -Force | Out-Null
    $parts = Get-ChildItem -File -Filter *.mp4 | Sort-Object CreationTime
    foreach ($part in $parts) {
        $partEntry = "file '" + $part.Name + "'"
        Add-Content -Path 'parts.txt' -Value $partEntry
    }

    ffmpeg -f concat -safe 0 -i 'parts.txt' -c copy "$output.$format"
    Remove-Item -Path 'parts.txt'
}


# -------------- #
# --- yt-dlp --- #
# -------------- #


<#
    .SYNOPSIS
    Download videos using yt-dlp

    .DESCRIPTION
    A script that uses yt-dlp to download videos

    .PARAMETER Url
    Specifies the source url for the video

    .EXAMPLE
    PS> Invoke-YTD -Url "example.com"

    .EXAMPLE
    PS> Invoke-YTD "example.com"

#>
Set-Alias -Name 'ytd' -Value 'Invoke-YTD'
function Invoke-YTD {
    [CmdletBinding()]

    param (
        [Parameter(Position = 0, Mandatory = $false)][String]$Url
    )

    if ($Url -eq '') {
        $Url = Read-Host 'Enter source video URL'
    }

    $format = 'mp4'
    $output = Read-Host "Enter name for output [Default: `%(title)s`]"
    if ($output -eq '') {
        $output = '%(title)s'
    }

    $splat = @(
        $Url,
        '--verbose',
        '--embed-subs',
        '--embed-chapters',
        '--merge-output-format=mp4'
        '--concurrent-fragments=16',
        '--impersonate=chrome',
        '--extractor-args=generic:impersonate'
    )

    # Prompt for the choice
    $choices = @('Yes', 'No')
    $external = Read-ChoiceInput -Title 'Use aria2c downloader?' -Message 'Enter your choice' -Options $choices

    switch ($external) {
        'Yes' {
            $splat += '--downloader=aria2c'
            $splat += '--downloader-args="aria2c: --continue --min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16"'
        }
    }

    yt-dlp $splat -o "$output.$format"

}
