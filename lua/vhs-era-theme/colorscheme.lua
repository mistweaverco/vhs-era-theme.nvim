local cache = require("vhs-era-theme.lib.cache")

local function load_colorscheme()
  local colors = {}

  if cache.exists() then
    colors = cache.read()
  else
    colors = require("vhs-era-theme.palette.colors")
    cache.write(colors)
  end

  vim.cmd("highlight clear")
  vim.cmd("set t_Co=256")

  for group, attrs in pairs(colors) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

return load_colorscheme

