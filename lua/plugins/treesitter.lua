return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function(plugin)
      -- from LazyVim:
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "diff",
        "gitignore",
        "hurl",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
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
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
        },
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require("nvim-treesitter.configs").setup(opts)
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
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      {
        "<leader>ngd",
        function()
          require("neogen").generate({})
        end,
        noremap = true,
        silent = true,
        desc = "Neogen Generate Docs",
      },
      {
        "<leader>ngf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        noremap = true,
        silent = true,
        desc = "Neogen Generate Docs - Function",
      },
      {
        "<leader>ngc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        noremap = true,
        silent = true,
        desc = "Neogen Generate Docs - Class",
      },
      {
        "<leader>ngt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        noremap = true,
        silent = true,
        desc = "Neogen Generate Docs - Type",
      },
    },
    opts = {
      snippet_engine = "luasnip",
    },
  },
}
