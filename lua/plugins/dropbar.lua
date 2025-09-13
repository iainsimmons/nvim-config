return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  lazy = false,
  opts = {
    bar = {
      sources = function()
        local sources = require("dropbar.sources")
        return { sources.path }
      end,
      update_events = {
        win = {
          "WinEnter",
          "WinResized",
        },
        buf = {
          "FileChangedShellPost",
        },
      },
    },
    icons = {
      kinds = {
        dir_icon = function()
          return nil, nil
        end,
        file_icon = function()
          return "󰈙 ", "DropBarIconKindFile"
        end,
      },
    },
    sources = {
      path = {
        max_depth = 5,
        preview = false,
        modified = function(sym)
          return sym:merge({
            name = sym.name,
            icon = "󰷈 ",
            name_hl = "MiniIconsYellow",
            icon_hl = "MiniIconsYellow",
          })
        end,
      },
    },
    symbol = {
      on_click = function() end,
    },
  },
}
