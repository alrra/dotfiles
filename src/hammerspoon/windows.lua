local log = hs.logger.new('windows.lua', 'debug')

hs.window.animationDuration = 0

function hs.window.left(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function hs.window.middle(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 5)
  f.w = max.w * 3/5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function hs.window.middleTwoThirds(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w * .165)
  f.w = max.w * .66
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function hs.window.middleThird(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w * .33)
  f.w = max.w * .33
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function hs.window.right(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function hs.window.up(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y
  f.h = max.h / 2
  win:setFrame(f)
end

function hs.window.down(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  win:setFrame(f)
end

function hs.window.center(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.w * 0.25
  f.y = max.h * 0.25
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.centerUp(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.w * 0.25
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.centerDown(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w * 0.25)
  f.y = max.h * 0.5
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.centerLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.h * 0.25
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.centerRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w/2)
  f.y = max.h * 0.25
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.upLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

function hs.window.upRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

function hs.window.downLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

function hs.window.downLeft25(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y + (max.h * .75)
  f.w = max.w * .25
  f.h = max.h * .25
  win:setFrame(f)
end

function hs.window.downRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

function hs.window.downRight25(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w * .75)
  f.y = max.y + (max.h * .75)
  f.w = max.w * .25
  f.h = max.h * .25

  win:setFrame(f)
end

function hs.window.left70(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.7
  f.h = max.h
  win:setFrame(f)
end

function hs.window.left30(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.3
  f.h = max.h
  win:setFrame(f)
end

function hs.window.right70(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 0.3
  f.y = max.y
  f.w = max.w * 0.7
  f.h = max.h
  win:setFrame(f)
end

function hs.window.right30(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 0.7
  f.y = max.y
  f.w = max.w * 0.3
  f.h = max.h
  win:setFrame(f)
end

function hs.window.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex])
  else
    win:moveToScreen(allScreens[1])
  end
end


-- windowLayoutMode = hs.hotkey.modal.new({}, 'F16')

-- local message = require('keyboard.status-message')
-- windowLayoutMode.statusMessage = message.new('Window Layout Mode (control-s)')
-- windowLayoutMode.entered = function()
--   windowLayoutMode.statusMessage:show()
-- end
-- windowLayoutMode.exited = function()
--   windowLayoutMode.statusMessage:hide()
-- end

-- -- Bind the given key to call the given function and exit WindowLayout mode
-- function windowLayoutMode.bindWithAutomaticExit(mode, modifiers, key, fn)
--   mode:bind(modifiers, key, function()
--     mode:exit()
--     fn()
--   end)
-- end

-- windowLayoutMode:bindWithAutomaticExit({}, 'return', function()
--   hs.window.focusedWindow():maximize()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'space', function()
--   hs.window.focusedWindow():centerWithFullHeight()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'h', function()
--   hs.window.focusedWindow():left()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'j', function()
--   hs.window.focusedWindow():down()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'k', function()
--   hs.window.focusedWindow():up()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'l', function()
--   hs.window.focusedWindow():right()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({'shift'}, 'h', function()
--   hs.window.focusedWindow():left40()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({'shift'}, 'l', function()
--   hs.window.focusedWindow():right60()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'i', function()
--   hs.window.focusedWindow():upLeft()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'o', function()
--   hs.window.focusedWindow():upRight()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, ',', function()
--   hs.window.focusedWindow():downLeft()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, '.', function()
--   hs.window.focusedWindow():downRight()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'n', function()
--   hs.window.focusedWindow():nextScreen()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'right', function()
--   hs.window.focusedWindow():moveOneScreenEast()
-- end)

-- windowLayoutMode:bindWithAutomaticExit({}, 'left', function()
--   hs.window.focusedWindow():moveOneScreenWest()
-- end)

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'j', function()
  hs.window.focusedWindow():left()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'k', function()
  hs.window.focusedWindow():middle()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'l', function()
  hs.window.focusedWindow():right()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'i', function()
  hs.window.focusedWindow():middleTwoThirds()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, ',', function()
  hs.window.focusedWindow():middleThird()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'm', function()
  hs.window.focusedWindow():left30()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '.', function()
  hs.window.focusedWindow():right30()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'u', function()
  hs.window.focusedWindow():left70()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'o', function()
  hs.window.focusedWindow():right70()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'u', function()
  hs.window.focusedWindow():upLeft()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'o', function()
  hs.window.focusedWindow():upRight()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'm', function()
  hs.window.focusedWindow():downLeft()
end)
hs.hotkey.bind({'shift', 'cmd'}, '.', function()
  hs.window.focusedWindow():downRight()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'k', function()
  hs.window.focusedWindow():center()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'j', function()
  hs.window.focusedWindow():centerLeft()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'l', function()
  hs.window.focusedWindow():centerRight()
end)
hs.hotkey.bind({'shift', 'cmd'}, 'i', function()
  hs.window.focusedWindow():centerUp()
end)
hs.hotkey.bind({'shift', 'cmd'}, ',', function()
  hs.window.focusedWindow():centerDown()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'right', function()
  hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'left', function()
  hs.window.focusedWindow():moveOneScreenWest()
end)
hs.hotkey.bind({'ctrl', 'cmd'}, 'i', function()
  hs.window.focusedWindow():up()
end)
hs.hotkey.bind({'ctrl', 'cmd'}, ',', function()
  hs.window.focusedWindow():down()
end)
hs.hotkey.bind({'ctrl', 'cmd'}, 'm', function()
  hs.window.focusedWindow():downLeft25()
end)
hs.hotkey.bind({'ctrl', 'cmd'}, '.', function()
  hs.window.focusedWindow():downRight25()
end)
hs.hotkey.bind({'ctrl', 'cmd', 'alt'}, 'return', function()
  hs.window.focusedWindow():maximize()
end)
