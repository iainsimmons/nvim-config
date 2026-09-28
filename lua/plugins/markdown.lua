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
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    ft = { "markdown" },
    opts = {
      render_modes = true,
      completions = { lsp = { enabled = true } },
      heading = {
        position = "inline",
        width = "block",
        left_pad = 2,
        right_pad = 3,
      },
    },
  },
}
