return {
  "leath-dub/snipe.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  opts = {
    ui = {
      position = "cursor",
    },
  },
}
