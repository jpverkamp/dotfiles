function init_layout() 
    print('[debug] init_layout()')

    if hs.host.names()[1]:lower():find("mercury") then
        -- Left monitor: LG HDR
        rehome("Firefox:Main",  "LG",   3, {left=1/3, width=2/3})
        rehome("Obsidian",      "LG",   3, {width=1/3, height=1/2})
        rehome("todo",          "LG",   3, {width=1/3, height=1/2, top=1/2})

        -- Right monitor: DELL 
        rehome("Mail",          "DELL", 1)
        rehome("Bitwarden",     "DELL", 1)
        rehome("Cryptomator",   "DELL", 1)

        rehome("Calendar",      "DELL", 2, {width=1, height=1})

        rehome("Firefox:Media", "DELL", 3, {width=2/3})
        rehome("Slack",         "DELL", 3, {left=2/3, width=1/3, height=1/2})
        rehome("Messages",      "DELL", 3, {left=2/3, top=1/2, width=1/3, height=1/2})
    end
end
