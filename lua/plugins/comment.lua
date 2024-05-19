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
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
