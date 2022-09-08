function pman
    set -lx VAGRANT_CWD /Users/jp/Projects/Vagrant/podman

    if test $argv[1] = "up"
        echo "Starting podman"
        vagrant up
    else if test $argv[1] = "down"
        echo "Stopping podman"
        vagrant halt
    else
        echo "Usage: pman [up|down]"
    end
end
