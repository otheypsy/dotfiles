# PowerShell Commands

## Symbolic Link

```pwsh
New-Item
  -ItemType   SymbolicLink
  -Path       "<<link_file>>"
  -Target     "<<source_file>>"

```

## Junction

```pwsh
New-Item
  -ItemType   Junction
  -Path       "<<link_folder>>"
  -Target     "<<source_folder>>"
```
