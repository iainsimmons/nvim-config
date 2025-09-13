return {
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
    "tzachar/highlight-undo.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
  },
}
