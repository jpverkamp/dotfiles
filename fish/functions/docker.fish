function docker
    assert-docker

    if test (count $argv) -eq 0
        command docker

    else if test $argv[1] = 'kill-all'
        command docker ps -q | xargs -n 1 docker kill

    else if test $argv[1] = 'nuke'
        command docker kill-all
        command docker images | awk '/<none>/ { print $3 }' | xargs -n 1 docker rmi
        command docker ps -aq -f status=exited | xargs -n 1 docker rm -v
        command docker images -aq -f "dangling=true" | xargs -n 1 docker rmi

    else
        command docker $argv

    end
end
