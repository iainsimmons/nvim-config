vim.filetype.add({
  extension = {
    hurl = "hurl",
  },
})
vim.api.nvim_command("set commentstring=#%s")

local wk = require("which-key")
wk.add({
  mode = { "n", "v" },
  { "<leader>H", group = "Hurl", icon = "󰖟 " },
})
