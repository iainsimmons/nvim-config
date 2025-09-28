return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  config = function()
    require("grug-far").setup({})
  end,
  keys = {
    {
      "<leader>fr",
      "<CMD>GrugFar<CR>",
      desc = "Find and Replace",
      mode = "n",
    },
    {
      "<leader>fr",
      "<CMD>lua require('grug-far').with_visual_selection()<CR>",
      desc = "Find and Replace Visual Selection",
      mode = "v",
    },
  },
}
