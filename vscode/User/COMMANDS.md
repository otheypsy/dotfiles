# Visual Studio Code Commands

## Dotfile Related Commands

### Save Current Extensions

```powershell
code --list-extensions > ~/dotfiles/vscode/User/extensions.txt
```

### Install Extensions Listed in Dotfiles

```powershell
############################################
## -- Get extensions listed in dotfile -- ##
############################################
$command = "Get-Content -Path '~/dotfiles/vscode/User/extensions.txt'"
Invoke-Expression $command -OutVariable output | Out-Null
$listed = $output -split "\r\n"

####################################
## -- Get installed extensions -- ##
####################################
$cmd = "code --list-extensions"
Invoke-Expression $cmd -OutVariable output | Out-Null
$installed = $output -split "\s"

###########################
## -- Install extensions ##
###########################
Write-Host ""
foreach ($extension in $listed) {
  Write-Host "Extension:" $extension -nonewline
  if ($installed.Contains($extension)) {
    Write-Host "  $([char]0x29fd)$([char]0x29fd) Already Installed" -ForegroundColor Blue
  }
  else {
    Write-Host "  $([char]0x29fd)$([char]0x29fd) Installing" -ForegroundColor Green
  }
}
```
