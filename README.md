# le-chemin.nvim 🥖

A lightweight path utility for Neovim.
Quickly copy relative or absolute paths to your clipboard with smart project-root detection.

## Introduction

While there might be a better ways to copy file paths in Neovim, this one suits my needs
perfectly and acts as a bonus introduction to custom Neovim plugins.

## 📦 Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "ireydiak/le-chemin.nvim",
    event = "VeryLazy",
    opts = {
        root_markers = { ".git", "package.json", "pyproject.toml", "Makefile" },
    },
    keys = {
        { "<leader>cp", "<cmd>LeCheminRelative<cr>", desc = "Copy Relative Path" },
        { "<leader>ca", "<cmd>LeCheminAbsolute<cr>", desc = "Copy Absolute Path" },
    },
}
```

## Development

To maintain formatting, le-chemin uses a standard Lua toolstack.

### Dev Dependencies

You will need the following tools installed on your system:
- StyLua: An opinionated Lua code formatter.
- Luacheck: A static analyzer and linter for Lua

**Installation (via Homebrew)**

```bash
brew install stylua luacheck
```

### Local tests

To test your changes locally in your own Neovim instance using lazy.nvim,
you can point the dir key to your local development folder:

```lua
{
    "ireydiak/le-chemin.nvim",
    dir = "~/path/to/le-chemin.nvim", -- Point to your local repo
    opts = { ... },
    -- ...
}
```
