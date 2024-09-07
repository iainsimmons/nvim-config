return {
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    event = { "BufNewFile", "BufReadPre" },
  },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
  {
    "nat-418/boole.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      allow_caps_additions = {
        {
          "a",
          "b",
          "c",
          "d",
          "e",
          "f",
          "g",
          "h",
          "i",
          "j",
          "k",
          "l",
          "m",
          "n",
          "o",
          "p",
          "q",
          "r",
          "s",
          "t",
          "u",
          "v",
          "w",
          "x",
          "y",
          "z",
        },
      },
    },
  },
  {
    "tpope/vim-abolish",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("which-key").add({
        { "cr", group = "coercion" },
        { "cr-", desc = "Kebab Case (not reversible)" },
        { "cr.", desc = "Dot Case (not reversible)" },
        { "cr<space>", desc = "Space Case (not reversible)" },
        { "crU", desc = "Snake Upper Case" },
        { "cr_", desc = "Snake Case" },
        { "crc", desc = "Camel Case" },
        { "crk", desc = "Kebab Case" },
        { "crm", desc = "Mixed Case" },
        { "crs", desc = "Snake Case" },
        { "crt", desc = "Title Case (not reversible)" },
        { "cru", desc = "Snake Upper Case" },
      })
    end,
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
        "<leader>rs",
        ":Rayso<cr>",
        desc = "Share with Ray.so",
        silent = true,
        mode = { "n", "v" },
      },
    },
  },
  {
    "jellydn/hurl.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "split",
      -- Default formatter
      formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
      },
      env_file = {
        ".env",
      },
    },
    keys = {
      -- Run API request
      { "<leader>rA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>ra", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      { "<leader>re", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>rm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      { "<leader>rv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>rh", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
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
