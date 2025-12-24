local base_cache_dir = vim.fn.stdpath("cache") .. "/vhs-era-theme"
local nested_cache_dir = base_cache_dir .. "/vhs-era-theme"

-- Ensure the directories exist
if vim.fn.isdirectory(nested_cache_dir) == 0 then
  vim.fn.mkdir(nested_cache_dir, "p")
end

local cache_path = nested_cache_dir .. "/cache.lua"

local M = {}

M.clear = function()
  local config = require("vhs-era-theme").config
  if config.disable_cache or config.hot_reload then
    return
  end
  if vim.fn.filereadable(cache_path) == 1 then
    assert(os.remove(cache_path))
  end
end

M.exists = function()
  local config = require("vhs-era-theme").config
  if config.disable_cache or config.hot_reload then
    return false
  end
  return vim.fn.filereadable(cache_path) == 1
end

M.write = function(colors)
  local config = require("vhs-era-theme").config
  if config.disable_cache or config.hot_reload then
    return
  end
  local serpent = require("vhs-era-theme.lib.serpent")
  local str = serpent.dump(colors)
  local file = io.open(cache_path, "wb")
  file:write(str)
  file:close()
end

M.read = function()
  local config = require("vhs-era-theme").config
  if config.disable_cache or config.hot_reload then
    return nil
  end

  local colors
  if vim.fn.filereadable(cache_path) == 1 then
    package.path = package.path
      .. ";"
      .. base_cache_dir
      .. "/?.lua;"
      .. base_cache_dir
      .. "/?/init.lua;"
      .. nested_cache_dir
      .. "/?.lua"

    colors = require("vhs-era-theme.cache")
  end

  if not colors then
    return nil
  end
  return colors
end

return M
