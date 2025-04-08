local _should_swap = function(s_pos, e_pos)
  -- 1. If s_pos is on a line below e_pos, they are reversed.
  if s_pos[2] > e_pos[2] then
    return true
  end
  -- 2. If s_pos and e_pos are on the same line, and s_pos
  --    is in a later column, they are reversed.
  if s_pos[2] == e_pos[2] and s_pos[3] > e_pos[3] then
    return true
  end
  -- 3. If s_pos is on an earlier line than e_pos or the same line
  --    but an earlier column, they are not reversed.
  return false
end

vim.keymap.set("n", "<leader>cl", function()
  vim.api.nvim_put({ "[]()" }, "c", true, true)
  vim.cmd("startinsert")
end, { desc = "Insert link" })
vim.keymap.set("v", "<leader>cl", function()
  local s_pos = vim.fn.getpos("v")
  local e_pos = vim.fn.getpos(".")
  -- Depending on where the cursor is, s_pos may initially refer to
  -- the end of the visual selection, and e_pos may initially refer
  -- to the start. If so, we swap their values.
  if _should_swap(s_pos, e_pos) then
    s_pos, e_pos = e_pos, s_pos
  end
  local selected = vim.fn.getregion(s_pos, e_pos)
  local snippet = string.format("[%s]()", selected[1])

  vim.api.nvim_buf_set_text(s_pos[1], s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3], { snippet })
  vim.api.nvim_win_set_cursor(0, { s_pos[2], e_pos[3] + 3 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  vim.cmd("startinsert")
end, { desc = "Insert link" })
