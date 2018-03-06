--- === SpoonInstall ===
---
--- Install and manage Spoons and Spoon repositories
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "SpoonInstall"
obj.version = "0.1"
obj.author = "Diego Zamboni <diego@zzamboni.org>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- SpoonInstall.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('SpoonInstall')

--- SpoonInstall.repos
--- Variable
--- Table containing the list of available Spoon repositories. The key
--- of each entry is an identifier for the repository, and its value
--- is a table with the following entries:
---  * desc - Human-readable description for the repository
---  * url - Base URL for the repository. For now the repository is assumed to be hosted in GitHub, and the URL should be the main base URL of the repository. Repository metadata needs to be stored under `docs/docs.json`, and the Spoon zip files need to be stored under `Spoons/`.
---
--- Default value:
--- ```
--- {
---    default = {
---       url = "https://github.com/Hammerspoon/Spoons",
---       desc = "Main Hammerspoon Spoon repository",
---    }
--- }
--- ```
obj.repos = {
   default = {
      url = "https://github.com/Hammerspoon/Spoons",
      desc = "Main Hammerspoon Spoon repository",
   }
}

--- SpoonInstall.use_syncinstall
--- Variable
--- If `true`, `andUse()` will update repos and install packages synchronously. Defaults to `false`.
---
--- Keep in mind that if you set this to `true`, Hammerspoon will
--- block until all missing Spoons are installed, but the notifications
--- will happen at a more "human readable" rate.
obj.use_syncinstall = false

-- Execute a command and return its output with trailing EOLs trimmed. If the command fails, an error message is logged.
local function _x(cmd, errfmt, ...)
   local output, status = hs.execute(cmd)
   if status then
      local trimstr = string.gsub(output, "\n*$", "")
      return trimstr
   else
      obj.logger.ef(errfmt, ...)
      return nil
   end
end

-- --------------------------------------------------------------------
-- Spoon repository management

-- Internal callback to process and store the data from docs.json about a repository
-- callback is called with repo as arguments, only if the call is successful
function obj:_storeRepoJSON(repo, callback, status, body, hdrs)
   local success=nil
   if (status < 100) or (status >= 400) then
      self.logger.ef("Error fetching JSON data for repository '%s'. Error code %d: %s", repo, status, body or "<no error message>")
   else
      local json = hs.json.decode(body)
      if json then
         self.repos[repo].data = {}
         for i,v in ipairs(json) do
            v.download_url = self.repos[repo].download_base_url .. v.name .. ".spoon.zip"
            self.repos[repo].data[v.name] = v
         end
         self.logger.df("Updated JSON data for repository '%s'", repo)
         success=true
      else
         self.logger.ef("Invalid JSON received for repository '%s': %s", repo, body)
      end
   end
   if callback then
      callback(repo, success)
   end
   return success
end

-- Internal function to return the URL of the docs.json file based on the URL of a GitHub repo
function obj:_build_repo_json_url(repo)
   if self.repos[repo] and self.repos[repo].url then
      self.repos[repo].json_url = string.gsub(self.repos[repo].url, "/$", "") .. "/raw/master/docs/docs.json"
      self.repos[repo].download_base_url = string.gsub(self.repos[repo].url, "/$", "") .. "/raw/master/Spoons/"
      return true
   else
      self.logger.ef("Invalid or unknown repository '%s'", repo)
      return nil
   end
end

--- SpoonInstall:asyncUpdateRepo(repo, callback)
--- Method
--- Asynchronously fetch the information about the contents of a Spoon repository
---
--- Parameters:
---  * repo - name of the repository to update. Defaults to `"default"`.
---  * callback - if given, a function to be called after the update finishes (also if it fails). The function will receive the following arguments:
---    * repo - name of the repository
---    * success - boolean indicating whether the update succeeded
---
--- Returns:
---  * `true` if the update was correctly initiated (i.e. the repo name is valid), `nil` otherwise
---
--- Notes:
---  * For now, the repository data is not persisted, so you need to update it after every restart if you want to use any of the install functions.
function obj:asyncUpdateRepo(repo, callback)
   if not repo then repo = 'default' end
   if self:_build_repo_json_url(repo) then
      hs.http.asyncGet(self.repos[repo].json_url, nil, hs.fnutils.partial(self._storeRepoJSON, self, repo, callback))
      return true
   else
      return nil
   end
end

--- SpoonInstall:updateRepo(repo)
--- Method
--- Synchronously fetch the information about the contents of a Spoon repository
---
--- Parameters:
---  * repo - name of the repository to update. Defaults to `"default"`.
---
--- Returns:
---  * `true` if the update was successful, `nil` otherwise
---
--- Notes:
---  * This is a synchronous call, which means Hammerspoon will be blocked until it finishes. For use in your configuration files, it's advisable to use `SpoonInstall.asyncUpdateRepo()` instead.
---  * For now, the repository data is not persisted, so you need to update it after every restart if you want to use any of the install functions.
function obj:updateRepo(repo)
   if not repo then repo = 'default' end
   if self:_build_repo_json_url(repo) then
      local a,b,c = hs.http.get(self.repos[repo].json_url)
      return self:_storeRepoJSON(repo, nil, a, b, c)
   else
      return nil
   end
end

--- SpoonInstall:updateAllRepos()
--- Method
--- Synchronously fetch the information about the contents of all Spoon repositories registered in `SpoonInstall.repos`
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
---
--- Notes:
---  * This is a synchronous call, which means Hammerspoon will be blocked until it finishes.
---  * For now, the repository data is not persisted, so you need to update it after every restart if you want to use any of the install functions.
function obj:updateAllRepos()
   for k,v in pairs(self.repos) do
      self:updateRepo(k)
   end
end

--- SpoonInstall:repolist()
--- Method
--- Return a sorted list of registered Spoon repositories
---
--- Parameters:
---  * None
---
--- Returns:
---  * Table containing a list of strings with the repository identifiers
function obj:repolist()
   local keys={}
   -- Create sorted list of keys
   for k,v in pairs(self.repos) do table.insert(keys, k) end
   table.sort(keys)
   return keys
end

--- SpoonInstall:search(pat)
--- Method
--- Search repositories for a pattern
---
--- Parameters:
---  * pat - Lua pattern that will be matched against the name and description of each spoon in the registered repositories. All text is converted to lowercase before searching it, so you can use all-lowercase in your pattern.
---
--- Returns:
---  * Table containing a list of matching entries. Each entry is a table with the following keys:
---    * name - Spoon name
---    * desc - description of the spoon
---    * repo - identifier in the repository where the match was found
function obj:search(pat)
   local res={}
   for repo,v in pairs(self.repos) do
      if v.data then
         for spoon,rec in pairs(v.data) do
            if string.find(string.lower(rec.name .. "\n" .. rec.desc), pat) then
               table.insert(res, { name = rec.name, desc = rec.desc, repo = repo })
            end
         end
      else
         self.logger.ef("Repository data for '%s' not available - call spoon.SpoonInstall:updateRepo('%s'), then try again.", repo, repo)
      end
   end
   return res
end

-- --------------------------------------------------------------------
-- Spoon installation

-- Internal callback function to finalize the installation of a spoon after the zip file has been downloaded.
-- callback, if given, is called with (urlparts, success) as arguments
function obj:_installSpoonFromZipURLgetCallback(urlparts, callback, status, body, headers)
   local success=nil
   if (status < 100) or (status >= 400) then
      self.logger.ef("Error downloading %s. Error code %d: %s", urlparts.absoluteString, status, body or "<none>")
   else
      -- Write the zip file to disk in a temporary directory
      local tmpdir=_x("/usr/bin/mktemp -d", "Error creating temporary directory to download new spoon.")
      if tmpdir then
         local outfile = string.format("%s/%s", tmpdir, urlparts.lastPathComponent)
         local f=assert(io.open(outfile, "w"))
         f:write(body)
         f:close()

         -- Check its contents - only one *.spoon directory should be in there
         output = _x(string.format("/usr/bin/unzip -l %s '*.spoon/' | /usr/bin/awk '$NF ~ /\\.spoon\\/$/ { print $NF }' | /usr/bin/wc -l", outfile),
                     "Error examining downloaded zip file %s, leaving it in place for your examination.", outfile)
         if output then
            if (tonumber(output) or 0) == 1 then
               -- Uncompress the zip file
               local outdir = string.format("%s/Spoons", hs.configdir)
               if _x(string.format("/usr/bin/unzip -o %s -d %s 2>&1", outfile, outdir),
                     "Error uncompressing file %s, leaving it in place for your examination.", outfile) then
                  -- And finally, install it using Hammerspoon itself
                  self.logger.f("Downloaded and installed %s", urlparts.absoluteString)
                  _x(string.format("/bin/rm -rf '%s'", tmpdir), "Error removing directory %s", tmpdir)
                  success=true
               end
            else
               self.logger.ef("The downloaded zip file %s is invalid - it should contain exactly one spoon. Leaving it in place for your examination.", outfile) 
            end
         end
      end
   end
   if callback then
      callback(urlparts, success)
   end
   return success
end

--- SpoonInstall:asyncInstallSpoonFromZipURL(url, callback)
--- Method
--- Asynchronously download a Spoon zip file and install it.
---
--- Parameters:
---  * url - URL of the zip file to install.
---  * callback - if given, a function to call after the installation finishes (also if it fails). The function receives the following arguments:
---    * urlparts - Result of calling `hs.http.urlParts` on the URL of the Spoon zip file
---    * success - boolean indicating whether the installation was successful
---
--- Returns:
---  * `true` if the installation was correctly initiated (i.e. the URL is valid), `false` otherwise
function obj:asyncInstallSpoonFromZipURL(url, callback)
   local urlparts = hs.http.urlParts(url)
   local dlfile = urlparts.lastPathComponent
   if dlfile and dlfile ~= "" and urlparts.pathExtension == "zip" then
      hs.http.asyncGet(url, nil, hs.fnutils.partial(self._installSpoonFromZipURLgetCallback, self, urlparts, callback))
      return true
   else
      self.logger.ef("Invalid URL %s, must point to a zip file", url)
      return nil
   end
end

--- SpoonInstall:installSpoonFromZipURL(url)
--- Method
--- Synchronously download a Spoon zip file and install it.
---
--- Parameters:
---  * url - URL of the zip file to install.
---
--- Returns:
---  * `true` if the installation was successful, `nil` otherwise
function obj:installSpoonFromZipURL(url)
   local urlparts = hs.http.urlParts(url)
   local dlfile = urlparts.lastPathComponent
   if dlfile and dlfile ~= "" and urlparts.pathExtension == "zip" then
      a,b,c=hs.http.get(url)
      return self:_installSpoonFromZipURLgetCallback(urlparts, nil, a, b, c)
   else
      self.logger.ef("Invalid URL %s, must point to a zip file", url)
      return nil
   end
end

-- Internal function to check if a Spoon/Repo combination is valid
function obj:_is_valid_spoon(name, repo)
   if self.repos[repo] then
      if self.repos[repo].data then
         if self.repos[repo].data[name] then
            return true
         else
            self.logger.ef("Spoon '%s' does not exist in repository '%s'. Please check and try again.", name, repo)
         end
      else
         self.logger.ef("Repository data for '%s' not available - call spoon.SpoonInstall:updateRepo('%s'), then try again.", repo, repo)
      end
   else
      self.logger.ef("Invalid or unknown repository '%s'", repo)
   end
   return nil
end

--- SpoonInstall:asyncInstallSpoonFromRepo(name, repo, callback)
--- Method
--- Asynchronously install a Spoon from a registered repository
---
--- Parameters:
---  * name - Name of the Spoon to install.
---  * repo - Name of the repository to use. Defaults to `"default"`
---  * callback - if given, a function to call after the installation finishes (also if it fails). The function receives the following arguments:
---    * urlparts - Result of calling `hs.http.urlParts` on the URL of the Spoon zip file
---    * success - boolean indicating whether the installation was successful
---
--- Returns:
---  * `true` if the installation was correctly initiated (i.e. the repo and spoon name were correct), `false` otherwise.
function obj:asyncInstallSpoonFromRepo(name, repo, callback)
   if not repo then repo = 'default' end
   if self:_is_valid_spoon(name, repo) then
      self:asyncInstallSpoonFromZipURL(self.repos[repo].data[name].download_url, callback)
   end
   return nil
end

--- SpoonInstall:installSpoonFromRepo(name, repo)
--- Method
--- Synchronously install a Spoon from a registered repository
---
--- Parameters:
---  * name = Name of the Spoon to install.
---  * repo - Name of the repository to use. Defaults to `"default"`
---
--- Returns:
---  * `true` if the installation was successful, `nil` otherwise.
function obj:installSpoonFromRepo(name, repo, callback)
   if not repo then repo = 'default' end
   if self:_is_valid_spoon(name, repo) then
      return self:installSpoonFromZipURL(self.repos[repo].data[name].download_url)
   end
   return nil
end

--- SpoonInstall:andUse(name, arg)
--- Method
--- Declaratively install, load and configure a Spoon
---
--- Parameters:
---  * name - the name of the Spoon to install (without the `.spoon` extension). If the Spoon is already installed, it will be loaded using `hs.loadSpoon()`. If it is not installed, it will be installed using `SpoonInstall:asyncInstallSpoonFromRepo()` and then loaded.
---  * arg - if provided, can be used to specify the configuration of the Spoon. The following keys are recognized (all are optional):
---    * repo - repository from where the Spoon should be installed if not present in the system, as defined in `SpoonInstall.repos`. Defaults to `"default"`.
---    * config - a table containing variables to be stored in the Spoon object to configure it. For example, `config = { answer = 42 }` will result in `spoon.<LoadedSpoon>.answer` being set to 42.
---    * hotkeys - a table containing hotkey bindings. If provided, will be passed as-is to the Spoon's `bindHotkeys()` method. The special string `"default"` can be given to use the Spoons `defaultHotkeys` variable, if it exists.
---    * fn - a function which will be called with the freshly-loaded Spoon object as its first argument.
---    * loglevel - if the Spoon has a variable called `logger`, its `setLogLevel()` method will be called with this value.
---    * start - if `true`, call the Spoon's `start()` method after configuring everything else.
---    * disable - if `true`, do nothing. Easier than commenting it out when you want to temporarily disable a spoon.
---
--- Returns:
---  * None
function obj:andUse(name, arg)
   if not arg then arg = {} end
   if arg.disable then return true end
   if hs.spoons.use(name, arg, true) then
      return true
   else
      local repo = arg.repo or "default"
      if self.repos[repo] then
         if self.repos[repo].data then
            local load_and_config = function(_, success)
               if success then
                  hs.notify.show("Spoon installed by SpoonInstall", name .. ".spoon is now available", "")
                  hs.spoons.use(name, arg)
               else
                  obj.logger.ef("Error installing Spoon '%s' from repo '%s'", name, repo)
               end
            end
            if self.use_syncinstall then
               return load_and_config(nil, self:installSpoonFromRepo(name, repo))
            else
               self:asyncInstallSpoonFromRepo(name, repo, load_and_config)
            end
         else
            local update_repo_and_continue = function(_, success)
               if success then
                  obj:andUse(name, arg)
               else
                  obj.logger.ef("Error updating repository '%s'", repo)
               end
            end
            if self.use_syncinstall then
               return update_repo_and_continue(nil, self:updateRepo(repo))
            else
               self:asyncUpdateRepo(repo, update_repo_and_continue)
            end
         end
      else
         obj.logger.ef("Unknown repository '%s' for Spoon", repo, name)
      end
   end
end

return obj
