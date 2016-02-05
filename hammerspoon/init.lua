-- Reload hammerspoon configs
hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

-- Lock
hs.hotkey.bind({"cmd", "ctrl"}, 'L', function()
    os.execute("open '/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app'")
end)

require('aerosnap')
