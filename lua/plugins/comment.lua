---@module 'snacks'
return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    -- opts = {
    --   enable_autocmd = false,
    -- },
  },
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = { signs = false },
    keys = {
      {
        "<leader>st",
        function()
          ---@class snacks.picker
          ---@field todo_comments fun(opts?: snacks.picker.Config|{}): snacks.Picker
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          ---@class snacks.picker
          ---@field todo_comments fun(opts?: snacks.picker.Config|{}): snacks.Picker
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
