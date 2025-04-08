-- https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
vim.keymap.set("i", "=", function()
  -- The cursor location does not give us the correct node in this case, so we
  -- need to get the node to the left of the cursor
  local cursor = vim.api.nvim_win_get_cursor(0)
  local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

  local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
  local nodes_active_in = {
    "attribute_name",
    "directive_argument",
    "directive_name",
  }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    -- The cursor is not on an attribute node
    return "="
  end

  return '=""<left>'
end, { expr = true, buffer = true })

vim.keymap.set("i", "/", function()
  local node = vim.treesitter.get_node()
  if not node then
    return "/"
  end

  local first_sibling_node = node:prev_named_sibling()
  if not first_sibling_node then
    return "/"
  end

  local parent_node = node:parent()
  local is_tag_writing_in_progress = node:type() == "text" and parent_node:type() == "element"

  local is_start_tag = first_sibling_node:type() == "start_tag"

  local start_tag_text = vim.treesitter.get_node_text(first_sibling_node, 0)
  local tag_is_already_terminated = string.match(start_tag_text, ">$")

  if is_tag_writing_in_progress and is_start_tag and not tag_is_already_terminated then
    local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 2), 0, 1)
    local already_have_space = char_at_cursor == " "

    -- We can also automatically add a space if there isn't one already
    return already_have_space and "/>" or " />"
  end

  return "/"
end, { expr = true, buffer = true })

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
  local snippet = string.format('<a href="">%s</a>', selected[1])

  vim.api.nvim_buf_set_text(s_pos[1], s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3], { snippet })
  vim.api.nvim_win_set_cursor(0, { s_pos[2], s_pos[3] + 8 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  vim.cmd("startinsert")
end, { desc = "Insert link" })
