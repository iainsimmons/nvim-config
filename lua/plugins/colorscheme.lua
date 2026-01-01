if false then
  return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  }
else
  return {
    "mistweaverco/vhs-era-theme.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      italic_comments = false,
      disable_cache = false,
      hot_reload = false,
    },
    config = function(_, opts)
      require("vhs-era-theme").setup(opts)
      vim.cmd([[colorscheme vhs-era-theme]])
    end,
  }
end
