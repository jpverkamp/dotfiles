function vlc
    if which vlc
    else
        if test (uname) = 'Darwin'
            /Applications/VLC.app/Contents/MacOS/VLC $argv
            return
        end
    end

    command vlc $argv
end
