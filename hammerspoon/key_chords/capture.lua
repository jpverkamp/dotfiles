register_key_chord('Screenshots ⌘⌃c', function() 
    captureMode = hs.hotkey.modal.new('⌘⌃', 'c')

    captureMode:bind('', 's', function()
        hs.eventtap.keyStroke('⌘⌃⇧', '4')
        captureMode:exit()
    end)

    captureMode:bind('', 'r', function()
        hs.eventtap.keyStroke('⌘⇧', '5')
        captureMode:exit()
    end)
end)

