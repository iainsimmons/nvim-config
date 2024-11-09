return {
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
    keys = {
      {
        "[h",
        "<CMD>Gitsigns prev_hunk<CR>",
        desc = "Git: previous hunk",
      },
      {
        "]h",
        "<CMD>Gitsigns next_hunk<CR>",
        desc = "Git: next hunk",
      },
      {
        "<leader>gh",
        "<CMD>Gitsigns preview_hunk<CR>",
        desc = "[G]it Preview [H]unk",
      },
      {
        "<leader>gr",
        "<CMD>Gitsigns reset_hunk<CR>",
        desc = "[G]it [R]eset Hunk",
      },
      {
        "<leader>gs",
        "<CMD>Gitsigns stage_hunk<CR>",
        desc = "[G]it [S]tage Hunk",
      },
      {
        "<leader>gu",
        "<CMD>Gitsigns undo_stage_hunk<CR>",
        desc = "[G]it [U]ndo Stage Hunk",
      },
      {
        "<leader>ug",
        "<CMD>Gitsigns toggle_current_line_blame<CR>",
        silent = true,
        desc = "󰊢 Toggle current line blame",
      },
    },
  },
}
