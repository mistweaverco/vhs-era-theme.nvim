local M = {}

local defaultConfig = {
  italic_comments = true,
  disable_cache = false,
  hot_reload = false,
}

M.config = defaultConfig

function M.reload()
  M.load()
end

function M.load()
  require("vhs-era-theme.colorscheme")
  vim.g.colors_name = "vhs-era-theme"
end

function M.clear_cache()
  require("vhs-era-theme.lib.cache").clear()
end

function M.setup(options)
  M.config = vim.tbl_deep_extend("force", {}, defaultConfig, options or {})
  if M.config.hot_reload then
    local path = require("vhs-era-theme.lib.path")
    require("vhs-era-theme.lib.hotreload").watch(path.palette_colors)
  end
end

return M

