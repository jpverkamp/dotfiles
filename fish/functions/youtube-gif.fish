function youtube-gif
    if test (count $argv) -eq 3
        set argv $argv 10 128
    end

    if test (count $argv) -eq 4
        set argv $argv 10
    end

    if test (count $argv) -eq 5
        set url $argv[1]
        set start $argv[2]
        set duration $argv[3]
        set fps $argv[4]
        set colors $argv[5]
    else
        echo "Usage: youtube-gif url start duration [fps=10] [colors=64]"
        return
    end

    set -lx dir (mktemp -d)
    pushd $dir

    printf "Downloading: $url ($start, $duration) @ $fps fps\n"
    printf "Working in: $dir\n"

    printf "\nDownloading video...\n"
    youtube-dl "$url"
    set -lx filename (ls)

    printf "\nExtracting frames...\n"
    mkdir frames
    ffmpeg -i "$filename" -ss $start -t $duration -vf scale=256:-1:flags=lanczos,fps=$fps frames/frame%04d.png

    printf "\nGenerating gif...\n"
    convert -loop 0 -alpha on -channel rgba -coalesce -layers OptimizeFrame -colors $colors frames/*.png "$filename.gif"

    popd

    printf "\nCleaning up...\n"
    mv $dir/*.gif .
    rm -rf $dir
end
