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
    },
  },
}
