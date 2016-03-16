-- Aerosnap helper functions to get and set current window parameters
function aerosnap_get_parameters()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen()
    local bounds = screen:frame()

    return window, frame, bounds
end

-- Aerosnap help to move a window to a specified position
function aerosnap_move_window(x, y, w, h)
    local window, frame, bounds = aerosnap_get_parameters()

    frame.x = x
    frame.y = y
    frame.w = w
    frame.h = h

    window:setFrame(frame)
end

-- Save the current window's position so we can restore it
function aerosnap_save_window()
    local window, frame, bounds = aerosnap_get_parameters()
    saved_window_sizes = saved_window_sizes or {}
    saved_window_sizes[window:id()] = {x = frame.x, y = frame.y, w = frame.w, h = frame.h}
end

-- Aerosnap move windows around
function aerosnap(key, bounds_function)
    hs.hotkey.bind({"cmd", "ctrl"}, key, function()
        local window, frame, bounds = aerosnap_get_parameters()
        aerosnap_save_window()

        x, y, w, h = bounds_function(bounds)
        aerosnap_move_window(x, y, w, h)
    end)
end

-- Left/right half on keypad, maximize with up
aerosnap("left", function(bounds) return bounds.x, bounds.y, bounds.w / 2, bounds.h end)
aerosnap("right", function(bounds) return bounds.x + bounds.w / 2, bounds.y, bounds.w / 2, bounds.h end)

-- Half screens on numpad
aerosnap("pad8", function(bounds) return bounds.x, bounds.y, bounds.w, bounds.h / 2 end)
aerosnap("pad4", function(bounds) return bounds.x, bounds.y, bounds.w / 2, bounds.h end)
aerosnap("pad6", function(bounds) return bounds.x + bounds.w / 2, bounds.y, bounds.w / 2, bounds.h end)
aerosnap("pad2", function(bounds) return bounds.x, bounds.y + bounds.h / 2, bounds.w, bounds.h / 2 end)

-- Quarter screens no numpad
aerosnap("pad7", function(bounds) return bounds.x, bounds.y, bounds.w / 2, bounds.h / 2 end)
aerosnap("pad9", function(bounds) return bounds.x + bounds.w / 2, bounds.y, bounds.w / 2, bounds.h / 2 end)
aerosnap("pad1", function(bounds) return bounds.x, bounds.y + bounds.h / 2, bounds.w / 2, bounds.h / 2 end)
aerosnap("pad3", function(bounds) return bounds.x + bounds.w / 2, bounds.y + bounds.h / 2, bounds.w / 2, bounds.h / 2 end)

-- Maximum with up arrow or 5 on numpad
aerosnap("up", function(bounds) return bounds.x, bounds.y, bounds.w, bounds.h end)
aerosnap("pad5", function(bounds) return bounds.x, bounds.y, bounds.w, bounds.h end)

-- Restore the last saved window configuration for a window (basically, a one level undo)
hs.hotkey.bind({"cmd", "ctrl"}, "down", function()
    local window, frame, bounds = aerosnap_get_parameters()

    saved_window_sizes = saved_window_sizes or {}
    old_bounds = saved_window_sizes[window:id()]
    if old_bounds ~= nil then
        aerosnap_move_window(old_bounds.x, old_bounds.y, old_bounds.w, old_bounds.h)
        saved_window_sizes[window:id()] = nil
    end
end)
