function ffmpeg-gif
  for f in $argv
    ffmpeg -i $f -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" $f.mp4
  end
end
