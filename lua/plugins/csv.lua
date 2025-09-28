return {
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
}
