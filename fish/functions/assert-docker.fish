function assert-docker
    command docker ps > /dev/null ^ /dev/null
    if test $status -ne 0
        echo "Starting docker..."
        docker-machine start dev
        eval (docker-machine env dev --shell fish)
        echo
    end
end
