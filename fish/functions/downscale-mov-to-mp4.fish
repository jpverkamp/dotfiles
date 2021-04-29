function downscale-mov-to-mp4
  for src in $argv
      set -lx dst (echo $src | basename $src .MOV)".mp4"
      set -lx log (echo $src | basename $src .MOV)".log"

      echo "
Encoding:
  src: $src
  dst: $dst
  log: $log
"
      handbrake -Z 'Gmail Large 3 Minutes 720p30' -i $src -o $dst &> $log
  end
end

