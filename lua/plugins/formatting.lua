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
      return { timeout_ms = 1000, lsp_fallback = true, quiet = true }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      less = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "markdownlint", "cbfmt" },
      ["markdown.mdx"] = { "markdownlint", "cbfmt" },
      graphql = { "prettierd", "prettier" },
      handlebars = { "prettierd", "prettier" },
      svelte = { "prettierd", "prettier" },
      xml = { "xmlformatter" },
      rss = { "xmlformatter" },
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
        require("conform").format({ async = true, timeout_ms = 1000, lsp_fallback = true })
      end,
      mode = "n",
      desc = "[F]ormat buffer",
    },
  },
}
