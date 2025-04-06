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
  {
    {
      "Bekaboo/dropbar.nvim",
      -- optional, but required for fuzzy finder support
      lazy = false,
      opts = {
        bar = {
          sources = function()
            local sources = require("dropbar.sources")
            return { sources.path }
          end,
        },
        icons = {
          kinds = {
            dir_icon = function()
              return nil, nil
            end,
            file_icon = function()
              return "󰈙 ", "DropBarIconKindFile"
            end,
          },
        },
        sources = {
          path = {
            max_depth = 5,
            preview = false,
            modified = function(sym)
              return sym:merge({
                name = sym.name,
                icon = "󰷈 ",
                name_hl = "MiniIconsYellow",
                icon_hl = "MiniIconsYellow",
              })
            end,
          },
        },
        symbol = {
          on_click = function() end,
        },
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    config = function()
      -- Fold options
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup()
    end,
  },
}
