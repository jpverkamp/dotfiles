function modem-stats
    function helper
        command modem-stats | jq $argv[1] | tr -d '"' | average
    end

    if test (count $argv) -eq 0
        command modem-stats
    else if test $argv[1] = 'downstream'
        helper '.signal.downstream[]."Power Level"'
    else if test $argv[1] = 'upstream'
        helper '.signal.upstream[]."Power Level"'
    else if test $argv[1] = 'noise'
        helper '.signal.downstream[]."Signal to Noise Ratio"'
    else
        command modem-stats $argv
    end
end
