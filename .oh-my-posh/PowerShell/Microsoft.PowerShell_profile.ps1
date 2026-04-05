oh-my-posh init pwsh --config ~/.oh-my-posh/themes/powerlevel10k_lean.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows