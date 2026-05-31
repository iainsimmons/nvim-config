return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, svg = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = "never"
      else
        lsp_format_opt = "fallback"
      end
      return { timeout_ms = 1000, lsp_format = lsp_format_opt, quiet = true }
    end,
    formatters = {
      oxfmt = {
        -- Ensure 'oxfmt' is in your PATH (e.g., installed via npm/pnpm/cargo)
        command = "oxfmt",
        -- The beta version supports stdin for seamless Neovim integration
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      vue = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      css = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      scss = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      less = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      html = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      json = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      jsonc = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      yaml = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      toml = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      markdown = { "oxfmt", "markdownlint", "cbfmt" },
      ["markdown.mdx"] = { "markdownlint", "cbfmt" },
      graphql = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      handlebars = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      svelte = { "prettierd", "prettier", stop_after_first = true },
      astro = { "prettierd", "prettier" },
      xml = { "oxfmt", "xmlformatter" },
      rss = { "oxfmt", "xmlformatter" },
      python = { "isort", "black" },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
    vim.keymap.set("n", [[\f]], function()
      if vim.g.disable_autoformat then
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify("Autoformat enabled")
      else
        vim.b.disable_autoformat = true
        vim.g.disable_autoformat = true
        vim.notify("Autoformat disabled")
      end
    end, { desc = "Toggle autoformatting" })
    require("conform").setup(opts)
  end,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, timeout_ms = 1000, lsp_format = "fallback" })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
}
