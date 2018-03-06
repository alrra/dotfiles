-- Enable this to do live debugging in ZeroBrane Studio
--local ZBS = "/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio"
--package.path = package.path .. ";" .. ZBS .. "/lualibs/?/?.lua;" .. ZBS .. "/lualibs/?.lua"
--package.cpath = package.cpath .. ";" .. ZBS .. "/bin/?.dylib;" .. ZBS .. "/bin/clibs53/?.dylib"
--require("mobdebug").start()

--local hmmrspn = "/Applications/Hammerspoon.app/Contents/Resources/extensions"
--package.path = package.path .. ";" .. hmmrspn .. "/?/?.lua"

-- TODO: https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html
require("hs.ipc")
local log = hs.logger.new('init.lua', 'debug')

log.d("Install CLI...")
hs.ipc.cliInstall()

hs.hotkey.bindSpec({{"ctrl", "cmd", "alt"}, "`"},
  function()
    log.d("Reloading config...")
    hs.reload()
  end)

hs.hotkey.bindSpec({{"ctrl", "cmd", "alt"}, "y"},
  function()
    log.d("Display console...")
    hs.toggleConsole()
  end)


keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

-- require('keyboard.control-escape')
-- require('keyboard.delete-words')
-- require('keyboard.hyper')
-- require('keyboard.markdown')
-- require('keyboard.microphone')
-- require('keyboard.panes')
-- require('keyboard.super')
require('windows')
require('audio')


workSSID = "BLUESSO"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()

  log.df("Current SSID: %s", newSSID);

  if newSSID == workSSID and lastSSID ~= workSSID then
    log.df("Joined ")
  elseif newSSID ~= wordSSID and lastSSID == workSSID then
    -- We just departed our home WiFi network
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

  lastSSID = newSSID
end

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()

wifiWatcher = nil
workSSID = "BLUESSO"
lastSSID = hs.wifi.currentNetwork()
log.df("SSID: %s", lastSSID)

function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()
  log.df("SSID changed to: %s", newSSID);
  if newSSID == workSSID and lastSSID ~= workSSID then
    -- Setup proxy information


  elseif newSSID ~= workSSID and lastSSID == workSSID then
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end
  lastSSID = newSSID
  hs.notify.new({title='Hammerspoon', informativeText='SSID: '..newSSID }):send()
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
