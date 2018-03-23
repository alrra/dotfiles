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

hyper = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}

col = hs.drawing.color.x11

hs.loadSpoon("SpoonInstall")

log.d("Collecting spoons...")

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/spdaly/Spoons",
  desc = "spdaly's spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true

Install=spoon.SpoonInstall

Install:andUse("Hammer",
               {
                 repo = 'spoons',
                 config = { auto_reload_config = false },
                 hotkeys = {
                   config_reload = {hyper, "`"},
                   toggle_console = {hyper, "y"}
                 },
                 start = true
               }
)


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

function reconfigSpotifyProxy(proxy)
  local spotify = hs.appfinder.appFromName("Spotify")
  local lastapp = nil
  if spotify then
    log.d("Shutdown Spotify...")
    lastapp = hs.application.frontmostApplication()
    spotify:kill()
    hs.timer.usleep(40000)
  end
  hs.notify.show(string.format("Reconfiguring %sSpotify", ((spotify~=nil) and "and restarting " or "")), string.format("Proxy %s", (proxy and "enabled" or "disabled")), "")
  if proxy then
    log.d("Turn on Spotify proxy...")
    cmd = "sed -i -e \"s/network.proxy.mode=1/network.proxy.mode=2/\" ~/Library/Application\\ Support/Spotify/prefs"
  else
    log.d("Turn off Spotify proxy...")
    cmd = "sed -i -e \"s/network.proxy.mode=2/network.proxy.mode=1/\" ~/Library/Application\\ Support/Spotify/prefs"
  end
  output, status, t, rc = hs.execute(cmd)
  if spotify and lastapp then
    hs.timer.doAfter(3,
                     function()
                       if not hs.application.launchOrFocus("Spotify") then
                         hs.notify.show("Error launching Spotify", "", "")
                       end
                       if lastapp then
                         hs.timer.doAfter(0.5, hs.fnutils.partial(lastapp.activate, lastapp))
                       end
    end)
  end
end

Install:andUse("WiFiTransitions",
               {
                 config = {
                   actions = {
                     { -- Test action just to see the SSID transitions
                        fn = function(_, _, prev_ssid, new_ssid)
                           hs.notify.show("SSID change", string.format("From '%s' to '%s'", prev_ssid, new_ssid), "")
                        end
                     },
                     { -- Enable proxy in Spotify and Adium config when joining corp network
                       to = "BLUESSO",
                       fn = {hs.fnutils.partial(reconfigSpotifyProxy, true)}
                     },
                     { -- Disable proxy in Spotify and Adium config when leaving corp network
                       from = "BLUESSO",
                       fn = {hs.fnutils.partial(reconfigSpotifyProxy, false)}
                     },
                   }
                 },
                 start = true,
               }
)

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()