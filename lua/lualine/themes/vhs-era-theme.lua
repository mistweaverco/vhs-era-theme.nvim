-- VHS Era Theme for Lualine

local t = {
  bg = "#161616",
  fg = "#f2f4f8",
  normalFG = "#f2f4f8",
  green = "#42be65",
  red = "#ff7eb6",
  purple = "#be95ff",
  blue = "#78a9ff",
  blueDark = "#33b1ff",
  cyan = "#3ddbd9",
  grey3 = "#131313",
  grey5 = "#262626",
  grey7 = "#393939",
  grey20 = "#525252",
}

return {
  normal = {
    a = { bg = t.blue, fg = t.bg },
    b = { bg = t.grey7, fg = t.fg },
    c = { bg = t.grey3, fg = t.fg },
  },
  insert = {
    a = { bg = t.green, fg = t.bg },
    b = { bg = t.grey7, fg = t.green },
    c = { bg = t.grey3, fg = t.fg },
  },
  visual = {
    a = { bg = t.purple, fg = t.bg },
    b = { bg = t.grey7, fg = t.purple },
    c = { bg = t.grey3, fg = t.fg },
  },
  replace = {
    a = { bg = t.red, fg = t.bg },
    b = { bg = t.grey7, fg = t.red },
    c = { bg = t.grey3, fg = t.fg },
  },
  command = {
    a = { bg = t.cyan, fg = t.bg },
    b = { bg = t.grey7, fg = t.cyan },
    c = { bg = t.grey3, fg = t.fg },
  },
  inactive = {
    a = { bg = t.grey20, fg = t.grey3 },
    b = { bg = t.grey5, fg = t.grey20 },
    c = { bg = t.grey5, fg = t.grey20 },
  },
}
