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
        -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
        default_view = "body",

        -- display mode: possible values: "split", "float"
        display_mode = "split",

        -- set scope for environment and request variables
        -- possible values: b = buffer, g = global
        environment_scope = "g",

        -- enable/disable request summary in the output window
        show_request_summary = false,

        -- enable/disable variable info text
        -- this will show the variable name and value as float
        -- possible values: false, "float"
        show_variable_info_text = false,

        -- split direction: possible values: "vertical", "horizontal"
        split_direction = "horizontal",
      },
    },
  },
}
