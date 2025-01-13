return {
  {
    "mechatroner/rainbow_csv", -- modify and query CSV files
    ft = {
      "csv",
      "tsv",
      "psv",
      "csv_pipe",
      "csv_semicolon",
    },
    config = function()
      vim.g.disable_rainbow_hover = 1
      vim.keymap.set("n", "<leader>uh", function()
        if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
          if vim.api.nvim_get_var("disable_rainbow_hover") == 1 then
            vim.api.nvim_set_var("disable_rainbow_hover", 0)
          else
            vim.api.nvim_set_var("disable_rainbow_hover", 1)
          end
          vim.cmd(":ed %")
        end
      end, { desc = "RainbowCSV Toggle Hover" })
      vim.keymap.set("n", "<M-Left>", function()
        if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
          vim.cmd("RainbowCellGoLeft")
        end
      end, { desc = "RainbowCSV Cell Go Left" })
      vim.keymap.set("n", "<M-Right>", function()
        if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
          vim.cmd("RainbowCellGoRight")
        end
      end, { desc = "RainbowCSV Cell Go Right" })
      vim.keymap.set("n", "<M-Up>", function()
        if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
          vim.cmd("RainbowCellGoUp")
        end
      end, { desc = "RainbowCSV Cell Go Up" })
      vim.keymap.set("n", "<M-Down>", function()
        if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
          vim.cmd("RainbowCellGoDown")
        end
      end, { desc = "RainbowCSV Cell Go Down" })
    end,
  },
  {
    "hat0uma/csvview.nvim",
    ft = {
      "csv",
      "tsv",
      "psv",
      "csv_pipe",
      "csv_semicolon",
    },
    opts = {
      parser = {
        --- @type string | {default: string, ft: table<string,string>} | fun(bufnr:integer): string
        delimiter = {
          default = ",",
          ft = {
            tsv = "\t",
            psv = "|",
            csv_pipe = "|",
            csv_semicolon = ";",
          },
        },
      },
      view = {
        ---@type "highlight" | "border"
        display_mode = "border",
      },
    },
    config = function(_, opts)
      require("csvview").setup(opts)
      Snacks.toggle({
        name = "CSV View",
        get = function()
          return require("csvview").is_enabled(vim.api.nvim_get_current_buf())
        end,
        set = function(_)
          require("csvview").toggle()
        end,
      }):map([[\,]])
    end,
  },
}
