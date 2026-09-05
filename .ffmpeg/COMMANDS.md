# FFMPEG Commands

## Video Files

### Add soft subtitles to MP4

```powershell
ffmpeg -i "<<input_mp4_file>>" -i "<<input_srt_file>>" `
  -c:v copy -c:a copy -c:s mov_text `
  -metadata:s:s:0 language=eng `
  -metadata:s:s:0 title="English" `
  "<<output_mp4_file>>"
```

### Concatenate multiple video files of same type

```powershell
ffmpeg -f concat -safe 0 `
  -i "<<parts_txt>>" `
  -c copy `
  "<<output_file>>"
```
