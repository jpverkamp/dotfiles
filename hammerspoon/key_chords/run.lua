register_key_chord('Run ⌘⌃r', function() 
    runMode = hs.hotkey.modal.new('⌘⌃', 'r')

    runMode:bind('', 't', function()
        hs.execute("code ~/Dropbox/todo.code-workspace", true)
        runMode:exit()
    end)

    runMode:bind('', 'b', function()
        hs.execute("code ~/Projects/blog", true)
        runMode:exit()
    end)
end)
