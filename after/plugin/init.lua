-- Change highlights after all other plugin configs

-- Brighten the base16-vice comments from the super dark grey default
vim.cmd([[highlight @comment guifg=grey]])
vim.cmd("highlight Comment guifg=grey")

-- Change the Search and LSP References highlight
-- because the base16-vice pale yellow was hard to see the white cursor
vim.cmd("highlight Search guifg=#22262d guibg=#ff3d81")
