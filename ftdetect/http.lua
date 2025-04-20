vim.filetype.add({
  extension = {
    http = "http",
  },
})

local wk = require("which-key")
wk.add({
  mode = { "n", "v" },
  { "<leader>R", group = "REST (Kulala)", icon = "󱜿 " },
})
