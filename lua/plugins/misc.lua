return {
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    event = { "BufNewFile", "BufReadPre" },
  },
  {
    -- make Neovim's quickfix window better
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
  },
}
