local cache = require("vhs-era-theme.lib.cache")

local M = {}

local defaultConfig = {
  italic_comments = true,
  disable_cache = false,
  hot_reload = false,
}

M.config = defaultConfig

local function load_colorscheme()
  local colors

  if not M.config.hot_reload and (cache.exists() and not M.config.disable_cache) then
    colors = cache.read()
  else
    colors = require("vhs-era-theme.colors")
    cache.write(colors)
  end

  vim.cmd("highlight clear")
  vim.cmd("set t_Co=256")

  for group, attrs in pairs(colors) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

function M.reload() M.load() end

function M.load()
  load_colorscheme()
  vim.g.colors_name = "vhs-era-theme"
end

function M.clear_cache() require("vhs-era-theme.lib.cache").clear() end

function M.setup(options)
  M.config = vim.tbl_deep_extend("force", {}, defaultConfig, options or {})
  if M.config.hot_reload then
    local path = require("vhs-era-theme.lib.path")
    require("vhs-era-theme.lib.hotreload").watch(path.colors_path)
  end
end

return M
