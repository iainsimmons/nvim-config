-- Change highlights after all other plugin configs

-- Brighten the base16-vice comments from the super dark grey default
vim.api.nvim_set_hl(0, "Comment", { fg = "grey" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Change the Search and LSP References highlight
-- because the base16-vice pale yellow was hard to see the white cursor
vim.api.nvim_set_hl(0, "Search", { fg = "#22262d", bg = "#ff3d81" })
