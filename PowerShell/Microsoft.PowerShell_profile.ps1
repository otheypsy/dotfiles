Import-Module -Name Terminal-Icons
Import-Module -Name Custom\CustomHelpers

# --- PSReadLine --- #
. $HOME\Documents\PowerShell\Scripts\Custom\PSReadLineSetup.ps1

# --- Completions --- #
Import-Module PSCompletions
. $HOME\Documents\PowerShell\Scripts\Custom\MPVCompletions.ps1

# --- Alias Functions --- #
function pip { python -m pip @args }
function grep { Select-String @args }
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function cls { Clear-Host }

# --- oh-my-posh Config --- #
oh-my-posh init pwsh --config ~/.oh-my-posh/themes/otheypsy.omp.json | Invoke-Expression
