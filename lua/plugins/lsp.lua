return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",
      -- Allows extra capabilities provided by nvim-cmp
      -- "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map("<leader>cr", vim.lsp.buf.rename, "[R]ename")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          -- map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          --   map("<leader>uh", function()
          --     print("Inlay Hints Enabled: " .. tostring(not vim.lsp.inlay_hint.is_enabled({})))
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          --   end, "Toggle Inlay [H]ints")
          -- end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim

        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = {
                disable = { "missing-fields" },
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "nvim_bufferline", "Snacks" },
              },
            },
          },
        },
        ts_ls = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose", "yml" },
          settings = {
            yaml = {
              redhat = { telemetry = { enabled = false } },
              keyOrdering = false,
              customTags = {
                -- these are all for slumber.yml files
                -- see https://slumber.lucaspickering.me/
                "!request mapping",
                "!folder mapping",
                "!json mapping",
                "!form_urlencoded mapping",
                "!form_multipart mapping",
                "!file mapping",
                "!command mapping",
                "!env mapping",
                "!prompt mapping",
                "!select mapping",
                "!basic mapping",
                "!bearer scalar",
                "!never scalar",
                "!no_history scalar",
                "!expire scalar",
                "!always scalar",
              },
            },
          },
        },
        emmet_ls = {
          filetypes = {
            "astro",
            "css",
            "eruby",
            "handlebars",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "astro-language-server",
        "cbfmt",
        "css-lsp",
        "css-variables-language-server",
        "emmet-ls",
        "eslint-lsp",
        "glint",
        "html-lsp",
        "json-lsp",
        "kulala-fmt",
        "lemminx",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettierd",
        "shfmt",
        "stylua",
        "svelte-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
        "xmlformatter",
        "yaml-language-server",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup()

      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, {
          capabilities = capabilities,
          settings = config,
          filetypes = (config or {}).filetypes,
        })
      end
    end,
  },
  {
    "yarospace/dev-tools.nvim",
    event = "BufReadPost",
  },
}
