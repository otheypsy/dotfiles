# Visual Studio Code Commands

## Dotfile Related Commands

### Save Currently Installed Extensions

- Backup list of all extensions installed in local vscode instance
- Change extension preference list destination if required
- Script default is `~/dotfiles/vscode/User/extensions.txt`
- Outputs a simple text file with each extension ID listed on a separate line

```powershell
code
    --list-extensions > ~/dotfiles/vscode/User/extensions.txt
```

### Install Extensions Listed in Dotfiles

- Change extension preference list location if required
- Script default is `~/dotfiles/vscode/User/extensions.txt`
- Will check extensions already installed in vscode instance
- Will install all missing entries from preference list

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
