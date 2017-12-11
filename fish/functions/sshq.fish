function sshq
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q $argv
end
