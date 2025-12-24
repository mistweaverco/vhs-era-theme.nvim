local uv = vim.loop

-- Store the handle and path to keep them alive
local watch_handle = nil
local watch_path = nil

local function reload_colorscheme()
  -- Protect critical modules from being cleared
  local hotreload_module = package.loaded["vhs-era-theme.lib.hotreload"]
  local init_module = package.loaded["vhs-era-theme"]
  
  -- Clear module cache for colorscheme-related modules
  package.loaded["vhs-era-theme.palette.colors"] = nil
  package.loaded["vhs-era-theme.colorscheme"] = nil
  
  -- Reload the colorscheme
  require("vhs-era-theme").reload()
  
  -- Restore protected modules if they were cleared
  if not package.loaded["vhs-era-theme.lib.hotreload"] and hotreload_module then
    package.loaded["vhs-era-theme.lib.hotreload"] = hotreload_module
  end
  if not package.loaded["vhs-era-theme"] and init_module then
    package.loaded["vhs-era-theme"] = init_module
  end
  
  -- Restart watcher after reload completes (schedule to avoid interfering with current event)
  if watch_path then
    vim.schedule(function()
      local M = package.loaded["vhs-era-theme.lib.hotreload"]
      if M and M.watch then
        -- Restart the watcher to ensure it continues working
        M.watch(watch_path)
      end
    end)
  end
  vim.cmd("colorscheme vhs-era-theme")
  vim.notify("Colorscheme reloaded", vim.log.levels.INFO)
end

-- Store callback at module level to keep it alive
local function on_event(err, filename, events)
  if err then
    vim.notify("Error in vhs-era-theme.nvim hot_reload fs_event: " .. err, vim.log.levels.ERROR)
  else
    if events.change == nil then
      return
    end
    reload_colorscheme()
  end
end

-- Store event callback at module level
local function event_cb(err, filename, events)
  if err then
    vim.notify("Error in vhs-era-theme.nvim hot_reload fs_event: " .. err, vim.log.levels.ERROR)
  else
    vim.schedule(function()
      on_event(err, filename, events)
    end)
  end
end

local M = {}

M.watch = function(path)
  -- Stop existing watcher if any
  if watch_handle then
    watch_handle:stop()
    watch_handle:close()
    watch_handle = nil
  end

  watch_path = path
  watch_handle = uv.new_fs_event()

  local flags = {
    watch_entry = false,
    stat = false,
    recursive = false,
  }

  -- Use the module-level callback
  uv.fs_event_start(watch_handle, path, flags, event_cb)
end

return M
