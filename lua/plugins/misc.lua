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
    config = function(_, opts)
      require("hurl").setup(opts)
      -- Run API request
      vim.keymap.set("n", "<leader>HA", "<cmd>HurlRunner<CR>", { desc = "Run All requests" })
      vim.keymap.set("n", "<leader>Ha", "<cmd>HurlRunnerAt<CR>", { desc = "Run Api request" })
      vim.keymap.set("n", "<leader>He", "<cmd>HurlRunnerToEntry<CR>", { desc = "Run Api request to entry" })
      vim.keymap.set("n", "<leader>Hm", "<cmd>HurlToggleMode<CR>", { desc = "Hurl Toggle Mode" })
      vim.keymap.set("n", "<leader>Hv", "<cmd>HurlVerbose<CR>", { desc = "Run Api in verbose mode" })
      -- Run Hurl request in visual mode
      vim.keymap.set("v", "<leader>Hr", ":HurlRunner<CR>", { desc = "Hurl Runner" })
    end,
  },
  {
    "fei6409/log-highlight.nvim",
    ft = { "log" },
    config = function()
      require("log-highlight").setup({})
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = "Nerdy",
    keys = {
      {
        "<leader>f,",
        ":Nerdy<CR>",
        desc = "Nerdy: Find nerd font symbols",
        silent = true,
      },
    },
  },
}
