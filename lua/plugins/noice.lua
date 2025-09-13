return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "mini",
      },
      signature = {
        enabled = false,
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = "mini", -- default view for messages
      view_error = "mini", -- view for errors
      view_warn = "mini", -- view for warnings
      view_history = "mini", -- view for :messages
      view_search = "mini", -- view for search count messages. Set to `false` to disable
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = "mini",
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
      {
        filter = {
          event = "notify",
          find = "Client %d+ quit with exit code 1 and signal 0",
        },
        opts = { stop = true },
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
      mini = {
        align = "center",
        position = {
          -- Centers messages top to bottom
          row = -2,
          -- Aligns messages to the far right
          col = "100%",
        },
      },
    },
  },
  keys = {
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<leader>nl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>nh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<leader>na",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<leader>nd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" },
    },
  },
}
