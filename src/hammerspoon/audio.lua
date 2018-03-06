local log = hs.logger.new('audio.lua', 'debug')

function audiowatch(arg)
  log.df('Audiowatch arg: %s', arg)
end

hs.audiodevice.watcher.setCallback(audiowatch)
hs.audiodevice.watcher.start()

function audiodevwatch(dev_uid, event_name, event_scope, event_element)
  local device = hs.audiodevice.findDeviceByUID(dev_uid)
  log.df("Current device: %s", device);
  log.df("Audiodevwatch args: %s, %s, %s, %s", dev_uid, event_name, event_scope, event_element)
end

for i,dev in ipairs(hs.audiodevice.allOutputDevices()) do
  dev:watcherCallback(audiodevwatch):watcherStart()
  log.df("Setting up watcher for audio device %s", dev:name())
end

local builtIn = hs.audiodevice.findOutputByName('Built-in Output')
local schiit = hs.audiodevice.findOutputByName('Speaker-Schiit USB Audio Device')
local displayPort = hs.audiodevice.findOutputByName('DisplayPort')

if schiit then
  log.df("Setting output to Schiit...")
  schiit:setDefaultOutputDevice()
elseif displayPort then
  log.df("Setting output to DisplayPort...")
  displayPort:setDefaultOutputDevice()
else
  log.df("Setting output to Built-in...")
  builtIn:setDefaultOutputDevice()
end

