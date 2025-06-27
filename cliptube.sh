#!/bin/sh

script_name=$(basename $0)

print_help() {
    echo "usage: $script_name -s START_TIME -t END_TIME -q RESOLUTION -u URL"
    echo "RESOLUTION: 144, 360, 480, 720, 1080 ..."
}

start_time=
end_time=
quality=
url=


while getopts "s:t:q:u:" opt
do
    case "$opt" in
        s) start_time="$OPTARG";;
        t) end_time="$OPTARG";;
        q) quality="$OPTARG";;
        u) url="$OPTARG";;
    esac
done

if [[ -z "$start_time" ]] || [[ -z "$end_time" ]] || [[ -z "$quality" ]] || [[ -z "$url" ]];
then
    help
    exit 1
fi

case "$quality" in
    144|360|480|720|1080)
        # Allowed value
    ;;
    *)
        print_help
        exit 1
    ;;
esac

original_video_url=$(yt-dlp -f "bv[vcodec^=avc1][height=$quality]" -g "$url")
original_audio_url=$(yt-dlp -f "ba" -g "$url")
video_title=$(yt-dlp --get-title "$url")



ffmpeg -hide_banner -ss "$start_time" -to "$end_time" \
  -i "$original_video_url" -ss "$start_time" -to "$end_time" -i "$original_audio_url" \
  -map 0:v:0 -map 1:a:0 \
  -c:v libx264 -preset fast -crf 26 -tune film \
  -c:a copy \
  "$$ - $video_title.mp4"
