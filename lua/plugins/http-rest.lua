return {
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
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      ui = {
        default_view = "headers_body",
        -- display_mode = "float",
        environment_scope = "g",
        -- show_variable_info_text = "float",
        split_direction = "horizontal",
      },
    },
  },
}
