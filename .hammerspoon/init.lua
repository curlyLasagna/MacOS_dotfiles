-- hs.loadSpoon("DeepLTranslate")
-- Hold: Ctrl Key press: Esc
hs.loadSpoon("ControlEscape"):start()
hs.loadSpoon("MiroWindowsManager")
hs.loadSpoon("RecursiveBinder")
-- Easy move/resize windows with mouse
-- local SkyRocket = hs.loadSpoon("SkyRocket")

-- sky = SkyRocket:new({
--   opacity = 0.6,
--   moveModifiers = { "ctrl" },
--   resizeModifiers = { "ctrl", "shift" },
--   moveMouseButton = "left",
--   resizeMousebutton = "left",
-- })

-- Window management
local win_mods = { "ctrl", "alt" }
spoon.MiroWindowsManager:bindHotkeys({
  up = { win_mods, "k" },
  right = { win_mods, "l" },
  down = { win_mods, "j" },
  left = { win_mods, "h" },
  fullscreen = { win_mods, "space" },
})

spoon.RecursiveBinder.helperFormat = {
  textStyle = {
    font = {
      name = "Font Awesome 5 Free",
      size = 16,
    },
  },
}
local singleKey = spoon.RecursiveBinder.singleKey
local recursiveMap = {
  [singleKey("m", "Mail")] = function()
    hs.application.launchOrFocus("Mail")
  end,
  [singleKey(",", "Settings")] = function()
    hs.application.launchOrFocus("System Preferences")
  end,
  [singleKey("t", "Terminal")] = function()
    hs.application.launchOrFocus("alacritty")
  end,
  [singleKey("i", "iMessage")] = function()
    hs.application.launchOrFocus("Messages")
  end,
  [singleKey("d", "Open URL")] = {
    [singleKey("r", "reddit")] = function()
      hs.urlevent.openURL("https://reddit.com")
    end,
    [singleKey("y", "Youtube")] = function()
      hs.urlevent.openURL("https://youtube.com")
    end,
  },
}

hs.hotkey.bind(
  win_mods, ";",
  spoon.RecursiveBinder.recursiveBind(recursiveMap)
)

-- Keybinds
hs.hotkey.bind(win_mods, "[", function()
  focusScreen(1)
end)

hs.hotkey.bind(win_mods, "]", function()
  focusScreen(-1)
end)

hs.hotkey.bind(win_mods, "n", function()
  moveNextScreenStep()
end)

hs.hotkey.bind({ "alt" }, "e", function()
  hs.application.open("Finder.app")
end)

hs.hotkey.bind({ "alt", "cmd" }, "m", function()
  hs.osascript.applescriptFromFile(
    "/Users/luis/.local/bin/hide_Bar.scpt"
  )
end)

-- Functions
function moveNextScreenStep()
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()

    win:move(
      win:frame():toUnitRect(screen:frame()),
      screen:next(),
      true,
      0
    )
  end
end

lastMousePosOnScreen = {}

function focusScreen(rel)
  local focusedWin = hs.window.focusedWindow()
  local screen = focusedWin:screen()
  local curPos = hs.mouse.getRelativePosition()
  -- remember mouse position if focused screen == mouse screen
  if screen == hs.mouse.getCurrentScreen() then
    lastMousePosOnScreen[screen:getUUID()] = curPos
  end
  if rel == 1 then
    screen = screen:next()
  elseif rel == -1 then
    screen = screen:previous()
  end
  for _, win in ipairs(hs.window.orderedWindows()) do
    if win:screen() == screen then
      win:focus()
      break
    end
  end
  local prevPos = lastMousePosOnScreen[screen:getUUID()]
  if prevPos then
    hs.mouse.setRelativePosition(prevPos, screen)
  else
    local center = screen:fullFrame().center
    local frame = screen:fullFrame()
    local rel = {}
    rel["x"] = center["x"] - frame["x"]
    rel["y"] = center["y"] - frame["y"]
    hs.mouse.setRelativePosition(rel, screen)
  end
end

-- 3rd party mouse back/forward
-- https://tom-henderson.github.io/2018/12/14/hammerspoon.html
enhancedMouse = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
  local button = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])

  if (button == 2) then
    hs.application.launchOrFocus("Mission Control.app")
  elseif (button == 3) then
    hs.eventtap.keyStroke({ "cmd" }, "[")
  elseif (button == 4) then
    hs.eventtap.keyStroke({ "cmd" }, "]")
  end

  return true
end)

enhancedMouse:start()

navMouse = hs.eventtap.new({hs.eventtap.event.types.leftMouseDown}, function (e)
 
end)
-- Print which mouse button is clicked
-- https://apple.stackexchange.com/questions/362776/utility-to-identify-what-mouse-buttons-are-being-pressed
detectMouseDown = hs.eventtap.new({
  hs.eventtap.event.types.otherMouseDown,
  hs.eventtap.event.types.leftMouseDown,
  hs.eventtap.event.types.rightMouseDown
}, function(e)
  local button = e:getProperty(
    hs.eventtap.event.properties['mouseEventButtonNumber']
  )
  print(string.format("Clicked Mouse Button: %i", button))
end)

-- https://github.com/tekezo/Karabiner/issues/814
-- HANDLE SCROLLING
-- local oldmousepos = {}
-- -- positive multiplier (== natural scrolling) makes mouse work like traditional scrollwheel
-- local scrollmult = 4

-- The were all events logged, when using `{"all"}`
-- mousetap = hs.eventtap.new({0,3,5,14,25,26,27}, function(e)
-- 	oldmousepos = hs.mouse.getAbsolutePosition()
-- 	local mods = hs.eventtap.checkKeyboardModifiers()
--     local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])

--     -- If OSX button 4 is pressed, allow scrolling
--     local shouldScroll = 3 == pressedMouseButton
--     if shouldScroll then
-- 		local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
-- 		local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
-- 		local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
-- 		scroll:post()

-- 		-- put the mouse back
-- 		hs.mouse.setAbsolutePosition(oldmousepos)

-- 		return true, {scroll}
-- 	else
-- 		return false, {}
-- 	end
-- 	-- print ("Mouse moved!")
-- 	-- print (dx)
-- 	-- print (dy)
-- end)
-- mousetap:start()

-- Reload config on save
myWatcher = hs.pathwatcher.new(hs.configdir, hs.reload)
myWatcher:start()

-- Send highlighted text to DeepL
-- spoon.DeepLTranslate:bindHotkeys({
--         translate = {hyper, "\\"}
--     })
