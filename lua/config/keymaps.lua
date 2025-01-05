local map = function(mode, lhs, rhs, opts)
  local modes = type(mode) == "string" and { mode } or mode
  opts = opts or {}
  opts.silent = opts.silent ~= false

  vim.keymap.set(modes, lhs, rhs, opts)
end

--
-- [[ Moved from init.lua ]]
--

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics (Quickfix)" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--
-- [[ Stolen from LazyVim ]]
--

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer", silent = true, noremap = true })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Previous Buffer", silent = true, noremap = true })
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader><Tab>", "<cmd>b#<cr>", { desc = "Switch to Other Buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wc", "<C-W>c", { desc = "Close window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

--
-- [[ my keymaps ]]
--

map("n", "x", '"_x')

-- increment & decrement
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Reveal folder of current file
map("n", "<leader>fe", ":! open %:h<CR>", { desc = "Reveal folder of current file in Finder", silent = true })

map("n", "<leader>ga", ":! git add -f %<CR>", { desc = "[G]it [A]dd (force) current file", silent = true })

map("n", "<leader>cc", ":%y+<CR>", { desc = "[C]opy [C]urrent file", silent = true })
map("n", "<leader>cn", ":let @+=@%<CR>", { desc = "[C]opy Current file [N]ame", silent = true })

-- https://github.com/stevedylandev/dotfiles/blob/main/nvim/lua/keymaps.lua
-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
map("x", "p", '"_dP', { silent = true, noremap = true })
-- align buffer to vertical center
map("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
map("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
map("n", "n", "nzzzv", { silent = true, noremap = true })
map("n", "N", "Nzzzv", { silent = true, noremap = true })
-- Some useful quickfix shortcuts for quickfix
map("n", "<C-n>", function()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("silent! cnext")
  end
end, { silent = true, noremap = true })
map("n", "<C-p>", function()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("silent! cprev")
  end
end, { silent = true, noremap = true })
map("n", "<leader>xc", "<cmd>cclose<CR>", { silent = true, noremap = true })

-- . repeat or execute macro on all visually selected lines
-- eg. press A"<esc> on line one, select all others, press . and they all end in "
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjn1kww/
map("x", ".", ":norm .<CR>", { silent = false })
map("x", "@", ":norm @q<CR>", { silent = false })

-- Using the keymap will take the word under the cursor
-- and populate the beginning of a global search and replace command
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjojs2y/
map("n", "<leader>rw", ":%s/<C-r><C-w>/", { silent = false })
map("n", "<leader>rW", ":%s/<C-r><C-a>/", { silent = false })

-- search within selected block of code
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjym8kg/
map("x", "/", "<Esc>/\\%V", { silent = true })

map("n", "-", "<CMD>Oil --float<CR>", { desc = "Oil - Open parent directory" })

-- A couple of nice keymaps from Dev Ops Toolbox on YouTube
-- https://www.youtube.com/watch?v=x__SZUuLOxw
map("n", "E", "$", { noremap = false })
map("n", "B", "_", { noremap = false })

-- select all / entire buffer
map("n", "<leader>cv", "ggVG", { silent = true, noremap = true, desc = "[V]isual Select All" })

-- execute line as lua
map("n", "<leader>x", "<CMD>.lua<CR>", { desc = "E[X]ecute line as Lua code" })
map("v", "<leader>x", "<CMD>lua<CR>", { desc = "E[X]ecute line as Lua code" })
