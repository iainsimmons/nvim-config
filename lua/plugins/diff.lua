return {
  "esmuellert/vscode-diff.nvim",
  cmd = { "CodeDiff" },
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>gd", "<cmd>CodeDiff<CR>", desc = "CodeDiff", silent = true },
  },
}
