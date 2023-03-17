require "layout"

key_chords = {}

function register_key_chord(name, f) 
    key_chords[name] = f
end

function init_keys()
    print('[debug] init_keys()')

    -- ⌘ ⌃ ⌥ ⇧

    -- show grid
    hs.hotkey.bind("⌘⇧", "g",     hs.grid.show)

    -- full screens
    hs.hotkey.bind("⌘⇧", "up",    thunkPush{width=1, height=1})
    hs.hotkey.bind("⌘⇧", "down",  thunkPush{top=1/8, left=1/8, width=3/4, height=3/4})
    
    -- half screens
    function thunkLeftOrMove()
        if not push{left=0, width=1/2} then
            local window = hs.window.focusedWindow()
            local screen = window:screen():previous()
            window:moveToScreen(screen)

            push{left=1/2, width=1/2}
        end
    end    

    function thunkRightOrMove()
        if not push{left=1/2, width=1/2} then
            local window = hs.window.focusedWindow()
            local screen = window:screen():next()
            window:moveToScreen(screen)

            push{left=0, width=1/2}
        end
    end

    hs.hotkey.bind("⌘⇧", "left",  thunkLeftOrMove)
    hs.hotkey.bind("⌘⇧", "right", thunkRightOrMove)
    hs.hotkey.bind("⌘⇧", "pad8",  thunkPush{height=1/2})
    hs.hotkey.bind("⌘⇧", "pad2",  thunkPush{top=1/2, height=1/2})

    -- third screens
    hs.hotkey.bind("⌘⇧", "pad4",  thunkPush{width=2/3})
    hs.hotkey.bind("⌘⇧", "pad6",  thunkPush{width=2/3, left=1/3})

    hs.hotkey.bind("⌘⇧", "pad7",  thunkPush{top=0, left=0, width=1/3, height=1/2})
    hs.hotkey.bind("⌘⇧", "pad9",  thunkPush{top=0, left=2/3, width=1/3, height=1/2})
    hs.hotkey.bind("⌘⇧", "pad1",  thunkPush{top=1/2, left=0, width=1/3, height=1/2})
    hs.hotkey.bind("⌘⇧", "pad3",  thunkPush{top=1/2, left=2/3, width=1/3, height=1/2})

    -- move to next/previous screen (if there is one)
    hs.hotkey.bind("⌘⌃⇧", "left",  thunkAdvanceWindow{offset=-1})
    hs.hotkey.bind("⌘⌃⇧", "right", thunkAdvanceWindow{offset=1})

    -- run any registered functions
    for name, f in pairs(key_chords) do
        print('[debug] Running key function: ' .. name)
        f()
    end
end