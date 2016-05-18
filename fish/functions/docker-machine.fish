function docker-machine
    if test (count $argv) -eq 0
        command docker-machine

    else if test $argv[1] = 'reset'
        command docker-machine rm dev; or true
        command docker-machine create --driver virtualbox --virtualbox-disk-size "100000" --engine-insecure-registry registry.edmodo.io dev
        command docker-machine start dev
        assert-docker

    else
        command docker-machine $argv

    end
end
