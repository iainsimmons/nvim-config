vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir-kickstart"
vim.opt.wrap = true
vim.opt.conceallevel = 0
vim.opt.diffopt = "internal,filler,closeoff,vertical"
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Add .psv extension for Pipe Separated Values format
vim.filetype.add({
  pattern = {
    ["*.psv"] = "csv_pipe",
    ["*.csv"] = "csv_semicolon",
  },
})

vim.diagnostic.config({ virtual_text = { current_line = true } })
