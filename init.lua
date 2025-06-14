-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = false
vim.opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- additional options
require("config.options")

-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
--  moved to imported file below
require("config.keymaps")

-- [[ Autocommands ]]
require("config.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = {
    -- set to `true` to have all custom plugins lazy-loaded by default
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  install = { colorscheme = { "tokyonight-night" } },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  spec = {
    { import = "plugins" },
  },
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
    custom_keys = {
      ["<localleader>r"] = {
        function(_)
          ---@type LazyPlugin[]
          local plugins = require("lazy.core.config").plugins
          local file_content = {
            [[# iainvim: Iain Simmons' Neovim configuration

![Neovim dashboard](./iainsimmons_neovim_2025-03-25.png)
![Neovim editing](./iainsimmons_neovim_ui_2025-03-25.png)

## dotfiles

Looking for the rest of my dotfiles? You can find those over at [iainsimmons/dotfiles](https://github.com/iainsimmons/dotfiles).

## 🔧 Install instructions

> Install requires Neovim 0.11+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:iainsimmons/nvim-config ~/.config/iainsimmons/nvim-config
```

Open Neovim with this config:

```sh
NVIM_APPNAME=iainsimmons/nvim-config/ nvim
```
]],
            "## 💤 Plugin manager",
            "",
            "- [lazy.nvim](https://github.com/folke/lazy.nvim)",
            "",
            "## 🔌 Plugins",
            "",
          }
          local plugins_md = {}
          for plugin, spec in pairs(plugins) do
            if spec.url then
              table.insert(plugins_md, ("- [%s](%s)"):format(plugin, spec.url:gsub("%.git$", "")))
            end
          end
          table.sort(plugins_md, function(a, b)
            return a:lower() < b:lower()
          end)

          for _, p in ipairs(plugins_md) do
            table.insert(file_content, p)
          end

          local file, err = io.open(vim.fn.stdpath("config") .. "/README.md", "w")
          if not file then
            vim.notify("didn't work!", vim.log.levels.ERROR, {})
            error(err)
          end
          file:write(table.concat(file_content, "\n"))
          file:close()
          vim.notify("README.md succesfully generated", vim.log.levels.INFO, {})
        end,
        desc = "Generate README.md file",
      },
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
