-- Change highlights after all other plugin configs

-- Brighten the base16-vice comments from the super dark grey default
vim.cmd([[highlight @comment guifg=grey]])
vim.cmd("highlight Comment guifg=grey")

-- Set transparent backgrounds in most UI areas
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=#00000000")
vim.cmd("highlight EndOfBuffer guibg=#00000000")
vim.cmd("highlight NonCodeBackground guibg=#00000000")
vim.cmd("highlight Whitespace guibg=#00000000")
vim.cmd("highlight FoldColumn guibg=#00000000")
vim.cmd("highlight Folded guibg=#00000000")
vim.cmd("highlight SignColumn guibg=#00000000")
vim.cmd("highlight CursorLine guibg=#00000000")
vim.cmd("highlight CursorLineNr guibg=#00000000")

-- Change the Search and LSP References highlight
-- because the base16-vice pale yellow was hard to see the white cursor
vim.cmd("highlight Search guifg=#22262d guibg=#ff3d81")
