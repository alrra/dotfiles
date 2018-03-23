--- === WiFiTransitions ===
---
--- Allow arbitrary actions when transitioning between SSIDs
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/WiFiTransitions.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/WiFiTransitions.spoon.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "WiFiTransitions"
obj.version = "0.1"
obj.author = "Diego Zamboni <diego@zzamboni.org>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- WiFiTransitions.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('WiFiTransitions')

--- WiFiTransitions.actions
--- Variable
--- Table containing a list of actions to execute for SSID transitions. Each action is itself a table with the following keys:
---  * to - if given, pattern to match against the new SSID. Defaults to match any network. Transitions through the disabled state are ignored (i.e. normally a `nil` SSID is reported when switching SSIDs)
---  * from - if given, pattern to match against the previous SSID. Defaults to match any network.
---  * fn - function to execute if there is a match. Can also be a list of functions, which will be executed in sequence. Each function will receive the following arguments:
---    * event - always "SSIDChange"
---    * interface - name of the interface on which the SSID changed
---    * old_ssid - previous SSID name
---    * new_ssid - new SSID name
---  * cmd - shell command to execute if there is a match. Can also be a list of commands, which will be executed in sequence using `hs.execute`. If `fn` is given, `cmd` is ignored.
obj.actions = {}

-- Internal variable - previous SSID
obj.previous_ssid = nil
-- Internal variable - hs.wifi.watcher object
obj.wifiwatcher = nil

-- Internal function to match SSIDs against a pattern
function obj.ssid_match(ssid, spec)
   return
      -- No spec ssid given, or
      (spec == nil) or
      -- ...spec ssid and given ssid match
      ((ssid ~= nil) and (spec ~= nil) and (string.find(ssid, spec) ~= nil))
end

--- WiFiTransitions:processTransition(new_ssid, prev_ssid, interface)
--- Method
--- Process the rules and execute any actions corresponding to the specified transition.
---
--- This method is called internally by the `hs.wifi.watcher` object
--- when WiFi transitions happen. It does not get any system
--- information nor does it set any Spoon state information, so it can
--- also be used to "trigger" transitions manually, either for testing
--- or if the automated processing fails for any reason.
---
--- Parameters:
---  * new_ssid - new SSID name
---  * prev_ssid - previous SSID name. Defaults to `nil`
---  * interface - interface where the transition occurred. Defaults to `nil`
function obj:processTransition(new_ssid, prev_ssid, interface)
   self.logger.df("Processing transition new_ssid=%s, prev_ssid=%s, interface=%s", new_ssid, prev_ssid, interface)
   if new_ssid ~= nil then
      for _,a in ipairs(self.actions) do
         self.logger.df("  Evaluating spec %s", hs.inspect(a))
         if self.ssid_match(prev_ssid, a.from) and self.ssid_match(new_ssid, a.to) and (new_ssid ~= prev_ssid) then
            self.logger.df("    Match!")
            if a.fn then
               local fns=a.fn
               if type(fns) == "function" then fns = {fns} end
               for _,f in ipairs(fns) do
                  f(event, interface, prev_ssid, new_ssid)
               end
            elseif a.cmd then
               local cmds=a.cmd
               if type(cmds) == "string" then cmds = {cmds} end
               for _,c in ipairs(cmds) do
                  hs.execute(c)
               end
            else
               self.logger.ef("No fn/cmd action defined in spec %s", hs.inspect(a))
            end
         end
      end
   end
end

-- Internal hs.wifi.watcher callback function
function obj:wifiwatcher(watcher, event, interface)
   local new_ssid = hs.wifi.currentNetwork()
   local prev_ssid = self.previous_ssid
   self.logger.df("New WiFi event %s, interface=%s", event, interface)
   self:processTransition(new_ssid, prev_ssid, interface)
   self.previous_ssid = new_ssid
end

--- WiFiTransitions:start()
--- Method
--- Start the WiFi watcher
---
--- Returns:
---  * The WiFiTransitions spoon object
function obj:start()
   self.previous_ssid = hs.wifi.currentNetwork()
   self.wifiwatcher=hs.wifi.watcher.new(hs.fnutils.partial(self.wifiwatcher, self)):start()
   return self
end

return obj
