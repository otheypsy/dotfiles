# PowerShell Commands

## File/Folder Links

```
New-Item -ItemType SymbolicLink -Path "<<link_file>>" -Target "<<source_file>>"
New-Item -ItemType Junction     -Path "<<link_file>>" -Target "<<source_file>>"
```

## FFMPEG

```
ffmpeg -f concat -safe 0 -i "<<parts_txt>>" -c copy "<<output_file>>"
```
