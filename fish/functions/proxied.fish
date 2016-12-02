function proxied
    if ps aux | grep polipo | grep -v grep > /dev/null
        set -lx http_proxy localhost:7770
        set -lx https_proxy localhost:7770

        eval $argv
    else
        echo "Polipo is not running"
    end
end
