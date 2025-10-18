<div align="center">

![VHS Era Logo](assets/logo.svg)

# vhs-era-theme.nvim

![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/mistweaverco/vhs-era-theme.nvim?style=for-the-badge)](https://github.com/mistweaverco/vhs-era-theme.nvim/releases/latest)

[Requirements](#requirements) • [Install](#install) • [Configuration](#configuration) • [Cache](#cache) • [Supported Plugins](#supported-plugins)

<p></p>

The VHS era,
which spanned roughly from the late 1970s to the early 2000s,
was a time when people could rent movies,
record TV shows,
and watch home videos at home using bulky magnetic tape cassettes.

This experience was defined by the ritual of trips to
video rental stores like Blockbuster,
the anticipation of recording favorite programs,
and the physical nature of tapes that had to
be rewound and could degrade over time.

<p></p>

</div>

## Requirements

> [!WARNING]
> Requires Neovim 0.10.0+.

## Install

Via [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ 'mistweaverco/vhs-era-theme.nvim' },
```
See [configuration options](#configuration) for more information.

## Configuration

```lua
{
  'mistweaverco/vhs-era-theme.nvim',
  opts = {
    italic_comments = true,
    disable_cache = false,
    hot_reload = false,
  }
},
```

## Cache

The theme is cached by default to improve performance.
If you want to disable the cache set `disable_cache` to `true`.

The cache is stored in:

- Linux: `~/.cache/nvim/vhs-era-theme`
- Windows: `~/AppData/Local/nvim/vhs-era-theme`
- MacOS: `~/.cache/nvim/vhs-era-theme`

You can remove the cache by running:

```lua
require('vhs-era-theme').clear_cache()
```

## Supported Plugins

Currently supported plugins, others might work but are not tested:

- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [copilot.vim](https://github.com/github/copliot.vim)
- [diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [diffconflicts.nvim](https://github.com/mistweaverco/diffconflicts.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [kulala.nvim](https://github.com/mistweaverco/kulala.nvim)
- [lsp-config](https://github.com/neovim/lsp-config)
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)
- [neogit](https://github.com/NeogitOrg/neogit)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [mini.indentscope](https://github.com/echasnovski/mini.indentscope)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
