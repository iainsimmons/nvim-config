return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
  opts = {
    plugins = { spelling = true },
  },
  config = function(_, opts) -- This is the function that runs, AFTER loading
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      mode = { "n", "v" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "File/Find" },
      { "<leader>g", group = "Git" },
      { "<leader>n", group = "Noice" },
      { "<leader>q", group = "Quit/Session" },
      { "<leader>r", group = "Replace", icon = " " },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Windows" },
      { "<leader>x", group = "Diagnostics/Quickfix" },
      { "<leader>#", group = "Scratch", icon = "󰙨 " },
    })
    local presets = require("which-key.plugins.presets")
    presets.operators["d"] = nil
  end,
}
