<div align="center">

![VHS Era Logo](assets/logo.svg)

# vhs-era-theme.nvim


[![Made with love][badge-made-with-love]][contributors]
[![Development status][badge-development-status]][development-status]
[![Our manifesto][badge-our-manifesto]][our-manifesto]
![Made with lua][badge-made-with-lua]
[![Latest release][badge-latest-release]][latest-release]

[Requirements](#requirements) •
[Install](#install) •
[Screenshots][screenshots] •
[Configuration](#configuration) •
[Cache](#cache) •
[Supported Plugins](#supported-plugins)

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

This retro colorscheme for Neovim, is inspired by the aesthetics of this era.

<p></p>

![Screenshot showing TypeScript code][screenshot]

[More screenshots][screenshots]

</div>

## Requirements

> [!WARNING]
> Requires Neovim 0.11.5+.

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



[badge-made-with-lua]: https://mistweaverco.com/assets/badges/lua.svg
[badge-development-status]: https://mistweaverco.com/assets/badges/development-status.svg
[badge-our-manifesto]: https://mistweaverco.com/assets/badges/our-manifesto.svg
[badge-made-with-love]: https://mistweaverco.com/assets/badges/made-with-love.svg
[our-manifesto]: https://mistweaverco.com/manifesto
[development-status]: https://mistweaverco.com/roadmap?filter=vhs-era-theme.nvim
[contributors]: https://github.com/mistweaverco/vhs-era-theme.nvim/graphs/contributors
[logo]: assets/logo.svg
[badge-latest-release]: https://img.shields.io/github/v/release/mistweaverco/vhs-era-theme.nvim?style=for-the-badge
[latest-release]: https://github.com/mistweaverco/vhs-era-theme.nvim/releases/latest
[screenshot]: web/static/assets/screenshots/languages/typescript/snap.typescript.png
[screenshots]: https://neovim.theme.vhs-era.com/#screenshots
