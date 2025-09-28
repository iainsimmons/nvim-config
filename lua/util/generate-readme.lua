local M = {}

function M.generate()
  local plugins = require("lazy.core.config").plugins
  local file_content = {
    [[# iainvim: Iain Simmons' Neovim configuration

![Neovim dashboard](./iainsimmons_neovim_dashboard_2025-09-28.png)
![Neovim editing](./iainsimmons_neovim_editing_2025-09-28.png)
![Neovim markdown](./iainsimmons_neovim_markdown_2025-09-28.png)

## ⚙️ dotfiles

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

## 💤 Plugin manager

- [lazy.nvim](https://github.com/folke/lazy.nvim)

## 🔌 Plugins
]],
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

  table.insert(
    file_content,
    [[

## Generating this README

To generate this file, run this util function:

```vim
:lua require("util.generate-readme").generate()
```

You should see a message "README.md successfully generated"

You can also use or change the global keymap for this:

```lua
vim.keymap.set("n", "<leader>rm", function()
  require("util.generate-readme").generate()
end, { desc = "Generate README" })
```
]]
  )

  local file, err = io.open(vim.fn.stdpath("config") .. "/README.md", "w")
  if not file then
    vim.notify("didn't work!", vim.log.levels.ERROR, {})
    error(err)
  end
  file:write(table.concat(file_content, "\n"))
  file:close()
  vim.notify("README.md successfully generated", vim.log.levels.INFO, {})
end

return M
