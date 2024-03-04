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
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup({
        callbacks = {
          ["gitlab.squiz.net"] = require("gitlinker.hosts").get_gitlab_type_url,
          ["code.squiz.net"] = require("gitlinker.hosts").get_gitlab_type_url,
        },
      })
    end,
    keys = {
      {
        "<leader>gb",
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        "n",
        desc = "Gitlinker: Open file in browser",
        silent = true,
      },
      {
        "<leader>gb",
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        "v",
        desc = "Gitlinker: Open file in browser",
      },
      {
        "<leader>gy",
        '<cmd>lua require"gitlinker".get_repo_url()<cr>',
        "n",
        desc = "Gitlinker: Copy file URL",
        silent = true,
      },
      {
        "<leader>gY",
        '<cmd>lua require"gitlinker".get_repo_url()<cr>',
        "n",
        desc = "Gitlinker: Copy repo URL",
        silent = true,
      },
      {
        "<leader>gB",
        '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        "n",
        desc = "Gitlinker: Open repo in browser",
        silent = true,
      },
    },
  },
}
