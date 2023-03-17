windowFilter = hs.window.filter.new()
windowFilter:setDefaultFilter{}
windowFilter:setSortOrder(hs.window.filter.sortByFocusedLast)

-- Keep a local copy of all windows
allWindows = {}
for _, window in pairs(windowFilter:getWindows()) do 
  allWindows[window:id()] = window
end

windowFilter:subscribe("windowCreated", function(window, name, event)
  print("window created", window)
  allWindows[window:id()] = window
end)

windowFilter:subscribe("windowDestroyed", function(window, name, event)
  print("window destroyed", window)
  allWindows[window:id()] = nil
end)

function rehome(windowQuery, screenQuery, spaceIndex, pushArgs)
  for id, w in pairs(allWindows) do
    local name = w:application():name() .. " - " .. w:title()
    if name ~= nil and name:find(windowQuery) then 
      window = w
    end
  end

  if window == nil then
    print("[ERROR in rehome] Window now found", windowQuery)
    return
  end

  local screen = hs.screen.find(screenQuery)
  if screen == nil then
    print("[ERROR in rehome] Screen now found", screenQuery)
    return
  end

  local spaceIDs = hs.spaces.allSpaces()[screen:getUUID()]
  if spaceIndex > #spaceIDs then
    print("[ERROR in rehome] spaceIndex too large", spaceIndex, ">", #spaceIDs)
    return
  end
  local spaceID = spaceIDs[spaceIndex]
  local spaceName = hs.spaces.missionControlSpaceNames()[screen:getUUID()][spaceID]

  print("Moving", window, "to", spaceID, "=", spaceName, "on", screen)
  hs.spaces.moveWindowToSpace(window, spaceID)
  
  if pushArgs ~= nil then
    pushArgs["window"] = window
    push(pushArgs)
  end
end

function advanceWindow(params)
  local offset = params["offset"] or 1
  local window = params["window"] or hs.window.focusedWindow()

  local targetSpaceID = hs.spaces.windowSpaces(window)[1]
  local currentScreen = nil
  local currentIndex = nil

  for screen, spaces in pairs(hs.spaces.allSpaces()) do
    for index, space in ipairs(spaces) do
      if targetSpaceID == space then
        currentScreen = screen
        currentIndex = index
        break
      end
    end
    if current_space ~= nil then break end
  end

  local nextIDs = hs.spaces.allSpaces()[currentScreen]
  local nextIndex = (currentIndex + offset) % #nextIDs
  local nextSpaceID = nextIDs[nextIndex]

  hs.spaces.moveWindowToSpace(window, nextSpaceID)
  hs.spaces.gotoSpace(nextSpaceID)
end

function thunkAdvanceWindow(params)
  function thunk()
    advanceWindow(params)
  end
  return thunk
end