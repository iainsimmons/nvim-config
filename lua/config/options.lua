vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir-kickstart"
vim.opt.wrap = true
vim.opt.conceallevel = 0
vim.opt.diffopt = "internal,filler,closeoff,vertical"
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Add .psv extension for Pipe Separated Values format
vim.filetype.add({
  pattern = {
    ["*.psv"] = "csv_pipe",
    ["*.csv"] = "csv_semicolon",
  },
})
