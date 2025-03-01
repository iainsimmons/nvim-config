---@module 'snacks'
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    scope = { enabled = true },
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
    ---@class snacks.dashboard.Config
    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your curstom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
██╗ █████╗ ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║██╔══██╗██║████╗  ██║██║   ██║██║████╗ ████║
██║███████║██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██║██╔══██║██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║██║  ██║██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          local M = require("snacks").dashboard
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        {
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = vim.fn.isdirectory(".git") == 1,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 2,
        },
        { section = "startup" },
      },
    },
    picker = {
      enabled = true,
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
        },
      },
      layout = { preset = "ivy", layout = { height = 0.5 } },
      win = {
        input = {
          keys = {
            -- Close the picker on ESC instead of going normal mode
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            -- Scrolling like in LazyGit
            ["J"] = { "preview_scroll_down", mode = { "n", "i" } },
            ["K"] = { "preview_scroll_up", mode = { "n", "i" } },
            ["H"] = { "preview_scroll_left", mode = { "n", "i" } },
            ["L"] = { "preview_scroll_right", mode = { "n", "i" } },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>uh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
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
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
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
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>#t",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>#s",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- picker
    {
      "<leader>,",
      function()
        ---@class snacks.picker
        ---@field smart fun(opts?: snacks.picker.smart.Config|{}): snacks.Picker
        Snacks.picker.smart({ multi = { "buffers", "files" }, hidden = true })
      end,
      desc = "Smart Picker",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers({
          format = function(item, picker)
            local ret = {} ---@type snacks.picker.Highlight[]
            ret[#ret + 1] = { Snacks.picker.util.align(tostring(item.idx), 3), "SnacksPickerBufNr" }
            ret[#ret + 1] = { " " }
            vim.list_extend(ret, Snacks.picker.format.filename(item, picker))
            return ret
          end,
        })
      end,
      desc = "Buffers",
    },
    -- -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        ---@diagnostic disable-next-line: assign-type-mismatch
        Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fl",
      function()
        ---@class snacks.picker
        ---@field lazy fun(opts?: snacks.picker.Config|{}): snacks.Picker
        Snacks.picker.lazy()
      end,
      desc = "Find Lazy plugin spec",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files({ hidden = true })
      end,
      desc = "Find Git Files",
    },
    -- -- git
    {
      "<leader>gc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    -- -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker()
      end,
      desc = "All Pickers",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    -- { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto Type Definition",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    --
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

        local ft = vim.bo[vim.api.nvim_get_current_buf()].filetype
        if ft == "snacks_dashboard" then
          vim.b[vim.api.nvim_get_current_buf()].ministatusline_disable = true
        end

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
        Snacks.toggle.indent():map([[\I]])
        Snacks.toggle.dim():map([[\D]])
      end,
    })
  end,
}
