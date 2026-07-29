#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s <input-video> [output-dir] [seconds-per-frame]\n' "$0" >&2
}

if [[ $# -lt 1 || $# -gt 3 ]]; then
  usage
  exit 2
fi

input_path=$1
output_dir=${2:-motion-storyboard}
sample_interval=${3:-0.5}

if [[ ! -f "$input_path" ]]; then
  printf 'Input video not found: %s\n' "$input_path" >&2
  exit 1
fi

for dependency in ffprobe ffmpeg; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'Required command not found: %s\n' "$dependency" >&2
    exit 1
  fi
done

if ! [[ "$sample_interval" =~ ^[0-9]+([.][0-9]+)?$ ]] || [[ "$sample_interval" =~ ^0+([.]0+)?$ ]]; then
  printf 'seconds-per-frame must be a positive number: %s\n' "$sample_interval" >&2
  exit 2
fi

mkdir -p "$output_dir/frames"

ffprobe \
  -v error \
  -show_entries format=duration,size,format_name:stream=index,codec_type,codec_name,width,height,r_frame_rate,avg_frame_rate \
  -of json \
  "$input_path" > "$output_dir/metadata.json"

ffmpeg \
  -y \
  -hide_banner \
  -loglevel error \
  -i "$input_path" \
  -vf "fps=1/${sample_interval},scale=480:-2" \
  -q:v 2 \
  "$output_dir/frames/frame_%05d.jpg"

ffmpeg \
  -y \
  -hide_banner \
  -loglevel error \
  -framerate 1 \
  -i "$output_dir/frames/frame_%05d.jpg" \
  -vf "tile=4x4:padding=8:margin=8:color=white" \
  -q:v 2 \
  "$output_dir/storyboard_%03d.jpg"

frame_count=$(find "$output_dir/frames" -type f -name 'frame_*.jpg' | wc -l | tr -d ' ')
sheet_count=$(find "$output_dir" -maxdepth 1 -type f -name 'storyboard_*.jpg' | wc -l | tr -d ' ')

printf 'Metadata: %s/metadata.json\n' "$output_dir"
printf 'Frames: %s (%s-second interval)\n' "$frame_count" "$sample_interval"
printf 'Storyboards: %s\n' "$sheet_count"
