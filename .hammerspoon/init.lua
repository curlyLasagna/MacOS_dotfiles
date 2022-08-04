-- hs.loadSpoon("DeepLTranslate")
-- Hold: Ctrl Key press: Esc
hs.loadSpoon("ControlEscape"):start()
hs.loadSpoon("MiroWindowsManager")
hs.loadSpoon("RecursiveBinder")
-- Easy move/resize windows with mouse
local SkyRocket = hs.loadSpoon("SkyRocket")
-- https://github.com/asmagill/hs._asm.undocumented.spaces
local spaces = require("hs._asm.undocumented.spaces")

sky = SkyRocket:new({
    opacity = 0.6,
    moveModifiers = { "ctrl" },
    resizeModifiers = { "ctrl", "shift" },
    moveMouseButton = "left",
    resizeMousebutton = "left",
})

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
    [singleKey("e", "Emacs")] = function()
        hs.application.launchOrFocus("emacs")
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

-- Reload config on save
myWatcher = hs.pathwatcher.new(hs.configdir, hs.reload)
myWatcher:start()

-- Send highlighted text to DeepL
-- spoon.DeepLTranslate:bindHotkeys({
--         translate = {hyper, "\\"}
--     })
