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
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_dirname = false,
      show_basename = false,
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        buffer_close_icon = "",
        separator_style = "thin",
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
          }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "") .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
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
}
