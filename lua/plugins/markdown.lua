return {
  {
    "davidgranstrom/nvim-markdown-preview",
    ft = { "md", "markdown" },
    keys = {
      {
        "<leader>m",
        "<plug>(nvim-markdown-preview)",
        "n",
        desc = "Markdown Preview",
        silent = true,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "md", "markdown" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  },
}
