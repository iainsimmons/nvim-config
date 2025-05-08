return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      {
        "<CR>",
        function()
          require("kulala").run()
        end,
        mode = { "n", "v" },
        ft = { "http", "rest" },
      },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      ui = {
        default_view = "headers_body",
        -- display_mode = "float",
        environment_scope = "g",
        -- show_variable_info_text = "float",
        split_direction = "horizontal",
      },
    },
  },
}
