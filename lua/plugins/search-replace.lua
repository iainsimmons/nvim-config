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
      desc = "[F]ind and [R]eplace",
      mode = "n",
    },
    {
      "<leader>fr",
      "<CMD>lua require('grug-far').with_visual_selection()<CR>",
      desc = "[F]ind and [R]eplace Visual Selection",
      mode = "v",
    },
  },
}
