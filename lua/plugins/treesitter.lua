return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    lazy = false,
    init = function()
      local ensure_installed = {
        "astro",
        "bash",
        "css",
        "diff",
        "gitignore",
        "hurl",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsx",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "regex",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "xml",
      }
      local already_installed = require("nvim-treesitter.config").get_installed()
      local parsers_to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsers_to_install)
    end,
    config = function()
      require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      -- Enable highlighting for all filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.language.add, lang) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end,
      })

      -- Enable treesitter indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and lang ~= "ruby" and pcall(vim.treesitter.language.add, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
    config = function()
      local tsc = require("treesitter-context")
      Snacks.toggle
        .new({
          id = "treesitter_context",
          name = "Treesitter Context",
          get = tsc.enabled,
          set = function(state)
            if state then
              tsc.enable()
            else
              tsc.disable()
            end
          end,
        })
        :map([[\t]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      })

      -- select keymaps
      vim.keymap.set({ "x", "o" }, "am", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end, { desc = "method/function" })
      vim.keymap.set({ "x", "o" }, "im", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end, { desc = "method/function" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end, { desc = "class" })
      vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end, { desc = "class" })

      -- swap keymaps
      vim.keymap.set("n", "<leader>csa", function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>csA", function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
      end, { desc = "Swap previous parameter" })
      require("which-key").add({
        mode = { "n", "v" },
        { "<leader>cs", group = "+Swap", icon = " " },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "astro",
      "glimmer",
      "handlebars",
      "html",
      "javascript",
      "jsx",
      "markdown",
      "php",
      "rescript",
      "svelte",
      "tsx",
      "twig",
      "typescript",
      "vue",
      "xml",
    },
    config = true,
  },
}
