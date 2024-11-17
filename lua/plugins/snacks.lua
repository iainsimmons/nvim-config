return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    gitbrowse = {
      url_patterns = {
        ["github.com"] = {
          branch = "/tree/{branch}",
          file = "/blob/{branch}/{file}#L{line}",
        },
        ["gitlab.com"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line}",
        },
        ["gitlab.squiz.net"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line}",
        },
        ["code.squiz.net"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line}",
        },
      },
    },
  },
  keys = {
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename()
      end,
      desc = "Rename File",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.8,
          height = 0.8,
          wo = {
            spell = false,
            wrap = true,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
          keys = {
            q = "close",
          },
        })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map([[\b]])
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map([[\c]])
        Snacks.toggle.option("cursorcolumn", { name = "Cursor Column" }):map([[\|]])
        Snacks.toggle.option("cursorline", { name = "Cursor Line" }):map([[\-]])
        Snacks.toggle.option("ignorecase", { name = "Ignore Case" }):map([[\i]])
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map([[\L]])
        Snacks.toggle.option("spell", { name = "Spelling" }):map([[\s]])
        Snacks.toggle.option("wrap", { name = "Wrap" }):map([[\w]])
        Snacks.toggle.diagnostics():map([[\d]])
        Snacks.toggle.line_number():map([[\l]])
        Snacks.toggle.inlay_hints():map([[\h]])
        Snacks.toggle.treesitter():map([[\T]])
      end,
    })
  end,
}
