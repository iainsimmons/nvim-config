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
          -- TODO: figure out how to fix the LSP warnings here
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          -- TODO: figure out how to fix the LSP warnings here
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
