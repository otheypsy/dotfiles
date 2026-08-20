# --- Commands --- #
# New-Item -ItemType SymbolicLink -Path "<<link_file>>" -Target "<<source_file>>"
# New-Item -ItemType Junction     -Path "<<link_file>>" -Target "<<source_file>>"

# --- Oh-my-Posh Config --- #
oh-my-posh init pwsh --config ~/.oh-my-posh/themes/multiverse-neon.omp.json | Invoke-Expression

# --- QOL --- #
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# --- PowerToys CommandNotFound --- #
Import-Module -Name Microsoft.WinGet.CommandNotFound

# --- Custom Alias Functions --- #
function pip { python -m pip @args }
function ll { Get-ChildItem -Force | Format-Table }
function la { Get-ChildItem -Force }
function grep { Select-String @args }
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function cls { Clear-Host }

# --- Prefix Timestamp Filter --- #
function timestamp { 
	Process { "$(Get-Date): $_" } 
}

# ------------------------ #
# --- Input Components --- #
# ------------------------ #
function Read-SelectionInput {
	param (
		[string[]]$Options = @("Option 1", "Option 2", "Option 3"),
		[int]$Current = 0
	)

	while ($true) {
		Write-Host "Select"
		Write-Host "Use Arrow Keys to select, Enter to confirm:"
		for ($i = 0; $i -lt $Options.Count; $i++) {
			if ($i -eq $Current) {
				Write-Host "> $($Options[$i])" -ForegroundColor Cyan
			} else {
				Write-Host "  $($Options[$i])"
			}
		}

		$key = [Console]::ReadKey($true).Key
		if ($key -eq "UpArrow") { $Current = if ($Current -gt 0) { $Current - 1 } else { $Options.Count - 1 } }
		if ($key -eq "DownArrow") { $Current = if ($Current -lt $Options.Count - 1) { $Current + 1 } else { 0 } }
		if ($key -eq "Enter") { break }
	}

	return [string]$Options[$Current]
}


# -------------- #
# --- ffmpeg --- #
# -------------- #

<#
.SYNOPSIS
    Join video files 
.DESCRIPTION
    A script that uses ffpmeg to join all video files from the current folder. All files must be of the same type (mp4 or mkv)
.NOTES
    Author         : otheypsy
    Prerequisite   : ffmpeg
#>
Set-Alias -Name 'jvideo' -Value 'Join-Video'
function Join-Video {
	
	$prompt = "Select video format"
	$formats = @("mp4", "mkv")
	$format = Read-SelectionInput -Prompt $prompt -Options $formats -Current 0
	$output = Read-Host "Enter name for output video [Default: output]"
	if($output -eq "") { $output = "output" }		
	
	New-Item -Path "parts.txt" -ItemType "File" -Force | Out-Null
	$parts = Get-ChildItem -File -Filter *.mp4 | Sort-Object CreationTime
	foreach ($part in $parts) {
		$partEntry = "file '" + $part.Name + "'"
		Add-Content -Path "parts.txt" -Value $partEntry
	}
	
	ffmpeg -f concat -safe 0 -i "parts.txt" -c copy "$output.$format"
	Remove-Item -Path "parts.txt"
}


# -------------- #
# --- yt-dlp --- #
# -------------- #

<#
.SYNOPSIS
    Download videos using yt-dlp
.DESCRIPTION
    A script that uses yt-dlp to download videos
.NOTES
    Author         : otheypsy
    Prerequisite   : yt-dlp
.PARAMETER
    Source video url
#>
Set-Alias -Name 'ytd' -Value 'Invoke-YT-Download'
function Invoke-YT-Download {
	[CmdletBinding()] 
	
	param (
		[Parameter(Position=0, Mandatory= $false)]
		[String]$url,
		[switch]$ext
	)
	
	if($url -eq "") {
		$url = Read-Host "Enter video URL"
	}
	
	$output = Read-Host "Enter name for output [Default: `%(title)s`]"
	if($output -eq "") {
		$output = "%(title)s"
	}
	
	$splat = @(
		$url,
		'--verbose',
		'--embed-subs',
		'--embed-chapters',
		'--merge-output-format=mp4'
		'--concurrent-fragments=16',
		'--impersonate=chrome',
		'--downloader-args="aria2c: --continue --min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16"',
		'--extractor-args=generic:impersonate'
	)
	if($ext -eq $true) {
		$splat += '--downloader=aria2c'
	}
	
	yt-dlp $splat
	
}
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
