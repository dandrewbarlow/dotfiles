-- yay init.lua
-- lua config file for yay AUR manager
--
-- 6/20/26: yay recently added postinstall lua hooks after AUR security incidents 
-- w/ orphaned packages being adopted and used as malware. Added two of their example
-- scripts which avoid updating AUR packages if 1. maintainer was recently changed, or
-- 2. the aur package was modified in the last 3 days. Should hopefully help avoid any 
-- sloppy malware attacks.



-- recently_modified.lua
-- https://github.com/Jguer/yay/blob/next/doc/examples/recently_modified.lua

yay.create_autocmd("UpgradeSelect", {
  desc = "skip recently modified AUR upgrades",
  callback = function(event)
    yay.log.info("pre-excluding AUR packages modified in the last 3 days")
    local exclude = {}
    local recent_cutoff = os.time() - (3 * 24 * 60 * 60)
    for _, pkg in ipairs(event.data.upgrades) do
      if pkg.repository == "aur" and pkg.last_modified >= recent_cutoff then
        yay.log.warn("pre-excluding recently modified AUR package: ", pkg.name)
        table.insert(exclude, pkg.name)
      end
    end

    return { exclude = exclude, skip_menu = false }
  end,
})

-- maintainer_change.lua
-- https://github.com/Jguer/yay/blob/next/doc/examples/maintainer_change.lua

-- Warn when an AUR package's maintainer changes between upgrades.
--
-- The known maintainer for each package is stored in a plain text cache file
-- inside the yay cache directory (build_dir). On the first upgrade for a
-- package the current maintainer is recorded without any warning. On
-- subsequent upgrades:
--   * same maintainer  → debug "match correct"
--   * different maintainer → error "new maintainer, double check build files"
--
-- The cache is updated whenever a new or changed maintainer is seen.
--
-- Cache file location: <cache_dir>/maintainer_cache
-- Format: one "pkgname=maintainer" entry per line.

-- missing reliable cfg getter
local cache_dir = (os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/yay"
local cache_file = cache_dir .. "/maintainer_cache"

local function load_cache()
  local cache = {}
  local f = io.open(cache_file, "r")
  if not f then return cache end
  for line in f:lines() do
    local name, maintainer = line:match("^([^=]+)=(.*)$")
    if name then
      cache[name] = maintainer
    end
  end
  f:close()
  return cache
end

local function save_cache(cache)
  local f = assert(io.open(cache_file, "w"))
  for name, maintainer in pairs(cache) do
    f:write(name .. "=" .. maintainer .. "\n")
  end
  f:close()
end

yay.create_autocmd("UpgradeSelect", {
  desc = "warn on AUR maintainer changes",
  callback = function(event)
    yay.log.info("checking for AUR maintainer changes")
    local cache = load_cache()
    local dirty = false

    for _, pkg in ipairs(event.data.upgrades) do
      if pkg.repository == "aur" and pkg.maintainer ~= "" then
        local cached = cache[pkg.name]
        if cached == nil then
          -- First time seeing this package: seed the cache silently.
          cache[pkg.name] = pkg.maintainer
          dirty = true
        elseif cached == pkg.maintainer then
          yay.log.debug("match correct: " .. pkg.name .. " " .. pkg.maintainer)
        else
          yay.log.error("new maintainer, double check build files: ", pkg.name,
            "(was: " .. cached .. ", now: " .. pkg.maintainer .. ")")
          cache[pkg.name] = pkg.maintainer
          dirty = true
        end
      end
    end

    if dirty then
      yay.log.info("saving maintainer cache:", cache_file)
      save_cache(cache)
    end

    return { exclude = {}, skip_menu = false }
  end,
})
