return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      opts = {
        enable_autocmd = false,
      },
    },
  },
  config = function()
    require("mini.ai").setup({
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      n_lines = 500,
    })

    require("mini.bracketed").setup()

    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    require("mini.operators").setup({
      -- Each entry configures one operator.
      -- `prefix` defines keys mapped during `setup()`: in Normal mode
      -- to operate on textobject and line, in Visual - on selection.

      -- Evaluate text and replace with output
      evaluate = {
        prefix = "g=",

        -- Function which does the evaluation
        func = nil,
      },

      -- Exchange text regions
      exchange = {
        prefix = "gx",

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- Multiply (duplicate) text
      multiply = {
        prefix = "gm",

        -- Function which can modify text before multiplying
        func = nil,
      },

      -- Replace text with register
      replace = {
        prefix = "gr",

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- Sort text
      sort = {
        prefix = "gs",

        -- Function which does the sort
        func = nil,
      },
    })

    require("mini.surround").setup({
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - gsd'   - [S]urround [D]elete [']quotes
      -- - gsr)'  - [S]urround [R]eplace [)] [']
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })
  end,
}
