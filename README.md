# Cliptube

This shell script downloads a **trimmed video clip** from a YouTube URL, using `yt-dlp` and `ffmpeg`.

## Requirements

Make sure the following tools are installed:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [ffmpeg](https://ffmpeg.org/)


## Usage
```
./cliptube.sh -s START_TIME -t END_TIME -q RESOLUTION -u URL

Arguments:
  -s START_TIME: Start time of the clip (e.g., 00:01:30)
  -t END_TIME: End time of the clip (e.g., 00:03:00)
  -q RESOLUTION: Video resolution (must be one of: 144, 360, 480, 720, 1080)
  -u URL: Full YouTube video URL
```
**Example:**
```sh
./cliptube.sh -s 00:01:00 -t 00:02:00 -q 720 -u "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
```

**Note:** Only AVC1 (H.264) video streams are selected.