# --- Oh-my-Posh Config ---
oh-my-posh init pwsh --config ~/.oh-my-posh/themes/powerlevel10k_lean.omp.json | Invoke-Expression

# --- QOL ---
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# --- Custom Alias Functions ---
function pip { python -m pip @args }

# --- PowerToys CommandNotFound ---
# Import-Module -Name Microsoft.WinGet.CommandNotFound
