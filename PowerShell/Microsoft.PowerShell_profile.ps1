# --- Oh-my-Posh Config --- #
oh-my-posh init pwsh --config ~/.oh-my-posh/themes/powerlevel10k_lean.omp.json | Invoke-Expression

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

# --- Input Components --- #
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

# --- ffmpeg --- #
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

# --- yt-dlp --- #
Set-Alias -Name 'ytdlp' -Value 'YT-Download'
function YT-Download {
	
	if($args[0] -ne "") {
		$url = $args[0]
	}
	else {
		$url = Read-Host "Enter video URL"
	}
	
	$output = Read-Host "Enter name for output [Default: `%(title)s`]"
	if($output -eq "") {
		$output = "%(title)s"
	}
	
	yt-dlp `
	-S vcodec:h264 `
	--embed-subs `
	--embed-chapters `
	--downloader aria2c `
	--downloader-args "aria2c:-x 16 -s 16" `
	--extractor-args "generic:impersonate" `
	--output "$output.%(ext)s" `
	"$url"
}