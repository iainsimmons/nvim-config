return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      pre_hook = function()
        if vim.bo.filetype == "hurl" then
          return "#%s"
        end
      end,
    },
  },
  -- Highlight todo, notes, etc in comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
}
