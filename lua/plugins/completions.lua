return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "MahanRahmati/blink-nerdfont.nvim",
    "bydlw98/blink-cmp-env",
  },

  -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "select_and_accept", "show_documentation", "hide_documentation" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      ["<S-j>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<A-1>"] = {
        function(cmp)
          cmp.accept({ index = 1 })
        end,
      },
      ["<A-2>"] = {
        function(cmp)
          cmp.accept({ index = 2 })
        end,
      },
      ["<A-3>"] = {
        function(cmp)
          cmp.accept({ index = 3 })
        end,
      },
      ["<A-4>"] = {
        function(cmp)
          cmp.accept({ index = 4 })
        end,
      },
      ["<A-5>"] = {
        function(cmp)
          cmp.accept({ index = 5 })
        end,
      },
      ["<A-6>"] = {
        function(cmp)
          cmp.accept({ index = 6 })
        end,
      },
      ["<A-7>"] = {
        function(cmp)
          cmp.accept({ index = 7 })
        end,
      },
      ["<A-8>"] = {
        function(cmp)
          cmp.accept({ index = 8 })
        end,
      },
      ["<A-9>"] = {
        function(cmp)
          cmp.accept({ index = 9 })
        end,
      },
      ["<A-0>"] = {
        function(cmp)
          cmp.accept({ index = 10 })
        end,
      },
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "nerdfont", "env" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        lsp = {
          transform_items = nil,
          fallbacks = {},
        },
        buffer = {
          score_offset = -2,
        },
        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
        },
        env = {
          name = "Env",
          module = "blink-cmp-env",
          score_offset = -3,
          opts = {
            item_kind = 6, -- require("blink.cmp.types").CompletionItemKind.Variable
            show_braces = false,
            show_documentation_window = true,
          },
        },
      },
      min_keyword_length = 2,
    },

    completion = {
      trigger = {
        -- When true, will show the completion window after typing a trigger character
        show_on_trigger_character = true,
        -- When both this and show_on_trigger_character are true, will show the completion window
        -- when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
        -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
        -- the completion window when the cursor comes after a trigger character when
        -- entering insert mode/accepting an item
        show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
        -- or a function, similar to show_on_blocked_trigger_character
      },
      list = {
        selection = { preselect = false, auto_insert = false },
      },
      menu = {
        border = "single",
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          treesitter = { "lsp" },
        },
      },

      -- experimental auto-brackets support
      accept = {
        auto_brackets = { enabled = false },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
        treesitter_highlighting = true,
        window = { border = "single" },
      },

      ghost_text = {
        enabled = false,
      },
    },

    signature = {
      enabled = true,
    },

    cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer", min_keyword_length = 0 }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline", min_keyword_length = 0 }
        end
        return {}
      end,
    },
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
