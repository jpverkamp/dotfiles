register_key_chord('Capture ⌘⌃c', function() 
    captureMode = hs.hotkey.modal.new('⌘⌃', 'c')

    captureMode:bind('', 's', function()
        hs.eventtap.keyStroke('⌘⌃⇧', '1')
        captureMode:exit()
    end)

    captureMode:bind('', 'r', function()
        hs.eventtap.keyStroke('⌘⌃⇧', '2')
        hs.eventtap.keyStroke('⌘⌃⇧', '4') -- mute
        captureMode:exit()
    end)

    captureMode:bind('', 'g', function()
        hs.eventtap.keyStroke('⌘⌃⇧', '3');
        captureMode:exit()
    end)

    captureMode:bind('', 'SPACE', function()
        hs.eventtap.keyStroke('⌘⌃⇧', '9');
        captureMode:exit()
    end)
end)

