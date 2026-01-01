#!/usr/bin/env bash

# Set WEBM to true to enable additional WebM conversion
WEBM=${WEBM:-false}

# Set DRY_RUN to true to avoid deleting original files
DRY_RUN=${DRY_RUN:-false}

# Convert video files to WebM using ffmpeg with VP9 codec for video and Opus codec for audio
convert_mp4_to_webm() {
  input_files=("$@")
  for input_file in "${input_files[@]}"; do
    ffmpeg -i "$input_file" -an -c:v libvpx-vp9 -crf 30 -b:v 0 "${input_file%.*}.webm"
  done
}

# convert video files to animated webp using ffmpeg
convert_mp4_to_webp() {
  input_files=("$@")
  for input_file in "${input_files[@]}"; do
    ffmpeg -i "$input_file" -vf "fps=15,scale=-1:-1:flags=lanczos" -loop 0 "${input_file%.*}.webp"
  done
}

# Convert image files to WebP using cwebp
convert_images_to_webp() {
  input_files=("$@")
  for input_file in "${input_files[@]}"; do
    cwebp -q 80 "$input_file" -o "${input_file%.*}.webp"
  done
}

convert_files() {
  input_files=("$@")
  for input_file in "${input_files[@]}"; do
    case "${input_file##*.}" in
      mp4|mov|avi|mkv)
        if [ "$WEBM" != false ]; then
          convert_mp4_to_webm "$input_file"
        fi
        convert_mp4_to_webp "$input_file"
        ;;
      jpg|jpeg|png|bmp|tiff)
        convert_images_to_webp "$input_file"
        ;;
      *)
        echo "Unsupported file type: $input_file"
        continue
        ;;
    esac
    if [ "$DRY_RUN" == false ]; then
      rm "$input_file"
    fi
  done
}

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <file1> <file2> ..."
  echo "Set WEBM=true to enable WebM conversion."
  echo "Set DRY_RUN=true to avoid deleting original files."
  echo "Example: WEBM=true DRY_RUN=true $0 video.mp4 image.jpg"
  exit 1
fi

convert_files "$@"
