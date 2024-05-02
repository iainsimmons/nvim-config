local telescope_egrepify = function()
  require("telescope").extensions.egrepify.egrepify({
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- add this value
    },
  })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "prochri/telescope-all-recent.nvim", opts = {} },
      "piersolenski/telescope-import.nvim",
      "fdschmidt93/telescope-egrepify.nvim",
      "nvim-telescope/telescope-ui-select.nvim",

      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        dependencies = {
          "kkharji/sqlite.lua",
          "nvim-telescope/telescope-fzy-native.nvim",
        },
      },
    },
    -- change some options
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzy_native")
      telescope.load_extension("import")
      telescope.load_extension("smart_open")
      telescope.load_extension("egrepify")
      telescope.load_extension("ui-select")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        require("telescope").extensions.smart_open.smart_open({
          cwd_only = true,
          filename_first = true,
        })
      end, { noremap = true, silent = true, desc = "Telescope Smart Open" })
      vim.keymap.set(
        "n",
        "<leader><space>",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        { noremap = true, silent = true, desc = "Switch Buffer" }
      )
      vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "Find Git files" })
      vim.keymap.set("n", "<leader>fi", ":Telescope import<CR>", { desc = "[F]ind [I]mports", silent = true })
      vim.keymap.set("n", "<leader>sg", telescope_egrepify, { silent = true, desc = "Live Grep (Telescope egrepify)" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })

      vim.keymap.set("n", "<leader>st", ":Telescope colorscheme enable_preview=true<CR>", {
        silent = true,
        noremap = true,
        desc = "[S]earch [T]hemes",
      })

      telescope.setup(opts)
    end,
    opts = {
      defaults = {
        file_ignore_patterns = {
          "^static/",
          "^matrix-files/",
          "^dist/",
          "^.git/",
          "package-lock.json",
          "*.lock",
        },
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.90,
          width = 0.90,
          preview_cutoff = 0,
          horizontal = { preview_width = 0.60 },
          vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
          prompt_position = "top",
        },
        path_display = { "smart" },
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        winblend = 0,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--hidden",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- add this value
        },
      },
      pickers = {
        find_files = {
          -- Find files with Telescope, with grep, including hidden, ignoring .git
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          prompt_prefix = "󰸩 ",
        },
        commands = {
          prompt_prefix = " ",
          layout_config = {
            height = 0.63,
            width = 0.78,
          },
        },
        command_history = {
          prompt_prefix = " ",
          layout_config = {
            height = 0.63,
            width = 0.58,
          },
        },
        git_files = {
          prompt_prefix = "󰊢 ",
          show_untracked = true,
        },
        live_grep = {
          prompt_prefix = "󰱽 ",
        },
        grep_string = {
          prompt_prefix = "󰱽 ",
        },
        undo = {
          prompt_prefix = "↩ ",
        },
      },
      extensions = {
        ["zf-native"] = {
          file = { -- options for sorting file-like items
            enable = true, -- override default telescope file sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = true, -- enable zf filename match priority
          },
          generic = { -- options for sorting all other items
            enable = true, -- override default telescope generic item sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = false, -- disable zf filename match priority
          },
        },
        import = {
          -- Add imports to the top of the file keeping the cursor in place
          insert_at_top = true,
        },
        smart_open = {
          cwd_only = true,
          filename_first = true,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        egrepify = {
          prefixes = {
            -- DEFAULTS
            -- filter for file suffixes
            -- example prompt: #lua,md $MY_PROMPT
            -- searches with ripgrep prompt $MY_PROMPT in files with extensions lua and md
            -- i.e. rg --glob="*.{lua,md}" -- $MY_PROMPT
            -- ["#"] = {
            --   -- #$REMAINDER
            --   -- # is caught prefix
            --   -- `input` becomes $REMAINDER
            --   -- in the above example #lua,md -> input: lua,md
            --   flag = "glob",
            --   cb = function(input)
            --     return string.format([[*.{%s}]], input)
            --   end,
            -- },
            -- filter for (partial) folder names
            -- example prompt: >conf $MY_PROMPT
            -- searches with ripgrep prompt $MY_PROMPT in paths that have "conf" in folder
            -- i.e. rg --glob="**/conf*/**" -- $MY_PROMPT
            -- [">"] = {
            --   flag = "glob",
            --   cb = function(input)
            --     return string.format([[**/{%s}*/**]], input)
            --   end,
            -- },
            -- filter for (partial) file names
            -- example prompt: &egrep $MY_PROMPT
            -- searches with ripgrep prompt $MY_PROMPT in paths that have "egrep" in file name
            -- i.e. rg --glob="*egrep*" -- $MY_PROMPT
            -- ["&"] = {
            --   flag = "glob",
            --   cb = function(input)
            --     return string.format([[*{%s}*]], input)
            --   end,
            -- },
            -- ADDED ! to invert matches
            -- example prompt: ! sorter
            -- matches all lines that do not comprise sorter
            -- rg --invert-match -- sorter
            ["?"] = {
              flag = "hidden",
            },
          },
        },
      },
    },
  },
}
