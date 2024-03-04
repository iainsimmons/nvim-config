return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    pre_hook = function()
      if vim.bo.filetype == "hurl" then
        return "#%s"
      end
    end,
  },
}
