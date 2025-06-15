return {
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    event = { "BufNewFile", "BufReadPre" },
  },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
  {
    -- "nat-418/boole.nvim",
    "Susensio/boole.nvim", -- use fork to disable defaults
    branch = "feat-optional-defaults",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "true", "false" },
        { "yes", "no" },
        { "on", "off" },
        {
          "monday",
          "tuesday",
          "wednesday",
          "thursday",
          "friday",
          "saturday",
          "sunday",
        },
        {
          "mon",
          "tue",
          "wed",
          "thu",
          "fri",
          "sat",
          "sun",
        },
        {
          "january",
          "february",
          "march",
          "april",
          "may",
          "june",
          "july",
          "august",
          "september",
          "october",
          "november",
          "december",
        },
        {
          "jan",
          "feb",
          "mar",
          "apr",
          "may",
          "jun",
          "jul",
          "aug",
          "sep",
          "oct",
          "nov",
          "dec",
        },
      },
      defaults = false,
    },
  },
  {
    "johmsalas/text-case.nvim",
    event = { "BufNewFile", "BufReadPost" },
    config = function()
      require("textcase").setup({})
    end,
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    -- lazy = false,
  },
  {
    "tzachar/highlight-undo.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = "Rayso",
    opts = {
      open_cmd = "Arc",
      options = {
        background = true, -- If the screenshot should have a background.
        dark_mode = true, -- If the screenshot should be in dark mode.
        logging_path = "", -- Path to create a log file in.
        logging_file = "rayso", -- Name of log file, will be a markdown file, ex rayso.md.
        logging_enabled = false, -- If you enable the logging file.
        padding = 32, -- The default padding that the screenshot will have.
        theme = "raindrop", -- Theme
      },
    },
    keys = {
      {
        "<leader>cs",
        ":Rayso<cr>",
        desc = "Share with Ray.so",
        silent = true,
        mode = { "n", "v" },
      },
    },
  },
  {
    "fei6409/log-highlight.nvim",
    ft = { "log" },
    config = function()
      require("log-highlight").setup({})
    end,
  },
}
