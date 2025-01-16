return {
  { -- Useful plugin to show you pending keybinds.
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
        { "<leader>b", group = "Buffer >" },
        { "<leader>c", group = "Code >" },
        { "<leader>d", group = "Debug >" },
        { "<leader>f", group = "File/Find >" },
        { "<leader>g", group = "Git >" },
        { "<leader>h", group = "Hurl >" },
        { "<leader>n", group = "Noice >" },
        { "<leader>q", group = "Quit/Session >" },
        { "<leader>r", group = "Replace >" },
        { "<leader>s", group = "Search >" },
        { "<leader>t", group = "Toggle >" },
        { "<leader>u", group = "UI >" },
        { "<leader>w", group = "Windows >" },
        { "<leader>x", group = "Diagnostics/Quickfix >" },
      })
      local presets = require("which-key.plugins.presets")
      presets.operators["d"] = nil
    end,
  },
  {
    "rasulomaroff/reactive.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("reactive").setup({
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
      Snacks.toggle({
        name = "Highlight Colors",
        get = function()
          return require("nvim-highlight-colors").is_active()
        end,
        set = function(_)
          require("nvim-highlight-colors").toggle()
        end,
      }):map([[\H]])
    end,
  },
}
